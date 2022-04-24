resource "aws_route_table" "route_table_igw" {
    for_each            = { for rt in var.rts : rt.identifier => rt if rt.attach_igw == true }
    vpc_id = "${each.value.vpc_id}"
    route               {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${each.value.igw_id}"
    }
    tags                = {
        "Name" = "rt-${var.name_tag_middle}-${each.value.name_tag_postfix}"
    }
}

resource "aws_route_table" "route_table_ngw" {
    for_each            = { for rt in var.rts : rt.identifier => rt if rt.attach_ngw == true }
    vpc_id = "${each.value.vpc_id}"
    route               {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${each.value.ngw_id}"
    }
    tags                = {
        "Name" = "rt-${var.name_tag_middle}-${each.value.name_tag_postfix}"
    }
}

resource "aws_route_table_association" "route_table_association_igw" {
    for_each            = { for rt in var.rts : rt.identifier => rt if rt.attach_igw == true }
    subnet_id           = each.value.association_subnets
    route_table_id      = aws_route_table.route_table_igw["${each.value.identifier}"].id
}

resource "aws_route_table_association" "route_table_association_ngw" {
    for_each            = { for rt in var.rts : rt.identifier => rt if rt.attach_ngw == true }
    subnet_id           = each.value.association_subnets
    route_table_id      = aws_route_table.route_table_ngw["${each.value.identifier}"].id
}