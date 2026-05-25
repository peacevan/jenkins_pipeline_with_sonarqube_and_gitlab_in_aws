variable "namespace" {
  type = string
}

variable "create_local_key_file" {
  type        = bool
  description = "Whether to write the generated private key to a local file. Default false to avoid accidental secret leakage."
  default     = false
}