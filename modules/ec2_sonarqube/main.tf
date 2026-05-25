resource "aws_instance" "new_ec2_sonarqube" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name = var.key_name
  subnet_id = var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.security_group_sonarqube.id]
  associate_public_ip_address = true
  user_data = "../data/data_sonarqube.sh"
  tags = {
    Name = "new_ec2_sonarqube"
  }
}

resource "aws_eip" "sonarqube_eip" {
  instance = aws_instance.new_ec2_sonarqube.id
}

resource "aws_security_group" "security_group_sonarqube" {
  name        = "permitir_ssh_sonarqube"
  description = "Permite SSH e HTTP na instancia SonarQube"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  ingress {
    description = "SonarQube HTTP"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidrs
  }

  tags = {
    Name = "security_group_sonarqube"
  }
}
