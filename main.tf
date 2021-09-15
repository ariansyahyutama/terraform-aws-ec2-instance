resource "aws_ebs_volume" "volume" {
  availability_zone = var.availability_zone #"ap-southeast-1a"
  size              = var.size #8
  type              = var.type #"gp3"   
  tags              = var.tags
}

resource "aws_instance" "web" {
  ami               = var.ami_id #"ami-0a2232786115639d7"
  instance_type     = var.instance_type #"t2.micro"
  availability_zone = var.availability_zone
  subnet_id         = var.subnet_id #element(module.vpc.private_subnets, 0)

  tags = {
    Name = "HelloWorld"
  }
}
#ami winserver2019 base >> ami-0a2232786115639d7

/*
locals {
  multiple_instances = {
    one = {
      instance_type     = "t3.micro"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          throughput  = 200
          volume_size = 50
          tags = {
            Name = "my-root-block"
          }
        }
      ]
    }
    two = {
      instance_type     = "t3.small"
      availability_zone = element(module.vpc.azs, 1)
      subnet_id         = element(module.vpc.private_subnets, 1)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      ]
    }
    three = {
      instance_type     = "t3.medium"
      availability_zone = element(module.vpc.azs, 2)
      subnet_id         = element(module.vpc.private_subnets, 2)
    }
  }
}

module "ec2_multiple" {
  source = "../../"

  for_each = local.multiple_instances

  name = "${local.name}-multi-${each.key}"

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = each.value.instance_type
  availability_zone      = each.value.availability_zone
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [module.security_group.security_group_id]

  enable_volume_tags = false
  root_block_device  = lookup(each.value, "root_block_device", [])

  tags = local.tags
}

*/