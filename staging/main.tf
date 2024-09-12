terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.95.0"
    }
  }

  backend "s3" {
    bucket   = "snowflake-raphaelokere"
    key      = "terraform-prod.tfstate"
    region   = "us-east-1"
    encrypt  = true
    role_arn = "arn:aws:iam::658108419956:role/snowflake"
  }
}

provider "snowflake" {
  username    = "RAPHAELOKERE"
  account     = "YQB16430.us-east-1"
  role        = "ACCOUNTADMIN"
  private_key = var.snowflake_private_key
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = 1
  database            = var.database
  env_name            = var.env_name
}
