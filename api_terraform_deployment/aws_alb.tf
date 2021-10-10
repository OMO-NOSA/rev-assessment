locals {
  bucket_prefix = var.s3_bucket_prefix_alb_logs != null ? var.s3_bucket_prefix_alb_logs : "aws_alb/hello/${random_string.uid.result}"
  alb_account_id = {
    "us-east-1"      = "127311923021"
    "us-east-2"      = "033677994240"
    "us-west-1"      = "027434742980"
    "us-west-2"      = "797873946194"
    "af-south-1"     = "098369216593"
    "ca-central-1"   = "985666609251"
    "eu-central-1"   = "054676820928"
    "eu-west-1"      = "156460612806"
    "eu-west-2"      = "652711504416"
    "eu-south-1"     = "635631232127"
    "eu-west-3"      = "009996457667"
    "eu-north-1"     = "897822967062"
    "ap-east-1"      = "754344448648"
    "ap-northeast-1" = "582318560864"
    "ap-northeast-2" = "600734575887"
    "ap-northeast-3" = "383597477331"
    "ap-southeast-1" = "114774131450"
    "ap-southeast-2" = "783225319266"
    "ap-south-1"     = "718504428378"
    "me-south-1"     = "076674570225"
    "sa-east-1"      = "507241528517"
    "us-gov-west-1"  = "048591011584"
    "us-gov-east-1"  = "190560391635"
    "cn-north-1"     = "638102146993"
    "cn-northwest-1" = "037604701340"
  }
}

resource "aws_lb" "hello_cluster" {
  name               = "${var.lb_name}-${random_string.uid.result}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.hello_subnet_ids

  enable_deletion_protection = false

  access_logs {
    bucket  = var.s3_bucket_name_alb_logs
    prefix  = local.bucket_prefix
    enabled = true
  }
  tags = {
    Environment = var.environment
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "allow_lb" {
  bucket = var.s3_bucket_name_alb_logs

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${local.alb_account_id[data.aws_region.current.name]}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.s3_bucket_name_alb_logs}/${local.bucket_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.s3_bucket_name_alb_logs}/${local.bucket_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${var.s3_bucket_name_alb_logs}"
    }
  ]
}

EOF

}

resource "aws_lb_target_group" "hello" {
  name                 = "${var.lb_name}-${random_string.uid.result}"
  port                 = var.service_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"

  tags = {

    Name                = "hello API"
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }
  health_check {
    protocol = var.health_check_protocol
    port     = var.service_port
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_lb.hello_cluster
  ]

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.hello_cluster.arn
  port              = var.service_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.hello.arn
    type             = "forward"
  }
}

