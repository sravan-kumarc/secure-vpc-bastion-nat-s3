output "vpc_id" {
  value = aws_vpc.main.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_ec2_id" {
  value = aws_instance.private_ec2.id
}
