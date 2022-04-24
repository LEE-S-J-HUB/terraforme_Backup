variable "name_tag_middle" {
    type        = string
}

variable "subnets" {
    type = list(object({
        identifier              = string
        name_tag_postfix        = string
        availability_zone       = string
        vpc_id                  = string
        cidr_block              = string
        create_ngw              = bool
    }))
}