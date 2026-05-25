
resource "aws_instance" "new_ec2_docker" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name  = var.key_name
  subnet_id =  var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.security_group_docker.id]
  associate_public_ip_address = true
  user_data = "../data/data_docker.sh" 
  tags = {
    Name = "new_ec2_docker"
  }
}

/* NOTE: As regras abaixo permitem acesso amplo (0.0.0.0/0) para fins de laboratório.
  Em produção, restrinja `cidr_blocks` para uma lista segura ou use variáveis. */
resource "aws_security_group" "security_group_docker" {
  name        = "permitir_ssh_docker"
  description = "Permite SSH e HTTP na instancia EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 8085
    to_port     = 8085
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
    Name = "security_group_docker"
  }
}