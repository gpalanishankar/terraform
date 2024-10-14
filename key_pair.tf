/*resource "tls_private_key" "web-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
output "pem_key" {
  value = tls_private_key.web-key.private_key_pem
}

resource "local_file" "web-pem_key" {
  content  = output.pem_key.value
  filename = "/tmp/terraform.pem"
}*/
