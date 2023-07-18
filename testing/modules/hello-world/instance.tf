resource "aws_instance" "instance" {
  ami             = "ami-0d13e3e640877b0b9"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instances.name]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              python3 -m http.server 8080 &
              EOF
}

resource "aws_security_group" "instances" {
  name = "instance-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id

  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

output "instance_ip_addr" {
  value = aws_instance.instance.public_ip
}

