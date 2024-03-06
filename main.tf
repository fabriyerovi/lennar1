provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  skip_child_token = true
}

data "vault_kv_secret_v2" "example" {
  mount = "secret" // change it according to your mount
  name  = "rds-connstring" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "VaultSecret"
    Secret = data.vault_kv_secret_v2.example.data["rds-connstring"]
  }
}