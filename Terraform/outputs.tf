output "ec2_instance_id" {
    description = ID of the EC2 instance"
    value       = aws_instance.web_server.id
}

output "sns_topic_arn" {
    description = "ARN of the SNS topic"
    value       = aws_ sns_topc.alerts.arn
}

output "lambda_function_name {
    description = " The name of the Lambda function"
    value       = aws_lambda_function.restart_instance.function_name
}

# If I were to validate the terraform
 # cd terraform
# terraform init
# terraform validate