data "tls_certificate" "hcp_terraform" {
  url = "https://${local.hcp_terraform.hostname}"
}
