output "vpc_id"{
    value = module.mod_vpc.vpc_id
}

output "public_subnet_id"{
    value = module.mod_vpc.public_subnet_id
}

output "private_subnet_id"{
    value = module.mod_vpc.private_subnet_id
}

output "database_subnet_id"{
    value = module.mod_vpc.database_subnet_id
}