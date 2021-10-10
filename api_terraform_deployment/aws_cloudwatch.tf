resource "aws_cloudwatch_log_group" "ecs" {
  name                  = "/ecs/${var.service_name}-${random_string.uid.result}"
  retention_in_days     = var.log_retention_in_days


  tags = {

    Name                = "hello API"
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }

}


resource "aws_cloudwatch_log_stream" "ecs_log_stream" {
  name                  = "${var.service_name}-log-stream-${random_string.uid.result}"
  log_group_name        = aws_cloudwatch_log_group.ecs.name
}

