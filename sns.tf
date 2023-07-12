resource "aws_sns_topic" "system-alert" {
  name = "syslog-alert"
}

resource "aws_sns_topic_subscription" "email-target" {
  for_each  = toset(["abc@gmail.com", "nat@gmail.com"])
  topic_arn = aws_sns_topic.system-alert.arn
  protocol  = "email"
  endpoint  = each.value
}
