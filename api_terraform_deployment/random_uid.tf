resource "random_string" "uid" {
  length  = 16
  special = false
  lower   = true
  upper   = false
}