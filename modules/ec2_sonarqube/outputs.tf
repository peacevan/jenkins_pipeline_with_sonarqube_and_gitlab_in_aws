output "instance_id" {
  description = "ID of the SonarQube EC2 instance"
  value       = aws_instance.new_ec2_sonarqube.id
}

output "public_ip" {
  description = "Public IP of the SonarQube EC2 instance"
  value       = aws_instance.new_ec2_sonarqube.public_ip
}

output "security_group_id" {
  description = "Security group created for SonarQube"
  value       = aws_security_group.security_group_sonarqube.id
}
