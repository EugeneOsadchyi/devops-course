output "vpc_id" {
  description = "DevOps Course VPC ID"
  value       = aws_vpc.devops_course.id
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = [aws_subnet.public.id]
}
