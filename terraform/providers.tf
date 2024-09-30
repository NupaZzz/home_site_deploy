terraform {
  required_version = ">=1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }

    ssh = {
      source = "loafoe/ssh"
      version = "~> 2.5"
    }
  }
}