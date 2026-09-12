# AWS 3-Tier Architecture with Terraform

 A secure and highly available **3-tier AWS architecture** provisioned entirely with Terraform.

 The project separates the application into web, application, and database layers, providing controlled traffic flow, network isolation, scalability, and reliability across multiple Availability Zones.

 ## Architecture

![alt text](<highly available 3-tier AWS architecture.png>)

 ## How It Works

 Users access the application through the web layer, where incoming traffic is distributed across the available web servers.

 The web layer communicates with the private application layer, which handles the application workload and connects to the database when required.

 The database remains isolated from direct public access, while the overall infrastructure can scale and recover automatically as demand changes.

 ## Project Structure

```
├── provider.tf
├── variables.tf
├── vpc.tf
├── nat-gateway.tf
├── security-groups.tf
├── key-pair.tf
├── ami.tf
├── launch-templates.tf
├── target-groups.tf
├── load-balancers.tf
├── autoscaling.tf
├── rds.tf
├── outputs.tf
└── terraform.tfvars
```

 ## Requirements

 - AWS Account
- AWS CLI
- Terraform
- Configured AWS credentials

```
terraform version
aws sts get-caller-identity
```

 ## Configuration

 Set the required values in `terraform.tfvars`.

```
aws_region   = "us-east-1"
project_name = "project"

db_password = "your-secure-password"
```

 Keep sensitive configuration and private keys out of version control.

 ## Deployment

 Initialize Terraform:

```
terraform init
```

 Format and validate:

```
terraform fmt
terraform validate
```

 Review the changes:

```
terraform plan
```

 Deploy the infrastructure:

```
terraform apply
```

 Get the application endpoint:

```
terraform output web_alb_dns_name
```

 ## Cleanup

 Remove the infrastructure when it is no longer needed:

```
terraform destroy
```

 ## Purpose

 This project demonstrates how **Terraform can be used to build and manage a secure, scalable, and highly available AWS environment as code**.