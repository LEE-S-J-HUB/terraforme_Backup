resource "aws_vpc" "this" {
    for_each                = { for vpc in var.vpcs : vpc.identifier => vpc }
    cidr_block              = each.value.vpc_cidr
    enable_dns_hostnames    = each.value.enable_dns_hostname
    tags                    = {
        "Name" = "vpc-${var.name_tag_middle}-${each.value.name_tag_postfix}"
    }
}

resource "aws_internet_gateway" "this" {
    for_each            = { for vpc in var.vpcs : vpc.identifier => vpc if vpc.attach_igw == true  }
	vpc_id              = lookup(aws_vpc.this, "${each.value.identifier}").id
    tags                = {
        "Name" = "igw-${var.name_tag_middle}-${each.value.name_tag_postfix}"
    }
}
