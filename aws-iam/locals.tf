locals {
  hcp_terraform = {
    hostname     = "app.terraform.io"
    audience     = "aws.workload.identity"
    organization = "peterdtech"
  }
  hcp_terraform_role_name = "hcp_terraform"
}
