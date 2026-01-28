# tasks_completed
tasks for pp assessment

# PP Assessment

## Overview
A monitoring and automation solution that identifies web application performance issues and automatically remediates them.

## Repository Structure
```
├── sumo_logic_query.txt    # Log query for detecting slow response times
├── lambda_function/        # Python Lambda function for automated remediation
│   └── lambda_function.py
├── terraform/              # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── README.md
```

## Components

### Part 1: Sumo Logic Query
Query to detect `/api/data` endpoint response times exceeding 3 seconds, with alerting for repeated occurrences.

### Part 2: AWS Lambda Function
Python function that automatically restarts an EC2 instance and sends notifications when triggered by the alert.

### Part 3: Terraform Configuration
Infrastructure as Code to deploy all required AWS resources with least privilege IAM policies.

## Deployment
```bash
cd terraform
terraform init
terraform validate
```

## Screen Recordings
- [All Recordings](https://drive.google.com/drive/folders/12vQ5VTYj-qjBGDTVZQzMRJFHAAhvZO60?usp=share_link)

