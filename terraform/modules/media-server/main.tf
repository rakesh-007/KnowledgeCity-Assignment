resource "aws_instance" "media_server" {
  ami           = "ami-xxxxxxxxxxxx" # Use an appropriate Linux AMI
  instance_type = "t3.medium"
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y python3
              pip3 install cryptography
              EOF

  tags = {
    Name = "${var.environment}-media-server"
  }
}

resource "aws_security_group" "media_server_sg" {
  name        = "${var.environment}-media-server-sg"
  description = "Allow traffic for Media Server"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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

output "media_server_public_ip" {
  value = aws_instance.media_server.public_ip
}
