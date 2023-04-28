## Packaging Lambda Code in a Container Image

Prerequisites:

    Docker Installed
    AWS CLI Installed

1.Create a file called lambda_function.py.
In the lambda_function.py file, add the following code:

    import json

    def lambda_handler(event, context):
        message = "Hello World!"
        return {
            'statusCode': 200,
            'body': json.dumps(message)
        }

2.Save the file.

3.Create a new file called Dockerfile in your project folder.Add the following code to the Dockerfile:

    FROM public.ecr.aws/lambda/python:3.8

    COPY lambda_function.py ${LAMBDA_TASK_ROOT}

    CMD ["lambda_function.lambda_handler"]

4.Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI:

    aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com

Note: if you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.

5.Build your Docker image using the following command. For information on building a Docker file from scratch,
see the instructions here . You can skip this step if your image has already been built:

    docker build -t demo-lambda .

6.After the build is completed, Check docker images
docker images

7.tag your image so you can push the image to this repository:

    docker tag demo-lambda:latest <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com/demo-lambda:latest

8.Run the following command to push this image to your newly created AWS repository:

    docker push <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com/demo-lambda:latest

Noted: Enabling Provisioned Concurrency option can improve the overall performance by having up-to-date container images.
