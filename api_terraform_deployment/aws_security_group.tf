resource "aws_security_group" "alb" {
  name          = "${var.service_name}_lb_sg_${random_string.uid.result}"
  description   = "Allow traffic meant for ALB"
  vpc_id        = var.vpc_id

  tags = {
    Name                = "hello API"
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }

}


resource "aws_security_group_rule" "https" {

  type              = "egress"
  description       = "Rule for ALB"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "service_port" {
  type              = "ingress"
  description       = "Rule for ALB"
  from_port         = var.service_port
  to_port           = var.service_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

 
resource "aws_security_group_rule" "http" {
  type              = "egress"
  description       = "Rule for ALB"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}
 
  
resource "aws_security_group" "ecs_scg" {
  name          = "${var.service_name}_ecs_sg_${random_string.uid.result}"
  description   = "Allow traffic meant from ALB to ECS"
  vpc_id        = var.vpc_id

  tags = {

    Name                = "Hello API"
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }

}

resource "aws_security_group_rule" "https_traffic" {

  type              = "egress"
  description       = "Rule for ECS"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_scg.id
}

resource "aws_security_group_rule" "service_port_traffic" {
  type                      = "ingress"
  description               = "Rule for ECS"
  from_port                 = var.service_port
  to_port                   = var.service_port
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.alb.id
  security_group_id         = aws_security_group.ecs_scg.id
}

 
resource "aws_security_group_rule" "http_traffic" {
  type              = "egress"
  description       = "Rule for ECS"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_scg.id
}