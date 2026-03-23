data "aws_ssm_parameter" "certificate_arn"{
    name = "/${local.project}/${local.environment}/certificate_ran"
}

data "aws_cloudfront_cache_policy" "cachingdisabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "cachingoptimized" {
  name = "Managed-CachingOptimized"
}