#######################-Get Output IP Bastion Host-#######################
output "public_ip_bation_host" {
    value = aws_eip.eip.public_ip
}

#######################-Get Output IP Private Server-#######################
output "private_ip_server" {
    value = aws_instance.apache_server.private_ip
}

#######################-Get Output IP Nat Gateway-#######################
output "public_ip_nat_gateway" {
    value = aws_eip.nat_eip.public_ip
}