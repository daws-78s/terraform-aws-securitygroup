resource "aws_security_group" "allow_tls" {
  name        = local.sg_name_final
  description = var.sg_description
  vpc_id      = var.vpc_id
  
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
        from_port       = ingress.value["from_port"]
        to_port         = ingress.value["to_port"]
        protocol        = ingress.value["protocol"]
        cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.outbound_rules
    content {
        from_port       = egress.value["from_port"]
        to_port         = egress.value["to_port"]
        protocol        = egress.value["protocol"]
        cidr_blocks = egress.value["cidr_blocks"]
    }
  }

  tags = merge(
    var.common_tags,
    var.sg_tags,
    {
        Name = local.sg_name_final
    }
  )
}