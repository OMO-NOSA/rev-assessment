resource "aws_s3_bucket" "logs" {
  bucket        = "tf-aws-hello-api-${random_string.uid.result}"
  force_destroy = true

  tags = {
    Name                = "Apache hello"
    Environment         = var.environment
    TerraformWorkspace  = terraform.workspace
    TerraformModule     = basename(abspath(path.module))
    TerraformRootModule = basename(abspath(path.root))
  }
  
}