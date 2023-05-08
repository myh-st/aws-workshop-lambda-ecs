## <img align="left" alt="AWS Copilot CLI" src="../site/content/assets/images/copilot-logo-48-light.svg" width="85" /> AWS Copilot CLI

###### _Build, Release and Operate Containerized Applications on AWS._

![latest version](https://img.shields.io/github/v/release/aws/copilot-cli)
[![Join the chat at https://gitter.im/aws/copilot-cli](https://badges.gitter.im/aws/copilot-cli.svg)](https://gitter.im/aws/copilot-cli?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

- **Documentation**: [https://aws.github.io/copilot-cli/](https://aws.github.io/copilot-cli/)

The AWS Copilot CLI is a tool for developers to build, release and operate production-ready containerized applications
on AWS App Runner or Amazon ECS on AWS Fargate.

Use Copilot to:

- Deploy production-ready, scalable services on AWS from a Dockerfile in one command.
- Add databases or inject secrets to your services.
- Grow from one microservice to a collection of related microservices in an application.
- Set up test and production environments, across regions and accounts.
- Set up CI/CD pipelines to release your services to your environments.
- Monitor and debug your services from your terminal.

<p align="center">
    <img alt="init" src="../site/content/assets/images/init-cropped.gif" width="600"/>
</p>

## Installation

To install with homebrew:

```sh
brew install aws/tap/copilot-cli
```

To install manually, we're distributing binaries from our GitHub releases:

<details>
  <summary>Instructions for installing Copilot for your platform</summary>

| Platform           | Command to install                                                                                                                                                                 |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| macOS              | `curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-darwin && chmod +x copilot && sudo mv copilot /usr/local/bin/copilot && copilot --help`      |
| Linux x86 (64-bit) | `curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux && chmod +x copilot && sudo mv copilot /usr/local/bin/copilot && copilot --help`       |
| Linux (ARM)        | `curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux-arm64 && chmod +x copilot && sudo mv copilot /usr/local/bin/copilot && copilot --help` |
| Windows            | `Invoke-WebRequest -OutFile 'C:\Program Files\copilot.exe' https://github.com/aws/copilot-cli/releases/latest/download/copilot-windows.exe`                                        |

</details>

## Getting started

Create an IAM User to Configure AWS CLI
AWS CLI requires access key and secret key to configure it and to use the aws services on command line. So let’s create a new user in the aws account to get the access key and secret key. Follow these steps to create an IAM user to configure aws cli.

Login to the AWS management console and search IAM in the search bar and click on Users section.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749367-6f30ca1f-4ca1-4532-b2b3-401bf97f1333.png">

Click on Add Users to create a new user.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749392-9ccd6295-a6d8-4924-8d0f-499e1d67b97a.png">

Provide the user name, here we have the username as `cli_user`. Then click on Next.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749412-5ec3d2ee-d2f5-4d22-9ec1-51b14604f308.png">

We need to fill the details in the Set permissions tab. Here select the policy name as `AdministratorAccess` and then click on next.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749452-46cfd5c2-c3ff-447d-84eb-87f8faf0c7cc.png">

Now, we need to review the provided details and finally click on `Create User` button.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749469-b855f265-b5c3-4095-9a24-3a3611d040fc.png">

Now you can see that our `cli_user` is created and listed under the list of IAM users. Now, click on the username we created, here `cli_user`.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749502-3a636fb3-04eb-441e-bcba-116cb6692196.png">

Now, under the Security Credentials tab, we will find the Create access Key button, click on it.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749521-f698541a-fd85-432e-9e93-a183a38141b6.png">

You are redirected to new page, here select the Command Line Interface option, and then click on Next.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749549-6dd79e85-7919-4006-8f21-931e3b028cf6.png">

Add a description tag on the next page and click the Create Access Key button.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749573-cf91e138-6751-4095-a0f3-66f36b172f81.png">

A green notification message confirms the successful creation of Access Key. Copy the Access key ID and the Secret Access Key we will be using this while connecting our command line to the AWS account.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749599-ab6a0320-fee9-4d36-b231-b3b6e13afe0c.png">

Open your command prompt and run the command `aws configure`. When prompted, paste the copied AWS Access Key ID and the Secret Access Key, and other things can be left as default by just hitting enter.

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236749972-a31c286d-b82b-496d-a85e-c00416e2b5e2.png">

Make sure you have the AWS command line tool installed and have already run `aws configure` before you start.

or

    export AWS_ACCESS_KEY_ID=<<Access-Id>>
    export AWS_SECRET_ACCESS_KEY=<<Secret-Key>>
    export AWS_DEFAULT_REGION=ap-southeast-1
    
To get a sample app up and running in one command, run the following:

```sh
copilot init --app demo                 \
 --name web-login                       \
 --type 'Load Balanced Web Service'     \
 --dockerfile './Dockerfile'            \
 --deploy
```

<img width="828" alt="image" src="https://user-images.githubusercontent.com/37788058/236747819-3b066576-f4a1-4850-b086-47a0dd2c9394.png">

Click Link to access your service

<img width="674" alt="image" src="https://user-images.githubusercontent.com/37788058/236748076-dccdc349-2bee-475d-8023-c584eed5a962.png">

<img width="674" alt="image" src="https://user-images.githubusercontent.com/37788058/236748200-fc416946-af91-480e-963b-b84f735ab94c.png">

## To delete all services created with AWS Copilot

To delete all services created with AWS Copilot using the Copilot CLI, you can use the following steps:

1. Open a terminal window and navigate to the directory containing your Copilot application.

2. Now, you can see the list of services running based on the Dockerfile provided.

- Run the command `copilot app ls` to see the list of apps running.
- Run the command `copilot svc ls` to see the services running.
- Run the command `copilot env ls` to see the environments being used.
- Run the command `copilot svc status` to see the status of the service running here on our demoapp.

<img width="674" alt="image" src="https://user-images.githubusercontent.com/37788058/236748950-48841920-b7a7-4f6a-bdbf-faa75dfbe5d1.png">

<img width="674" alt="image" src="https://user-images.githubusercontent.com/37788058/236748644-9937eb28-d8fe-4920-abf4-5a3b6914328f.png">

## To delete all services created with AWS Copilot using the script

    sh copilot_cleanup.sh

Note that when you delete services using the Copilot CLI, the associated CloudFormation stack is also deleted, which includes the resources created for the service. Be sure to review the resources being deleted before confirming the deletion to avoid accidentally deleting resources you still need.

This will create a VPC, Application Load Balancer, an Amazon ECS Service with the sample app running on AWS Fargate.
This process will take around 8 minutes to complete - at which point you'll get a URL for your sample app running! 🚀

## Learning more

Want to learn more about what's happening? Check out our documentation [https://aws.github.io/copilot-cli/](https://aws.github.io/copilot-cli/) for a getting started guide, learning about Copilot concepts, and a breakdown of our commands.
