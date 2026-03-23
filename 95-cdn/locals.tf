locals{
    project = "roboshop"
    environment = "dev"
    common_tags={
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
    origin_id = "frontend-${local.project}-${local.environment}.${var.domain_name}"
    certificate_arn = data.aws_ssm_parameter.certificate_arn.value
    cachingdisabled = data.aws_cloudfront_cache_policy.cachingdisabled.id
    cachingoptimized = data.aws_cloudfront_cache_policy.cachingoptimized.id
}