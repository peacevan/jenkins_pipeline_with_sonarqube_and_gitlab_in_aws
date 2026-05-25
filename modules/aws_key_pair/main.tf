// Generate the SSH keypair that we’ll use to configure the EC2 instance. 
// After that, write the private key to a local file and upload the public key to AWS

resource "tls_private_key" "key" {
  algorithm = "RSA"
}


resource "local_sensitive_file" "private_key" {
  count        = var.create_local_key_file ? 1 : 0
  content      = tls_private_key.key.private_key_pem
  filename     = "${var.namespace}-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.namespace}-key"
  public_key = tls_private_key.key.public_key_openssh
}
