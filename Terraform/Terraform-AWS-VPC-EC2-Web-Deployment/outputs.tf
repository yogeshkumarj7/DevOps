output "vpc_id" {
  description = "The ID of the deployed VPC."
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet where the EC2 instance resides."
  value       = aws_subnet.public.id
}

output "instance_public_ip" {
  description = "The Public IP address of the Amazon Linux EC2 instance."
  value       = aws_instance.web_server.public_ip
}

output "ssh_access_command" {
  description = "Suggested command to SSH into the Amazon Linux instance (User: ec2-user)."
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.web_server.public_ip}"
}
