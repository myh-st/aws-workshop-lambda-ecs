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

    CMD ["lambda_function.handler"]

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

- Use the following steps to authenticate and push an image to your repository. For additional registry authentication methods (copy and paste in cloud9 console 4  steps

![image](https://user-images.githubusercontent.com/37788058/235105832-f1dd2f0b-7021-47db-8db0-c3a1772d6fad.png)

5.Goto Cloud9 console run command line below, Make sure replace cd (YOUR FOLDER NAME) and replace <AWSaccountID> to your AWS account id

    ls
    cd lambda-lab03 #Your folder name
    aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com

<img width="1024" alt="image" src="https://user-images.githubusercontent.com/37788058/235107625-e4aee9cd-9d4d-4201-a754-8ea416f8e0bd.png">

Note: if you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.

5.Build your Docker image using the following command. For information on building a Docker file from scratch,
see the instructions here . You can skip this step if your image has already been built:

    docker build -t lambda-container .

6.After the build is completed, Check docker images
docker images

7.tag your image so you can push the image to this repository:

    docker tag lambda-container:latest <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com/lambda-container:latest

8.Run the following command to push this image to your newly created AWS repository:

    docker push <AWSaccountID>.dkr.ecr.ap-southeast-1.amazonaws.com/lambda-container:latest

![image](https://user-images.githubusercontent.com/37788058/235109147-aa4f67af-272a-442f-8709-6ae08c3d0128.png)

9.Goto ECS console

<img width="738" alt="image" src="https://user-images.githubusercontent.com/37788058/235109420-01c2349f-d17a-4287-af77-c6bc8f53fc44.png">

- Click on Refresh. The containers you push will appear on this page.

<img width="732" alt="image" src="https://user-images.githubusercontent.com/37788058/235109555-4477a6af-1b16-4066-9955-ff5cc6f9c29a.png">

10.Goto Lambda

<img width="693" alt="image" src="https://user-images.githubusercontent.com/37788058/235110051-fcd463da-f4d3-49ae-93bf-d995fb3ac91d.png">

- Click on Create Function

<img width="714" alt="image" src="https://user-images.githubusercontent.com/37788058/235110241-b853329c-cdc4-498f-9a13-563d079993b5.png">

- Select Container image
    
<img width="843" alt="image" src="https://user-images.githubusercontent.com/37788058/235110930-c9672dc0-baa1-4623-b945-26f5841b221f.png">

- Enter a Function name
- Click Browse images

![image](https://user-images.githubusercontent.com/37788058/235111666-b4b2dae7-c783-49c5-af6f-90bc08bead28.png)

- Select the repository
- Select image tag
- Click on Select image

![image](https://user-images.githubusercontent.com/37788058/235111486-8f227d1a-958b-41c6-a329-f080ec200d05.png)

![image](https://user-images.githubusercontent.com/37788058/235112194-8c1e7264-f65d-4e3a-9265-a63ec9f4bac9.png)

- Click on Create function
    
![image](https://user-images.githubusercontent.com/37788058/235112600-640028ca-6a14-4aef-90f7-0a2dba9d3767.png)

<img width="876" alt="image" src="https://user-images.githubusercontent.com/37788058/235112733-39773b03-7087-4ce2-863b-9ab00c75981a.png">

<img width="873" alt="image" src="https://user-images.githubusercontent.com/37788058/235112793-ea5bbb18-ee9b-4b3b-b0f7-41e2259872bc.png">

- Scoll down, Click on Test menu
    
<img width="866" alt="image" src="https://user-images.githubusercontent.com/37788058/235112942-58355d20-b3cc-4d72-bf7a-28584cd83fb2.png">

- Enter a Event Name 
- Click on Save
- Click on Test

<img width="841" alt="image" src="https://user-images.githubusercontent.com/37788058/235114771-5da31500-9b7c-4a88-b08e-c0ca19b0dc15.png">

    
Noted: Enabling Provisioned Concurrency option can improve the overall performance by having up-to-date container images.
