resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role_arn
  filename      = var.filename
  source_code_hash = filebase64sha256(var.filename)
  timeout       = var.timeout
  memory_size   = var.memory_size
  environment {
    variables = var.environment_variables
  }
  depends_on = [aws_cloudwatch_log_group.this]
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention
}
