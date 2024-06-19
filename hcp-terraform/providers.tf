terraform {
  required_version = "~> 1.8"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.56"
    }
  }
}

provider "tfe" {
  hostname     = "app.terraform.io"
  organization = local.organization
}
