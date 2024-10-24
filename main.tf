provider "aws" {
  region = "us-east-1" 
}


resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-06b21ccaeff8cd686"  
  instance_type = "t2.micro"               
  key_name      = "limon"                 

  subnet_id = "subnet-05e1200ddbfdceae9"

  vpc_security_group_ids = ["sg-0966c3082e96a18ec"]

  tags = {
    Name = "my-ec2-instance"  
  }
  associate_public_ip_address = true
}

output "instance_id" {
  value = aws_instance.my_ec2_instance.id
}

output "public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}
