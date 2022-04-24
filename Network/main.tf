locals {
    name_tag_middle         = "an2-trp01-dev"
}

module "create-vpc" {
    source  = "./create-vpc" 
    vpcs    = [
        {
            identifier              = "public"
            name_tag_postfix        = "pub"
            vpc_cidr                = "192.168.1.0/24"
            attach_igw              = true
            enable_dns_hostname     = true
        },
        {
            identifier              = "private"
            name_tag_postfix        = "pri"
            vpc_cidr                = "192.168.2.0/24"
            attach_igw              = false
            enable_dns_hostname     = true
        }
    ]
    name_tag_middle = local.name_tag_middle
}

module "create-subnet" {
    source = "./create-subnet"
    subnets = [
        {
            identifier              = "pub-lb-a"
            name_tag_postfix        = "pub-lb-a"
            availability_zone       = "ap-northeast-2a"
            vpc_id                  = "${module.create-vpc.vpc["public"].id}"
            cidr_block              = "192.168.1.0/26"
            create_ngw              = false
        },
        {
            identifier              = "pub-lb-c"
            name_tag_postfix        = "pub-lb-c"
            availability_zone       = "ap-northeast-2c"
            vpc_id                  = "${module.create-vpc.vpc["public"].id}"
            cidr_block              = "192.168.1.64/26"
            create_ngw              = false
        },
        {
            identifier              = "pub-web-a"
            name_tag_postfix        = "pub-web-a"
            availability_zone       = "ap-northeast-2a"
            vpc_id                  = "${module.create-vpc.vpc["public"].id}"
            cidr_block              = "192.168.1.128/26"
            create_ngw              = false
        },
        {
            identifier              = "pub-web-c"
            name_tag_postfix        = "pub-web-c"
            availability_zone       = "ap-northeast-2c"
            vpc_id                  = "${module.create-vpc.vpc["public"].id}"
            cidr_block              = "192.168.1.192/26"
            create_ngw              = false
        }
    ]
    name_tag_middle = local.name_tag_middle
}

module "create-route_table" {
    source = "./create-route_table"
    rts  = [
        {
            identifier              = "pub-lb"
            name_tag_postfix        = "pub-lb"
            vpc_id                  = "${module.create-vpc.vpc["public"].id}"
            association_subnets     = ["${module.create-subnet.subnet["pub-lb-a"].id}", "${module.create-subnet.subnet["pub-lb-c"].id}"]
            attach_igw              = true
            igw_id                  = "${module.create-vpc.internet_gateway["public"].id}"
            attach_ngw              = false
            ngw_id                  = ""
        },
        {
            identifier              = "pub-web"
            name_tag_postfix        = "pub-web"
            vpc_id                  = "${module.create-vpc.vpc["public"].id}"
            association_subnets     = ["${module.create-subnet.subnet["pub-web-a"].id}", "${module.create-subnet.subnet["pub-web-c"].id}"]
            attach_igw              = false
            igw_id                  = ""
            attach_ngw              = false
            ngw_id                  = ""
        }
    ]
    name_tag_middle = local.name_tag_middle
}