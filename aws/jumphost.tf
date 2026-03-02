resource "aws_instance" "jumphost" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.jumphost-instance-type
  key_name          = aws_key_pair.bootcamp-key.key_name

  root_block_device {
    volume_size = 50
  }

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.all-bootcamp.id, aws_security_group.external-access.id]
  associate_public_ip_address = true

  tags = {
    Name        = "Simple Jumphost"
    description = "Jumphost for Bootcamp - Managed by Terraform"
    Owner_Name  = var.owner_name
    Owner_Email = var.owner_email
    sshUser     = "ubuntu"
    region      = var.region
    cflt_environment = var.cflt_environment
    cflt_partition = var.cflt_partition
    cflt_managed_by	= var.cflt_managed_by
    cflt_managed_id	= var.cflt_managed_id
    cflt_service      = var.cflt_service
    cflt_environment  = var.cflt_environment
    cflt_keep_until   = local.keep_until_date
  }

  volume_tags = {
    cflt_partition = var.cflt_partition
    cflt_managed_by	= var.cflt_managed_by
    cflt_managed_id	= var.cflt_managed_id
    cflt_service      = var.cflt_service
    cflt_environment  = var.cflt_environment
    cflt_keep_until   = local.keep_until_date
  }
}
