resource "aws_subnet" "this" {
    for_each            = { for subnet in var.subnets : subnet.identifier => subnet}
    vpc_id              = each.value.vpc_id
    availability_zone   = each.value.availability_zone
    cidr_block          = each.value.cidr_block
    tags                = {
        "Name" = "sub-${var.name_tag_middle}-${each.value.name_tag_postfix}"
    }
}

resource "aws_eip" "this" {
    for_each            = { for subnet in var.subnets : subnet.identifier => subnet if subnet.create_ngw == true }
    vpc                 = true
    tags                = {
        "Name" = "eip-${var.name_tag_middle}-ngw"
    } 
}

resource "aws_nat_gateway" "this" {
    for_each            = { for subnet in var.subnets : subnet.identifier => subnet if subnet.create_ngw == true }
    subnet_id           = lookup(aws_subnet.this, each.value.identifier).id
    allocation_id       = lookup(aws_eip.this, each.value.identifier).id
    tags                = {
        "Name" = "ngw-${var.name_tag_middle}"
    }
}