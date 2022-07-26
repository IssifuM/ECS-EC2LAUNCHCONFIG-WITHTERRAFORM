# ECS-EC2LAUNCHCONFIG-WITHTERRAFORM
# AIM: 
* Provisioned some building blocks:
* a VPC with a public subnet as an isolated pool for our resources
* Internet Gateway to contact the outside world
* Security groups for RDS MySQL and for EC2s
* Auto-scaling group for ECS cluster with launch configuration
* RDS MySQL instance
* ECR container registry
* ECS cluster with task and service definition


# Consent:

This repo can be used to deploy an ECS cluster with Fargate launch type on Terraform.

# Variable.tf

Using a variable.tf file makes it easy for this project to be reaused.

* Changes can easily be made in the variable.tf. Thus, you can make changes such as CIDR values for VPC, Availability zones, Region, port app etc.
* Customize to suit your requirements.


# Prerequisites for this to work correctly:

An AWS account configured to your local envirionment.
If you are using IAM User's credential, it should have permission to make changes/manage all resources using terraform.
Terraform installed on your local machine
Visual Code installedon you machine

## Clone this Repo and Change Into That Directory

* the steps below was summarized from this link: https://techobservatory.com/how-to-clone-a-github-repository-in-visual-studio-code/ . Visit for more details.

1. Get the code of the repo use what to clone. This can either be https or ssh. Personally I prefer https.
2. open VScode.
3. Select source control.
4. elect lone repository.
5. paste https link in command pallete.
6. Select directory where you want to save your clone.
7. Click open.

# Terraform Commands and Good practices 

1. First Run 'terraform init' on terminal to initialize a working directory containing Terraform configuration files
2. use 'terraform fmt' to rewrite/ arrange the code to an Terraform standard
3. use 'terraform validate' make sure everything is valid
4. use 'terraform plan' will give tell you all the resources you are about to create
5. use 'terraform apply' to provision your resources
6. use 'terraform destroy' to destroy the resources created


# .gitignore

Use .gitignore file to ignore the secrete .tfvars file.
