provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "sgmodule" {
  source = "./sgmodule"
}

resource "aws_instance" "ec2_graph" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  key_name = "Keypairssh"
  tags = {
    Name = "EC2 with jenkins"
  }
  vpc_security_group_ids =[module.sgmodule.sg_group_op]
  provisioner "remote-exec" { 
 inline = [ 
 "sudo yum update -y",
        "sudo yum install java-1.8.0 -y",
        "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo",
        "sudo amazon-linux-extras install epel -y",
        "sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key",
        "sudo yum install jenkins -y",
      "sudo systemctl start jenkins",
      "sudo systemctl status jenkins",
      "sleep 60",
	  "sudo cat /var/lib/jenkins/secrets/initialAdminPassword" 
 ] 
 } 
 connection { 
 type = "ssh"
 user = "ec2-user"
 private_key = file("./Keypairssh.pem") 
 host = self.public_ip 
 }
}



output "public_ip" {
  value =aws_instance.ec2_graph.public_ip
}
