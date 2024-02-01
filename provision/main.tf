resource "aws_instance" "hrms_inst" {
  ami = "ami-0a7cf821b91bcccbc"
  instance_type = var.instanceType
  key_name = "gaction1"

    connection {
    host = self.public_ip
    type = "ssh"
    private_key = file("~/.ssh/gaction1.pem")
    user = "ubuntu"
  }
  provisioner "remote-exec" {
    inline = [
        "git clone https://github.com/argadepp/frappe-hrms.git && cd frappe-hrms",

        "sh /home/ubuntu/frappe-hrms/script.sh ${var.domain}"
    ]
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.company}-hrms-master-ec2"
  }

}

output "domain_configuration" {
  value = "Update your dns with value${aws_instance.hrms_inst.public_dns}"
}