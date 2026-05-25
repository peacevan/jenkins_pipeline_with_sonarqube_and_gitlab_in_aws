output "instance_id" {
	description = "ID of the GitLab EC2 instance"
	value       = aws_instance.new_ec2_gitlab.id
}

output "public_ip" {
	description = "Public IP of the GitLab EC2 instance"
	value       = aws_instance.new_ec2_gitlab.public_ip
}

output "security_group_id" {
	description = "Security group created for GitLab"
	value       = aws_security_group.security_group_gitlab.id
}
