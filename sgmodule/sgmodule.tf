provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_security_group" "allow_remote" {
  name= "allow_ssh"

ingress { 
    description = "TCP from VPC"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
 } 
 ingress { 
    description = "SSH into VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
 } 
 egress { 
    description = "Outbound Allowed"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
 }
}

output "sg_group_op"{
    value = aws_security_group.allow_remote.id
}