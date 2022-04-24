variable "rts" {
    type = list(object({
        identifier              = string
        name_tag_postfix        = string
        vpc_id                  = string
        association_subnets     = list(string)
        attach_igw              = bool
        igw_id                  = string
        attach_ngw              = bool
        ngw_id                  = string
    }))
}


variable "name_tag_middle" {
    type        = string
}