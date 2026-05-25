
/* Removed output of private key to avoid leaking sensitive material */

output "key_name" {
  value = aws_key_pair.key_pair.key_name
}