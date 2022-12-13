resource "aws_lambda_function" "lambda" {
  function_name = "lambda-${var.base_name}"
  role          = aws_iam_role.lambda_svc.arn
  description   = var.lambda_description

  reserved_concurrent_executions = -1 # default -1 : no concurrency limit. 0 : disable lambda from triggered

  publish = false

  architectures = ["x86_64"] # x86_64 or arm64
  memory_size   = 256        # MB. default 128

  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  ephemeral_storage {
    size = 512 # MB. default 512. Up to 10240. (10GB)
  }

  environment {
    variables = var.environment_variables
  }

  # Runtime
  runtime = var.runtime # Available value ref : https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime
  handler = var.handler # Function entrypoint
  timeout = 10          # default 3s

  # About EFS
  #  file_system_config {
  #    arn              = ""
  #    local_mount_path = ""
  #  }

  #  dead_letter_config {
  #    target_arn = ""
  #  }

  # About X-ray
  #  tracing_config {
  #    mode = "" # PassThrough or Archive
  #  }

  # Source from
  filename = null
  #  package_type = "ZIP"       # ZIP or Image
  #  s3_bucket         = aws_s3_bucket.lambda_source_archive.bucket
  #  s3_key            = var.source_path == "" ? var.source_file : "${var.source_path}/${var.source_file}"
  #  s3_object_version = var.object_version
}