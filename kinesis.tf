# resource "aws_kinesis_stream" "cat_feeder_stream" {
#   name             = "cat-feeder"
#   shard_count      = 1
#   retention_period = 24

#   stream_mode_details {
#     stream_mode = "PROVISIONED"
#   }

#   tags = {
#     Environment = "cat-feeder"
#   }
# }

# resource "aws_kinesis_firehose_delivery_stream" "cat_feeder_kinesis_firehose_delivery_stream" {
#   name        = "cat_feeder_kinesis_firehose_delivery_stream"
#   destination = "extended_s3"

#   extended_s3_configuration {
#     role_arn   = aws_iam_role.cat_feeder_kinesis_firehose_delivery_stream.arn
#     bucket_arn = aws_s3_bucket.cat_feeder_iot_bucket.arn   
#   }

#   kinesis_source_configuration {
#     kinesis_stream_arn = aws_kinesis_stream.cat_feeder_stream.arn
#     role_arn = aws_iam_role.cat_feeder_kinesis_source_stream.arn
#   }
# }

# resource "aws_s3_bucket" "cat_feeder_iot_bucket" {
#   bucket = "cat-feeder-iot-bucket"
# }

# resource "aws_s3_bucket_acl" "cat_feeder_iot_bucket_acl" {
#   bucket = aws_s3_bucket.cat_feeder_iot_bucket.id
#   acl    = "private"
# }

# data "aws_iam_policy_document" "firehose_assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["firehose.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "cat_feeder_kinesis_firehose_delivery_stream" {
#   name               = "cat_feeder_kinesis_firehose_delivery_stream_role"
#   assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
# }

# data "aws_iam_policy_document" "firehose_source_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["firehose.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "cat_feeder_kinesis_source_stream" {
#   name               = "cat_feeder_kinesis_source_stream_role"
#   assume_role_policy = data.aws_iam_policy_document.firehose_source_role.json

#   inline_policy {
#     name   = "aa"
#     policy = data.aws_iam_policy_document.cat_feeder_kinesis_source_stream.json
#   }
# }

# data "aws_iam_policy_document" "cat_feeder_kinesis_source_stream" {
#   statement {
#     actions   = ["kinesis:DescribeStream"]
#     resources = ["*"]
#   }
# }