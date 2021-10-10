variable "name" {
  type        = string
  description = "Name tag"
  default     = "hello"
}

variable "environment" {
  type        = string
  description = "Environment tag"
  default     = "Development"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
  default     = "hello"
}