provider "aws" {
    region     = "ap-northeast-2"
}

data "terraform_remote_state" "Network" {
    backend = "s3"
    config = {
        bucket = "s3-an2-lsj-dev-terraform"
        region = "ap-northeast-2"
        key ="Network.tfstate"
        encrypt = true
    }
}

data "terraform_remote_state" "Security_Group" {
    backend = "s3"
    config = {
        bucket = "s3-an2-lsj-dev-terraform"
        region = "ap-northeast-2"
        key ="Security_Group.tfstate"
        encrypt = true
    }
}

terraform {
    required_providers{
        aws ={
            source = "hashicorp/aws"
            version = "~>4.10"
        }
    }
    backend "s3" {
        bucket = "s3-an2-lsj-dev-terraform"
        key ="Compute.tfstate"
        region = "ap-northeast-2"
        encrypt = true
    }
}