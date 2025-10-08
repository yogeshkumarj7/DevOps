terraform {
  backend "s3" {
    bucket         = "s3-bucket-2001"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tf-lock-table"
  }
}
