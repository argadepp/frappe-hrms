resource "aws_instance" "hrms_inst" {
  ami = data.aws_ami.ubuntu.id
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
      file("../script.sh")
    ]
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.company}-hrms-master-ec2"
  }

}