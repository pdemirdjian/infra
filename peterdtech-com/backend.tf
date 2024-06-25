terraform {
  cloud {
    organization = "peterdtech"
    workspaces {
      name = "peterdtech-com"
    }
  }
}
