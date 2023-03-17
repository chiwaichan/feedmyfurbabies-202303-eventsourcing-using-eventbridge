import boto3
import json
import os

def lambda_handler(event, context):
    print(event)
    print(os.environ['EventBusName'])

    session = boto3.session.Session()
    client = session.client(
        service_name='events',
        region_name=os.environ['AWS_REGION'],
    )

    response = client.put_events(
        Entries=[
            {
                'Source': 'com.feedmyfurbabies',
                'DetailType': 'AWS IoT 1-Click',
                'Detail': json.dumps({'click-type': event['devicePayload']['clickType']}),
                'EventBusName': os.environ['EventBusName']
            },
        ]
    )

    print(response)

    return True
