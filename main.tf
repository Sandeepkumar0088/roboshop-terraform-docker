resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids

  root_block_device  {
    volume_size = each.value["root_volume_size"] # lookup(each.value,"root_volume_size",20)
  }

  tags = {
    Name = each.key
  }
}

resource "aws_route53_record" "dns_records" {
  for_each = var.components
  zone_id  = var.zone_id
  name     = "${each.key}-dev"
  type     = "A"
  ttl      = 10
  records  = [aws_instance.instance[each.key].private_ip]
}


resource "null_resource" "ansible" {

  depends_on = [
    aws_instance.instance,
    aws_route53_record.dns_records
  ]


  for_each      = var.components

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = aws_instance.instance[each.key].private_ip
    }

    inline = [
      "ansible-pull -i localhost, -U https://github.com/sandeepkumar0088/roboshop-ansible-docker.git main.yml -e component=${each.key} -e env=dev"
    ]

  }

}