resource "aws_alb" "my-alb" {
  name            = "my-alb"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  tags = {
    Name = "my-alb"
  }
}

resource "aws_alb_target_group" "group" {
  name     = "terraform-example-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the health.html page.
  health_check {
    path = "/health.html"
    port = 80
  }
}

#Port 80 Listener
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_alb.my-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}

#Port 443 Listener
#resource "aws_alb_listener" "listener_https" {
#  load_balancer_arn = "${aws_alb.alb.arn}"
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "${var.certificate_arn}"
#  default_action {
#    target_group_arn = "${aws_alb_target_group.group.arn}"
#    type             = "forward"
#  }
#}

#Direct Connect ALB to Autoscale Group
resource "aws_autoscaling_attachment" "svc_asg_external2" {
  alb_target_group_arn   = "${aws_alb_target_group.group.arn}"
  autoscaling_group_name = "${aws_autoscaling_group.example-autoscaling.id}"
}

#Instance Attachment
#resource "aws_alb_target_group_attachment" "svc_physical_external" {
#  target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
#  target_id        = "${aws_instance.svc.id}"
#  port             = 8080
#}

