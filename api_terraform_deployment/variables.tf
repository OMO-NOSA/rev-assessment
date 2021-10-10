variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-2"
}
variable "application_count" {
  type        = number
  description = "Number of application instance"
  default     = 2
  }

variable "s3_bucket_prefix_alb_logs" {
  type        = string
  description = "Bucket Prefix"
  default     = null
}

variable "s3_bucket_name_alb_logs" {
  type        = string
  description = "Bucket name into which to store AWS NLB logs."
}
variable "vpc_id" {
  type        = string
  description = "VPC ID in which to deploy ECS Instances"
}

variable "hello_subnet_ids" {
  type        = list(string)
  description = "subject ID"
}
variable "project_name" {
    type        = string
    description = "Project name to be rendered in tags"
    default     = "hello_api"
}
variable "environment" {
    type        = string
    description = "Environment to be rendered in tags"
    default     = "Development"
}

variable "health_check_path" {
    type        = string
    description = "The default health check path"
    default     = "/"
}

variable "health_check_protocol" {
    type        = string
    description = "Protocol for the health check"
    default     = "HTTP"
}
variable "lb_name" {
    type        = string
    description = "Name of Application load balancer"
    default     = "hello"
}
variable "ecs_desired_capacity" {
  type        = number
  description = "Desired scale capacity for ecs cluster"
  default     = 1
}
variable "ecs_max_size" {
  type        = number
  description = "Auto Scaling group max size"
  default     = 1
}
variable "ecs_min_size" {
  type        = number
  description = "Auto Scaling group min size"
  default     = 1
}

variable "asg_adjustment_type" {
  type        = string
  description = "Auto Scaling group adjustment type -- Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity."
  default     = "ChangeInCapacity"  
}
variable "cluster_name" {
    type        = string
    description = "Name of cluster"
    default     = "hello-cluster"
}
variable "hello_agent_task_name" {
  type        = string
  description = "hello agent task name"
  default     = "hello agent"
}
variable "hello_task_name" {
  type        = string
  description = "hello task name"
  default     = "hello task"
}

variable "log_retention_in_days" {
  type        = number
  description = "Number of days to retain logs before deletion"
  default     = 7
}

variable "ecs_service_desired_count" {
  type        = number
  description = "Number of desired ecs service instance"
  default     = 3
}

variable "service_name" {
  type        = string
  description = "Name of running container"
  default     = "hello-operator"
}
variable "service_port" {
  type        = number
  description = "Port of running container"
  default     = 8080
}
variable "scaling_adjustment" {
  type        = number
  description = "Scaling adjustment for autoscaling group"
  default     = 3
}
variable "fargate_cpu" {
  type        = number
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 256
}
variable "fargate_memory" {
  type        = number
  description = "Fargate instance memory to provision (in MiB)"
  default     = 512
}
variable "ecs_launch_type" {
  type        = string
  description = "Determines the Infrastructure on which tasks and services are hosted"
  default     = "FARGATE"
}
variable "service_image_url" {
  type        = string
  description = "Url to the container image(Dockerhub/ECR)"
  default     = "docker.io/omojaphet/hello-api:latest"
}