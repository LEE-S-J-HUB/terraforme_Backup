output "vpc" {
    value = module.create-vpc.vpc
}

output "igw" {
    value = module.create-vpc.internet_gateway
}


output "subnet" {
    value = module.create-subnet.subnet
}

output "nat_gateway" {
    value = module.create-subnet.nat_gateway
}

output "route_table" {
    value = module.create-route_table
}