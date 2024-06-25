resource "tfe_workspace" "hcp_terraform" {
  name         = "hcp-terraform"
  organization = local.organization
}

resource "tfe_workspace_settings" "hcp_terraform" {
  workspace_id   = tfe_workspace.hcp_terraform.id
  execution_mode = "local"
}

resource "tfe_workspace" "peterdemirdjian_com" {
  name         = "peterdemirdjian-com"
  organization = local.organization
}

resource "tfe_workspace" "peterdtech_com" {
  name         = "peterdtech-com"
  organization = local.organization
}

resource "tfe_variable" "enable_aws_provider_auth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.peterdtech_com.id
}

resource "tfe_variable" "hcp_terraform_role_name" {
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = data.terraform_remote_state.aws_iam.outputs.peterdtech_com_aws_auth_hcp_terraform_role_arn
  category     = "env"
  workspace_id = tfe_workspace.peterdtech_com.id

}


resource "tfe_workspace" "aws_iam" {
  name                      = "aws-iam"
  organization              = local.organization
  remote_state_consumer_ids = [tfe_workspace.hcp_terraform.id]
}

resource "tfe_workspace_settings" "aws_iam" {
  workspace_id   = tfe_workspace.aws_iam.id
  execution_mode = "local"
}

import {
  id = "ws-ZUB4W9wyarcy7weK"
  to = tfe_workspace.hcp_terraform
}
