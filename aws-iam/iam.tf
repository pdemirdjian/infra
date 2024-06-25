resource "aws_iam_openid_connect_provider" "hcp_terraform" {
  url             = data.tls_certificate.hcp_terraform.url
  client_id_list  = [local.hcp_terraform.audience]
  thumbprint_list = [data.tls_certificate.hcp_terraform.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "hcp_terraform_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.hcp_terraform.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.hcp_terraform.hostname}:aud"
      values   = [local.hcp_terraform.audience]
    }
    condition {
      test     = "StringLike"
      variable = "${local.hcp_terraform.hostname}:sub"
      values   = ["organization:${local.hcp_terraform.organization}:project:*:workspace:*:run_phase:*"]
    }
  }

}

resource "aws_iam_role" "hcp_terraform" {
  name               = local.hcp_terraform_role_name
  assume_role_policy = data.aws_iam_policy_document.hcp_terraform_assume_role.json
}

data "aws_iam_policy_document" "hcp_terraform" {
  statement {
    sid       = "AllowS3"
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "hcp_terraform" {
  name        = "hcp_terraform"
  description = "Policy for HCP Terraform"
  policy      = data.aws_iam_policy_document.hcp_terraform.json
}

resource "aws_iam_role_policy_attachment" "hcp_terraform" {
  role       = aws_iam_role.hcp_terraform.name
  policy_arn = aws_iam_policy.hcp_terraform.arn
}
