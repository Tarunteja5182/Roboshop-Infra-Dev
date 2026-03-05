module "mod_vpc"{
    source = "../../terraform-aws-vpc"
    project = local.project
    environment = local.environment
}