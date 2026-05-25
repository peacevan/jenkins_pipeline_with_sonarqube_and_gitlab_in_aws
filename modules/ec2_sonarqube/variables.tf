variable "instance_name" {
        description = "Name of the instance to be created"
        default = "my-ec2-instance"
}

variable "instance_type" {
        default = "t2.micro"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-07ebbe60"
}


variable "instance_name" {
        description = "Name of the instance to be created"
        default     = "my-ec2-instance"
}

variable "instance_type" {
        default = "t2.micro"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
}

variable "ami_id" {
        description = "The AMI to use (leave empty to use module default lookup)"
        default     = ""
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default     = 1
}

variable "ami_key_pair_name" {
        default = ""
}

variable "key_name" {
        type        = string
        description = "Name of the existing EC2 key pair to use for SSH access (no default — provide via tfvars)"
}
  owners = ["099720109477"] # Canonical
}

variable "vpc_id" {}
variable "subnet_ids" {}

variable "allowed_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access instances (default allows all for lab use). Override for production."
  default     = ["0.0.0.0/0"]
}
