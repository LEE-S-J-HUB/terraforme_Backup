variable "name_tag_middle" {
    type        = string
}

variable "sgs" {
    type = list(object({
        identifier          = string
        vpc_id              = string
        name                = string
    }))
}

variable "ingress_policy_list" {
    type    = list(object({
        policy_type                 = string
        identifier                  = string
        security_group_identifier   = string
        from_port                   = number
        to_port                     = number
        protocol                    = string
        cidr_blocks                 = list(string)
        source_security_group_id    = string
        description                 = string
    }))
}

variable "egress_policy_list" {
    type    = list(object({
        policy_type                 = string
        identifier                  = string
        security_group_identifier   = string
        from_port                   = number
        to_port                     = number
        protocol                    = string
        cidr_blocks                 = list(string)
        source_security_group_id    = string
        description                 = string
    }))
}