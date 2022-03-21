import json
import boto3

'''
Send message to SNS topic in environment variables
'''
def lambda_handler(event, context):

    notification = "Here is the SNS notification for Lambda function tutorial."
    client = boto3.client('sns')
    response = client.publish (
        TargetArn = "<ARN of the SNS topic>",
        Message = json.dumps({'default': notification}),
        MessageStructure = 'json'
    )

    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }


