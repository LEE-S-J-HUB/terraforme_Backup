locals {
    name_tag_middle         = "an2-trp01-dev"
}

module "create-security_group" {
    source = "./create-security_group"
    sgs = [
        {
            identifier = "bestion"
            vpc_id = data.terraform_remote_state.Network.outputs.vpc["public"].id
            name = "bestion"
        },
        {
            identifier = "web"
            vpc_id = data.terraform_remote_state.Network.outputs.vpc["public"].id
            name = "web"
        }
    ]
#   policy_type : aws_security_group_rule 구분을 위한 필수 항목
#   cidr_blocks
#   source_security_group_id
    ingress_policy_list = [
        {
            policy_type                         = "cidr_blocks"
            identifier                          = "bestion-10022"
            security_group_identifier           = "bestion"
            from_port                           = 10022
            to_port                             = 10022
            protocol                            = "TCP"
            cidr_blocks                         = ["0.0.0.0/0"]
            source_security_group_id            = ""
            description                         = "all"
        },
        {
            policy_type                         = "cidr_blocks"
            identifier                          = "bestion-22"
            security_group_identifier           = "bestion"
            from_port                           = 22
            to_port                             = 22
            protocol                            = "TCP"
            cidr_blocks                         = ["0.0.0.0/0"]
            source_security_group_id            = ""
            description                         = "all"
        },
        {
            policy_type                         = "source_security_group_id"
            identifier                          = "web-80"
            security_group_identifier           = "web"
            from_port                           = 80
            to_port                             = 80
            protocol                            = "TCP"
            cidr_blocks                         = [""]
            source_security_group_id            = "bestion"
            description                         = "all"
        }
    ]
    egress_policy_list = [
        {
            policy_type                         = "cidr_blocks"
            identifier                          = "bestion-0" 
            security_group_identifier           = "bestion"
            from_port                           = 0
            to_port                             = 0
            protocol                            = "-1"
            cidr_blocks                         = ["0.0.0.0/0"]
            source_security_group_id            = ""
            description                         = "all"
        },
        {
            policy_type                         = "cidr_blocks"
            identifier                          = "web-0" 
            security_group_identifier           = "web"
            from_port                           = 0
            to_port                             = 0
            protocol                            = "-1"
            cidr_blocks                         = ["0.0.0.0/0"]
            source_security_group_id            = ""
            description                         = "all"
        }
    ]
	name_tag_middle = local.name_tag_middle
}
