provider "aws" {
    region = "us-east-2"
    access_key = ""
    secret_key = ""
	}

resource "aws_instance" "ec2" { 
  ami = "ami-0dad20bd1b9c8c004" 
  instance_type = "t2.micro" 
  security_groups = ["${aws_security_group.allow_all.name}"]
  key_name = "linuxkey"
}

resource "aws_security_group" "allow_all" {
  name        = "allow all"
  description = "allow all"

  ingress {
    from_port   = 22
    to_port     = 65535
    protocol    = "All"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 65535
    protocol        = "ALL"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "showPublicIP" {
  value = "${aws_instance.ec2.*.public_dns}"
}
