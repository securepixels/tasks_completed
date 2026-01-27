provider "aws" {
    region = var.aws_region
}
resource "aws_sns_topic" "alerts" {
    name = "ec2-restart-alerts
}

resource "aws_instance" web_server" {
    ami              = var.ami_id
    instance_type    = var.instance_type

    tags = {
        Name = "monitored-web-server"
    }
}

resource "aws_iam_role" "lambda_role" {
    name = "lambda-ec2-restart-role"

    assume_role_policy = jsonencode({
        Version = 2011-9-17"
        Statement = [{
            Action = "sts.AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com
            }
        }]
    })
}

resource = "aws_iam_role_policy" "lambda_policy" {
    name = lambda-ec2-restart-policy"
    role =  aws_iam_role.lambda_role.id

    policy = jsonencode({
        Version = 2011-9-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "ec2:RebootInstances"
            ]
            Resource = aws_instance.web_server.arn
        },
        {
            Effect = "Allow"
            Action = [
                "logs: CreateLogGroup",
                "logs: CreateLogStream",
                "logs: PutLogEvents"
            ]
            Resource = "arn:aws:logs :*:*:*
        }
        }]
    })
}

resource "aws_lambda_function "restart_instance" {
    filename        = "lambda_function.zip"
    function_name   = "ec2-restart-fuction"
    role            = aws_iam_role.lambda_role.arn
    handler         = "lambda_function.lambda.handler"
    runtime         = "python3.9"
    source_code_hash = filebash64sha256("lambda_function.zip)

    environment {
        variables = {
            EC2_INSTANCE_ID = aws_instance.web_server.id
            SNS_TOPIC_ARN   = aws_sns_topic.alerts.arn
        }
    }
}