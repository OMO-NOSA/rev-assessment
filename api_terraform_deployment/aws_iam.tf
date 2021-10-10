data "aws_iam_policy_document" "ec2_hello_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "hello_execution_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "ecs_hello_execution_role-${random_string.uid.result}"
  assume_role_policy = data.aws_iam_policy_document.hello_execution_role_policy.json
}

resource "aws_iam_role" "ec2_hello_agent" {
  name               = "ec2_hello_agent-${random_string.uid.result}"
  assume_role_policy = data.aws_iam_policy_document.ec2_hello_agent.json
}

resource "aws_iam_role_policy_attachment" "ec2_hello_agent" {
  role       = aws_iam_role.ec2_hello_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_instance_profile" "ec2_hello_agent" {
  name = "ecs-hello-agent-${random_string.uid.result}"
  path = "/"
  role = aws_iam_role.ec2_hello_agent.name
}

