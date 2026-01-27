import boto3
import logging
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client('ec2')
sns = boto3.client('sns')

def lambda_hander(event,context):
    instance_id = os.environ.get('EC2_INSTANCE_ID')
    sns_topic_arn = os.environ.get('SNS_TOPIC_ARN')
    try:
        logger.info(f"Restarting EC2 instance: {instance_id}")
        ec2.reboot_instances(InstanceIds=[instance_id])
        logger.info(f"Successfully restarted our EC2 instance: {instance_id}")
        message = f"Alert: Our EC2 instance {instance_id} was automatically restarted."
        sns.publish(
            TopicArn=sns_topic_arn,
            Message=message,
            Subject="EC2 Instance Restart"
        )
        logger.info("SNS notification was sent")
        return {
            'statusCode': 200,
            'body': f"Instance {instance_id} restarted notification was submitted."
        }
    except Exception as e:
        logger.error(f"Error: {str(e)}")
        return {
            "statusCode": 500,
            'body': f"Error restarting instance: {str(e)}"
        }
        