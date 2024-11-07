resource "aws_lambda_function" "lambda" {
  function_name = var.name
  role          = aws_iam_role.lambda.arn
  description   = var.description

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
  runtime = var.runtime
  handler = var.handler
  timeout = 10 # default 3s

  # Source from
  filename     = "lambda_function.zip"
  package_type = "Zip" # Zip or Image
  #  s3_bucket         = aws_s3_bucket.lambda_source_archive.bucket
  #  s3_key            = var.source_path == "" ? var.source_file : "${var.source_path}/${var.source_file}"
  #  s3_object_version = var.object_version

  lifecycle {
    ignore_changes = [source_code_hash]
  }
}