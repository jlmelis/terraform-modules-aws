data "aws_caller_identity" "current" {}

#tfsec:ignore:aws-sns-enable-topic-encryption
resource "aws_sns_topic" "topic" {
  name         = var.name
  display_name = var.name
}

resource "aws_sns_topic_policy" "topic" {
  arn    = aws_sns_topic.topic.arn
  policy = data.aws_iam_policy_document.topic.json
}

data "aws_iam_policy_document" "topic" {
  statement {
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_sns_topic.topic.arn]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }
}
