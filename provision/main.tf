resource "aws_instance" "hrms_inst" {
  ami = "ami-0a7cf821b91bcccbc"
  instance_type = var.instanceType
  key_name = "gaction1"

    connection {
    host = self.public_ip
    type = "ssh"
    private_key = file("../scripts/id_rsa")
    user = "ubuntu"
  }
 root_block_device {
    volume_size = 20  # Set the desired size for the root volume in GB
  }

  provisioner "remote-exec" {
    inline = [
        " git clone https://argadepp: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@github.com/argadepp/frappe-hrms.git && cd frappe-hrms",

        "sh /home/ubuntu/frappe-hrms/scripts/install_${var.frappe-app}.sh ${var.domain}"
        # file("../scripts/install_${var.frappe-app}.sh")
    ]
    
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.company}-${var.frappe-app}-ec2"
  }

}

output "domain_configuration" {
  value = "Update your dns with value${aws_instance.hrms_inst.public_dns}"
}
