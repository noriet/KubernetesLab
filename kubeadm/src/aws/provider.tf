terraform {
    backend "local" {
        path = "/work/tfstate/terraform.tfstate"
    }
    required_version        = ">=0.12"
}

provider aws {
    region                  =  "ap-northeast-1"
}
