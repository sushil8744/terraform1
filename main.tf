provider "aws" {
    access_key = var.access
    secret_key = var.secret
    region = "us-east-1"
}
resource "aws_instance" "myinstance" {
 count = 4
 ami = "ami-084568db4383264d4"
 
 instance_type = "t2.micro"
 key_name = "myawskey"
 
 tags = {
    Name = "web-${count.index}"
 }  

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = file("/home/sushil/sk/myawskey.pem")

  }
  provisioner "file" {
    source = "/home/sushil/Terraform/file.txt"
    destination = "/home/ubuntu/file.txt"
  }
  provisioner "remote-exec" {
    inline = ["mkdir india"]
  }
  provisioner "local-exec" {
    command = "echo hello ${self.public_ip} > xyz.txt"

  }
}

   
                    