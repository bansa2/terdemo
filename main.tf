provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIARSJU5XXVGQUG6PVE"
  secret_key = "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"
}


/*resource "aws_elb" "bar" {
  name               = var.name
  availability_zones = var.az


  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  cross_zone_load_balancing   = true
  idle_timeout                = var.ti
  connection_draining         = true
  connection_draining_timeout = var.ti

  tags = {
    Name = "foobar-terraform-elb"
  }
}*/

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "dev" {
  ami           = "ami-0607784b46cbe5816"
  instance_type = lookup(var.instance_type,terraform.workspace)
  #count = var.istest == true ? 1 : 0
  key_name = "new"

  /*provisioner "local-exec" {
    when = destroy
    command = "echo ${aws_instance.dev.private_ip} >> pi.txt"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("./new.pem")
    host = self.public_ip
  }

  provisioner "remote-exec" {
   inline = [
     "sudo yum -y install nginx",
     "sudo systemctl nginx"
    ]
  }*/

}


variable "instance_type" {

  type = map

  default = {
    default = "t2.nano"
    ayush = "t2.micro"
    dev = "t2.large"
  }
}


/*resource "aws_iam_user" "lb"{
  for_each = toset(["user1","user2","user3"])
  name = each.key
}



resource "aws_instance" "prod"{
  ami                     = "var.az[count.index]"
  instance_type           = var.it
  count = var.istest == false ? 1 : 0
  
}

resource "aws_eip" "lb" {
    vpc = true
}


resource "aws_eip_association" "ab"{
  instance_id   = aws_instance.are.id
  allocation_id = aws_eip.lb.id
}*/
/*variable "sg_port" {
  type        = list(number)
  default     = [6000, 8500, 7400, 6200]
  description = "description"
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0a499c70c034a4f97"

  dynamic "ingress" {
    for_each = var.sg_port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}*/