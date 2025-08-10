resource "aws_iam_role" "github_actions_oidc" {
  name = "github-actions-oidc-maracanaunews"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::060605029084:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub": "repo:edmolima/maracanaunews:environment:production"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "github_actions_oidc_least_privilege" {
  name        = "github-actions-oidc-maracanaunews-least-privilege"
  description = "Least privilege policy for GitHub Actions OIDC role"
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::maracanaunews-terraform-state",
        "arn:aws:s3:::maracanaunews-terraform-state/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "lambda:GetFunction",
        "lambda:UpdateFunctionCode",
        "lambda:UpdateFunctionConfiguration",
        "lambda:ListVersionsByFunction",
        "lambda:PublishVersion",
        "lambda:CreateAlias",
        "lambda:UpdateAlias",
        "lambda:ListAliases"
      ],
      "Resource": [
        "arn:aws:lambda:us-east-1:060605029084:function:scraper-scheduler",
        "arn:aws:lambda:us-east-1:060605029084:function:scraper-worker"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ListQueues",
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage"
      ],
      "Resource": "arn:aws:sqs:us-east-1:060605029084:scraper-maracanet-queue"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:Query"
      ],
      "Resource": "arn:aws:dynamodb:us-east-1:060605029084:table/news-maracanet"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:us-east-1:060605029084:log-group:/aws/lambda/scraper-scheduler:*",
        "arn:aws:logs:us-east-1:060605029084:log-group:/aws/lambda/scraper-worker:*",
        "arn:aws:logs:us-east-1:060605029084:log-group:/aws/lambda/scraper-maracanet:*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:GetRolePolicy",
        "iam:ListAttachedRolePolicies",
        "iam:GetPolicyVersion"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:DescribeLogGroups",
        "events:DescribeRule",
        "iam:GetRole",
        "sqs:ListQueueTags",
        "dynamodb:DescribeTable",
        "dynamodb:DescribeContinuousBackups",
        "dynamodb:DescribeTimeToLive",
        "iam:ListRolePolicies",
        "iam:GetPolicy",
        "logs:ListTagsForResource",
        "events:ListTagsForResource",
        "lambda:GetFunctionCodeSigningConfig",
        "iam:ListAttachedRolePolicies",
        "iam:GetPolicyVersion"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "github_actions_oidc_least_privilege" {
  role       = aws_iam_role.github_actions_oidc.name
  policy_arn = aws_iam_policy.github_actions_oidc_least_privilege.arn
}

output "github_actions_oidc_role_arn" {
  value = aws_iam_role.github_actions_oidc.arn
}
