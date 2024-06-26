resource "aws_signer_signing_profile" "profile" {
  platform_id = var.platform_id
  name        = var.signer_profile_name

  // Default valid period is 135 Months
  dynamic "signature_validity_period" {
    for_each = var.signature_validity_period
    content {
      type  = signature_validity_period.value["type"] // DAYS, MONTH, YEARS
      value = signature_validity_period.value["value"]
    }
  }

  dynamic "signing_material" {
    for_each = var.signing_material
    content {
      certificate_arn = signing_material.value["certificate_arn"]
    }
  }

  tags = var.tags
}
