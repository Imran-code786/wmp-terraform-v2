resource "aws_instance" "instance" {
  count         = 5
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-04692f74cd3fa91ac"]

  tags = {
    Name = var.components[count.index]
  }
}

resource "aws_route53_record" "frontend" {
  count = 5
  zone_id = "Z02346282FFZR4IVNTZCB"
  name    = "${var.components[count.index]}-dev"
  type    = "A"
  ttl     = 30
  records  = [aws_instance.instance[count.index].private_ip]
}

variable "components" {
  default = ["frontend", "postgresql","portfolio-service","anayltics-service", ]
}