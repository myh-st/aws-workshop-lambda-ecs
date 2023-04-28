## Packaging Lambda Code in a Container Image

Prerequisites:

    Docker Installed
    AWS CLI Installed

1.Create a folder and file, file called lambda_function.py. 
- Right click -> New folder (Name the folder as you want) 
- Right click New file on your folder (Name the file lambda_function.py)

<img width="300" alt="image" src="https://user-images.githubusercontent.com/37788058/235100697-880c10f7-4adc-4609-901f-91c263b9e725.png">

<img width="400" alt="image" src="https://user-images.githubusercontent.com/37788058/235101707-d48b00d9-3159-4cea-8a2a-b906e5e91aab.png">

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

<img width="600" alt="image" src="https://user-images.githubusercontent.com/37788058/235102855-716c5394-ee2d-4c88-b6ae-1f79ae277fbe.png">

4.Goto AWS Elastic Container Registry (ECR) service,Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI:

<img width="560" alt="image" src="https://user-images.githubusercontent.com/37788058/235103247-d45942fd-0d3c-4c54-947e-ff3097cc7128.png">

- Click Create Repository

<img width="600" alt="image" src="https://user-images.githubusercontent.com/37788058/235103730-95966ea2-d61c-431c-95c3-5b1f0bcfac99.png">

- Select visibility setttings -> Private
- Name the repository name ex : lambda-container

<img width="650" alt="image" src="https://user-images.githubusercontent.com/37788058/235104234-f41b1ae1-0775-46c4-aac3-e9a8694e5b98.png">

- Click to Enable image scan

<img width="600" alt="image" src="https://user-images.githubusercontent.com/37788058/235104775-bcc2d882-e37e-49c7-8397-4f948e43d788.png">

<img width="600" alt="image" src="https://user-images.githubusercontent.com/37788058/235104634-269e15d4-a9f5-4297-a2f9-35a1682476a5.png">

- Click View push commands or Click lambda-container (your private repository name)

![image](https://user-images.githubusercontent.com/37788058/235105381-48fee29a-3c05-439c-ba46-44991c50bbd3.png)

- Use the following steps to authenticate and push an image to your repository. For additional registry authentication methods

![image](https://user-images.githubusercontent.com/37788058/235105832-f1dd2f0b-7021-47db-8db0-c3a1772d6fad.png)

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
