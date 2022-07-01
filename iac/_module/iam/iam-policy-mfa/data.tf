data "aws_iam_policy_document" "user_basic_policy" {
  statement {
    sid       = "AllowViewAccountInfo"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListVirtualMFADevices",
    ]
  }

  statement {
    sid       = "AllowManageOwnPasswords"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}"]

    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]
  }

  statement {
    sid       = "AllowManageOwnAccessKeys"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}"]

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]
  }

  statement {
    sid       = "AllowManageOwnSigningCertificates"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}"]

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]
  }

  statement {
    sid       = "AllowManageOwnSSHPublicKeys"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}"]

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]
  }

  statement {
    sid       = "AllowManageOwnGitCredentials"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}"]

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]
  }

  statement {
    sid       = "AllowManageOwnVirtualMFADevice"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:mfa/$${aws:username}"]

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]
  }

  statement {
    sid       = "AllowManageOwnUserMFA"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}"]

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]
  }

  statement {
    sid       = "DenyAllExceptListedIfNoMFA"
    effect    = "Deny"
    resources = ["*"]

    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "iam:ChangePassword",
      "sts:GetSessionToken"
    ]

    condition {
      test     = "BoolIfExists"
      variable = "aws:ViaAWSService"
      values   = ["false"]
    }

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}