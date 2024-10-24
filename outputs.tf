provider "aws" {
  region = "us-east-1"
}

# Allocate an Elastic IP
resource "aws_eip" "my_eip" {
  vpc = true
}

# Conditional logic: only create EC2 if EIP is created
resource "aws_instance" "my_ec2_instance" {
  count = length(aws_eip.my_eip.id) > 0 ? 1 : 0
  
  ami           = "ami-06b21ccaeff8cd686"  
  instance_type = "t2.micro"               
  key_name      = "limon"                  

  subnet_id = "subnet-05e1200ddbfdceae9"
  vpc_security_group_ids = ["sg-0966c3082e96a18ec"]
  
  associate_public_ip_address = false  # Disable default public IP since we are assigning EIP
  
  tags = {
    Name = "my-ec2-instance"
  }

  depends_on = [aws_eip.my_eip]  # Make sure EC2 is created only after EIP
}

# Associate the Elastic IP to the EC2 instance if created
resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.my_ec2_instance.id
  allocation_id = aws_eip.my_eip.id

  depends_on = [aws_instance.my_ec2_instance]  # Ensure the EC2 instance exists before associating
}

output "instance_id" {
  value = aws_instance.my_ec2_instance.id
  depends_on = [aws_instance.my_ec2_instance]
}

output "public_ip" {
  value = aws_eip.my_eip.public_ip
  depends_on = [aws_eip.my_eip]
}
