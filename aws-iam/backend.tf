terraform {
  cloud {
    organization = "peterdtech"
    workspaces {
      name = "aws-iam"
    }
  }

}
