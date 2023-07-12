resource "aws_sns_topic" "system-alert" {
  name = "log-alert"
}

resource "aws_sns_topic_subscription" "email-target" {


  for_each  = toset(["abce@gmail.com")
  topic_arn = aws_sns_topic.system-alert.arn
  protocol  = "email"
  endpoint  = each.value
}
