resource "tls_private_key" "algorithm_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "public_key" {
  key_name = var.key_name
  public_key = tls_private_key.algorithm_key.public_key_openssh

  tags ={
     Name = "${var.project_name}-algorithm_key"
   }
}

resource "local_sensitive_file" "private_key" {
  content = tls_private_key.algorithm_key.private_key_pem
   filename        = "${path.module}/${var.key_name}.pem"
   file_permission = "0600"
}