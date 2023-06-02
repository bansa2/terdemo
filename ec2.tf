resource "aws_instance" "myec2"{
    ami = "ami-0607784b46cbe5816"
    instance_type = var.inty
}