import json
import boto3
import os

sns_topic_arn = os.environ["SNS_TOPIC_ARN"]
sns_topic_name = os.environ["SNS_TOPIC_NAME"]

"""
Send message to SNS topic in environment variables
"""


def lambda_handler(event, context):
    notification: str = "Hello world!"
    client = boto3.client("sns")
    response = client.publish(
        TargetArn=sns_topic_arn,
        Message=notification
    )

    return {"statusCode": 200, "body": json.dumps(response)}
