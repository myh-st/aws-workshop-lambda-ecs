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

Make sure you have the AWS command line tool installed and have already run `aws configure` before you start.

To get a sample app up and running in one command, run the following:

```sh
copilot init --app demo                 \
 --name web-login                       \
 --type 'Load Balanced Web Service'     \
 --dockerfile './Dockerfile'            \
 --deploy
```

## To delete all services created with AWS Copilot

To delete all services created with AWS Copilot using the Copilot CLI, you can use the following steps:

1. Open a terminal window and navigate to the directory containing your Copilot application.

2. Run the command below to list all services (svc) in your application (app) list all your application.

```sh
copilot svc ls
copilot app ls
```

3. Run the command below followed by the name of the service to delete each service.

```sh
copilot svc delete
copilot app delete
```

For example:

```sh
copilot svc delete myservice
copilot app delete myservice
```

4. Repeat step 3 for each service you want to delete.

5. Once all services have been deleted, you can also delete the associated resources such as load balancers, target groups, and security groups by running the appropriate `copilot` commands.

For example, to delete the load balancer associated with a service named "myservice", you can run the command

```sh
copilot svc status -n myservice
```

to get the load balancer name, then run the command

```sh
copilot app delete-lb -n myservice-lb
```

to delete it.

Note that when you delete services using the Copilot CLI, the associated CloudFormation stack is also deleted, which includes the resources created for the service. Be sure to review the resources being deleted before confirming the deletion to avoid accidentally deleting resources you still need.

This will create a VPC, Application Load Balancer, an Amazon ECS Service with the sample app running on AWS Fargate.
This process will take around 8 minutes to complete - at which point you'll get a URL for your sample app running! 🚀

## Learning more

Want to learn more about what's happening? Check out our documentation [https://aws.github.io/copilot-cli/](https://aws.github.io/copilot-cli/) for a getting started guide, learning about Copilot concepts, and a breakdown of our commands.
