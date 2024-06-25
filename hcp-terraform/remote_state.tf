data "terraform_remote_state" "aws_iam" {
  backend = "remote"

  config = {
    organization = local.organization
    workspaces = {
      name = "aws-iam"
    }
  }
}
