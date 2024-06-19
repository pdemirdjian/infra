terraform {
  cloud {
    organization = "peterdtech"
    workspaces {
      name = "hcp-terraform"
    }
  }
}