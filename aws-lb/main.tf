#resource "aws_security_group_rule" "lb_egress" {
#  type              = "egress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["0.0.0.0/0"]
#  security_group_id = var.security_group_id
#}

resource "aws_lb" "lb" {
  name            = "${var.name}-lb"
  subnets         = var.subnet_ids
  security_groups = [var.security_group_id]
}
