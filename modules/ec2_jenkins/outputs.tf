output "instance_id" {
	description = "ID of the Jenkins EC2 instance"
	value       = aws_instance.new_ec2_jenkins.id
}

output "public_ip" {
	description = "Public IP of the Jenkins EC2 instance"
	value       = aws_instance.new_ec2_jenkins.public_ip
}

output "security_group_id" {
	description = "Security group created for Jenkins"
	value       = aws_security_group.security_group_jenkins.id
}
