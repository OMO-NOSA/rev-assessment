output "cluster_id" {
    value = aws_ecs_cluster.hello.id
    description = "Cluster ID for the hello instances"
}
output "cluster_name" {
    value = aws_ecs_cluster.hello.name
    description = "Name of the hello Cluster"
}
output "hello_alb_id" {
    value = aws_lb.hello_cluster.id
    description = "ID of the hello ALB"
}

output "service_url" {
    value = "${aws_lb.hello_cluster.dns_name}:${var.service_port}"
    description = "service_url"
}

