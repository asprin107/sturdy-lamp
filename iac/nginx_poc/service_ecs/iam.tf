# TODO IAM Role (task)
# TODO IAM Role Policy (task)

# TODO IAM Role (task execution)
# TODO IAM Role Policy (task execution)

resource "aws_iam_role" "nginx_task_execution" {
  assume_role_policy = data.aws_iam_policy_document.ecs_task_sts.json
}
resource "aws_iam_role" "nginx_task" {
  assume_role_policy = data.aws_iam_policy_document.ecs_task_sts.json
}

#resource "aws_iam_role_policy" "nginx" {
#  policy = ""
#  role   = ""
#}
#resource "aws_iam_role_policy" "task_execution" {
#  policy = ""
#  role   = ""
#}