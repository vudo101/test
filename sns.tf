resource "aws_sns_topic" "system-alert" {
  name = "syslog-alert"
}

resource "aws_sns_topic_subscription" "email-target" {
  for_each  = toset(["vudo@gft.com", "vu.do@gft.com"])
  topic_arn = aws_sns_topic.system-alert.arn
  protocol  = "email"
  endpoint  = each.value
}