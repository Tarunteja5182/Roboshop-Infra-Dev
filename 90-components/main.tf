module "component"{
    for_each = var.components
    source = "../../Roboshop-infra-component"
    component = each.key
    rule_priority = each.value.rule_priority
}