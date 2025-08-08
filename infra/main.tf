terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  backend "s3" {
    bucket = "maracanaunews-terraform-state"
    key    = "maracanaunews/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

# AWS Provider
provider "aws" {
  region = var.aws_region
}

# Secure SQS queue policy

data "aws_caller_identity" "current" {}

locals {
  sqs_queue_arn = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:scraper-maracanet-queue"
}

data "aws_iam_policy_document" "sqs_secure_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.arn]
    }
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [local.sqs_queue_arn]
  }
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [local.sqs_queue_arn]
  }
}

# SQS Queue Module
module "sqs" {
  source = "./modules/sqs"
  name   = "scraper-maracanet-queue"
  policy = data.aws_iam_policy_document.sqs_secure_policy.json
}

# DynamoDB Table Module
module "dynamodb" {
  source        = "./modules/dynamodb"
  name          = "news-maracanet"
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "id"
  hash_key_type = "S"
}

# CloudWatch Log Group Module
module "cloudwatch" {
  source            = "./modules/cloudwatch"
  name              = "/aws/lambda/scraper-maracanet"
  retention_in_days = 1
}

# EventBridge Rule for Scheduler Lambda
module "eventbridge" {
  source              = "./modules/eventbridge"
  name                = "scraper-scheduler-rule"
  description         = "Schedule rule for scraping scheduler Lambda"
  schedule_expression = "rate(1 hour)"
  target_arn          = module.lambda_scheduler.arn
}

# IAM Role for Scheduler Lambda
module "iam_scheduler" {
  source        = "./modules/iam"
  name          = "scraper-scheduler-role"
  inline_policy = data.aws_iam_policy_document.scheduler_policy.json
}

data "aws_iam_policy_document" "scheduler_policy" {
  statement {
    actions = [
      "sqs:SendMessage"
    ]
    resources = [module.sqs.this_arn]
  }
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/scraper-scheduler:*"]
  }
}

# Lambda Scheduler
module "lambda_scheduler" {
  source                = "./modules/lambda"
  function_name         = "scraper-scheduler"
  handler               = "index.handler"
  runtime               = "nodejs18.x"
  role_arn              = module.iam_scheduler.arn
  filename              = "../lambdas/scheduler.zip" # Path to deployment package
  timeout               = 30
  memory_size           = 128
  environment_variables = {
    SQS_QUEUE_URL = module.sqs.this_url
  }
  log_retention         = 1
}

# Allow EventBridge to invoke the scheduler Lambda
resource "aws_lambda_permission" "allow_eventbridge_scheduler" {
  statement_id  = "AllowExecutionFromEventBridge${replace(timestamp(), ":", "-")}"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_scheduler.name
  principal     = "events.amazonaws.com"
  source_arn    = module.eventbridge.this_rule_arn
  depends_on    = [module.lambda_scheduler, module.eventbridge]
}

# IAM Role for Worker Lambda
module "iam_worker" {
  source        = "./modules/iam"
  name          = "scraper-worker-role"
  inline_policy = data.aws_iam_policy_document.worker_policy.json
}

data "aws_iam_policy_document" "worker_policy" {
  statement {
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:Query"
    ]
    resources = [module.dynamodb.arn]
  }
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/scraper-worker:*"]
  }
  statement {
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [module.sqs.this_arn]
  }
}

# Lambda Worker
module "lambda_worker" {
  source                = "./modules/lambda"
  function_name         = "scraper-worker"
  handler               = "index.handler"
  runtime               = "nodejs18.x"
  role_arn              = module.iam_worker.arn
  filename              = "../lambdas/worker.zip" # Path to deployment package
  timeout               = 30
  memory_size           = 128
  environment_variables = {
    DYNAMODB_TABLE = module.dynamodb.name
    SQS_QUEUE_URL  = module.sqs.this_url
  }
  log_retention         = 1
}
