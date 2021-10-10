module "hello" {
  source = "../../"
  vpc_id                        = data.aws_vpc.default.id
  hello_subnet_ids              = tolist(data.aws_subnet_ids.default.ids)
  s3_bucket_name_alb_logs       = aws_s3_bucket.logs.id
  cluster_name                  = var.cluster_name
  
}

