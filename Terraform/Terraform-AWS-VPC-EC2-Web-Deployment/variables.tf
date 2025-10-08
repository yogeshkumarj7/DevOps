variable "aws_region" {
  description = "The AWS region to deploy the infrastructure."
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The EC2 instance type. Using t2.micro to ensure compliance with AWS Free Tier limits."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the existing AWS Key Pair for SSH access."
  type        = string
  default     = "Assign-terra"
}

# --- VPC and Subnet Configuration ---
variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet (AZ A)."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for the first private subnet (AZ B)."
  type        = string
  default     = "10.0.101.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for the second private subnet (AZ C)."
  type        = string
  default     = "10.0.102.0/24"
}
