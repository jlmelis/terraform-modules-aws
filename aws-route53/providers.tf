provider "aws" {
  region = var.region

  assume_role {
    role_arn = var.role_arn
  }

  default_tags {
    tags = var.tags
  }
}

provider "aws" {
  region = var.region
  alias  = "parent_dns_zone_account"

  assume_role {
    role_arn = var.parent_role_arn
  }

  default_tags {
    tags = var.tags
  }
}

provider "aws" {
  region = var.region
  alias  = "apex_dns_zone_account"

  #  assume_role {
  #    role_arn = var.parent_role_arn
  #  }

  default_tags {
    tags = var.tags
  }
}
