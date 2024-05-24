resource "aws_instance" "database" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.database-instance-type
  key_name          = aws_key_pair.bootcamp-key.key_name

  root_block_device {
    volume_size = 50
  }

  subnet_id = aws_subnet.bootcamp-private-subnet[0].id
  vpc_security_group_ids = [aws_security_group.all-bootcamp.id]
  associate_public_ip_address = true

  tags = {
    Name        = "Simple Database Host"
    description = "Database host for Bootcamp - Managed by Terraform"
    Owner_Name  = var.owner_name
    Owner_Email = var.owner_email
    sshUser     = "ubuntu"
    region      = var.region
  }
}
