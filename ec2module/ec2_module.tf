provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

variable "sg_id" {
}
variable "ec2_name" {  
}
resource "aws_instance" "ec2_graph" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  key_name = "KeypairUI"
  tags = {
    Name = var.ec2_name
  }
  vpc_security_group_ids =[var.sg_id]
}
output "ec2_instanceid" {
value = aws_instance.ec2_graph.id
}