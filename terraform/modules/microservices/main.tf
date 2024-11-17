resource "aws_instance" "clickhouse_instance" {
  ami           = "ami-xxxxxxxxxxxx" # Use an appropriate Linux AMI
  instance_type = "t3.medium"
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y epel-release
              sudo yum install -y clickhouse-server clickhouse-client
              sudo systemctl start clickhouse-server
              sudo systemctl enable clickhouse-server
              EOF

  tags = {
    Name = "${var.environment}-clickhouse"
  }
}

resource "aws_security_group" "clickhouse_sg" {
  name        = "${var.environment}-clickhouse-sg"
  description = "Allow traffic for ClickHouse microservice"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8123
    to_port     = 8123
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "clickhouse_public_ip" {
  value = aws_instance.clickhouse_instance.public_ip
}
