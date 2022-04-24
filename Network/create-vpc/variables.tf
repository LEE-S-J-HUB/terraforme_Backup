variable "name_tag_middle" {
    type        = string
}

variable "vpcs"{
    type = list(object({
        identifier              = string
        name_tag_postfix        = string
        vpc_cidr                = string
        attach_igw              = bool
        enable_dns_hostname     = bool
    }))
}