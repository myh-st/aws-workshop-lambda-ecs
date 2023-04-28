import json

def lambda_handler(event, context):
    message = "Hello World! Test Lambda container"
    return {
        'statusCode': 200,
        'body': json.dumps(message)
    }
