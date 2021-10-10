[
  {
    "name": "${service_name}",
    "image": "${service_image_url}",
    "portMappings": [
      {
        "containerPort": ${service_port}
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/${service_name}",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    }
  }
]