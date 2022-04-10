# TODO IAM Role (task)
# TODO IAM Role Policy (task)

# TODO IAM Role (task execution)
# TODO IAM Role Policy (task execution)

resource "aws_iam_role" "nginx_task_execution" {
  assume_role_policy  = data.aws_iam_policy_document.task_execution_trust.json
  managed_policy_arns = [aws_iam_policy.task_execution.arn]
  name                = "nginx_task_execution_role"
}
resource "aws_iam_role" "nginx_task" {
  assume_role_policy  = data.aws_iam_policy_document.task_execution_trust.json
  managed_policy_arns = [aws_iam_policy.nginx.arn]
  name                = "nginx_task_role"
}

resource "aws_iam_policy" "nginx" {
  policy = data.aws_iam_policy_document.nginx_task_permissions.json
  name   = "nginx_task_permission"
}
resource "aws_iam_policy" "task_execution" {
  policy = data.aws_iam_policy_document.task_execution_permissions.json
  name   = "ecs_task_execution_permissions"
}