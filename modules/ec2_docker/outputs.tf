output "instance_id" {
	description = "ID of the Docker EC2 instance"
	value       = aws_instance.new_ec2_docker.id
}

output "public_ip" {
	description = "Public IP of the Docker EC2 instance"
	value       = aws_instance.new_ec2_docker.public_ip
}

output "security_group_id" {
	description = "Security group created for Docker"
	value       = aws_security_group.security_group_docker.id
}
