terraform {
  backend "s3" {
    bucket = "pgd-tf-remote-state"
    key = "terrform/state/"
    region = "us-east-1"
  }
}