Packaging Lambda Code in a Container Image
------------------------------------------

1.  Create a Dockerfile for your application image or utilize a pre-built image with required language, tools and dependencies.
2.  Install/update any required packages, copy files, and ensure the ENTRYPOINT is defined correctly.
3.  Build and tag the container image using Docker build command and push it to your preferred registry.
4.  Go to AWS Lambda console, create a new Lambda function and select the `Container image` option.
5.  Provide necessary resource details such as VPC, Security Group, and Execution Role.
6.  Select the version of the container image from the ECR repository and complete the setup.


Creating a Sample Lambda Function
Open your preferred code editor.
Create a new project folder and navigate to it in your terminal or command prompt.
Create a file called lambda_function.py.
In the lambda_function.py file, add the following code:

    import json

    def lambda_handler(event, context):
        message = "Hello World!"
        return {
            'statusCode': 200,
            'body': json.dumps(message)
        }

Save the file.

Packaging Lambda Code in a Container Image

Prerequisites:

    Docker Installed
    AWS CLI Installed

Create a new file called Dockerfile in your project folder.

Add the following code to the Dockerfile:

    FROM public.ecr.aws/lambda/python:3.8

    COPY lambda_function.py ${LAMBDA_TASK_ROOT}

    CMD ["lambda_function.lambda_handler"]


Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI:

    aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com
    
Note: if you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.

Build your Docker image using the following command. For information on building a Docker file from scratch, 
see the instructions here . You can skip this step if your image has already been built:

    docker build -t demo-lambda .
    
After the build is completed, tag your image so you can push the image to this repository:

    docker tag demo-lambda:latest <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com/demo-lambda:latest
    
Run the following command to push this image to your newly created AWS repository:

    docker push <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com/demo-lambda:latest

Note: Enabling Provisioned Concurrency option can improve the overall performance by having up-to-date container images.
