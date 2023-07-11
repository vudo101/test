#################### NLB ######################
resource "aws_lb" "nlb" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnets

  tags = {
    Name = var.nlb_name
  }
}
