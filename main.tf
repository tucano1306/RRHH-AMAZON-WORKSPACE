provider "aws" {
  region = "us-west-2"  # Cambia esto a la región que prefieras
}

resource "aws_directory_service_directory" "example" {
  name     = "example.com"
  password = "SuperSecretPassw0rd!"
  size     = "Small"
  edition  = "Standard"
  vpc_settings {
    vpc_id     = "vpc-12345678"  # Cambia esto al ID de tu VPC
    subnet_ids = ["subnet-12345678", "subnet-87654321"]  # Cambia esto a los IDs de tus subnets
  }
}

resource "aws_workspaces_directory" "example" {
  directory_id = aws_directory_service_directory.example.id
}

resource "aws_workspaces_workspace" "example" {
  directory_id = aws_workspaces_directory.example.directory_id
  bundle_id    = "wsb-0xxxxxxxx"  # Cambia esto al ID del bundle de WorkSpaces que prefieras
  user_name    = "hr_employee"    # Cambia esto al nombre de usuario que prefieras
  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  workspace_properties {
    compute_type_name                         = "STANDARD"
    root_volume_size_gib                      = 80
    user_volume_size_gib                      = 50
    running_mode                              = "AUTO_STOP"
    running_mode_auto_stop_timeout_in_minutes = 60
  }
  tags = {
    Department = "HR"
  }
}