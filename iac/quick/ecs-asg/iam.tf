resource "aws_iam_role" "ecs_task_execution" {
  assume_role_policy  = data.aws_iam_policy_document.task_execution_trust.json
  managed_policy_arns = [aws_iam_policy.task_execution.arn]
  name                = "${local.naming_convention}-task_execution_role"
}
resource "aws_iam_role" "ecs_task" {
  assume_role_policy  = data.aws_iam_policy_document.task_execution_trust.json
  managed_policy_arns = [aws_iam_policy.task.arn]
  name                = "${local.naming_convention}-task_role"
}

resource "aws_iam_policy" "task" {
  policy = data.aws_iam_policy_document.task_permissions.json
  name   = "${local.naming_convention}-task_permission"
}
resource "aws_iam_policy" "task_execution" {
  policy = data.aws_iam_policy_document.task_execution_permissions.json
  name   = "${local.naming_convention}-task_execution_permissions"
}


resource "aws_iam_role" "codedeploy-ecs" {
  assume_role_policy  = data.aws_iam_policy_document.codedeploy-ecs-trust.json
  managed_policy_arns = [data.aws_iam_policy.codedeploy.arn]
  name                = "${local.naming_convention}-codedeploy"
}