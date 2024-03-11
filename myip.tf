terraform {
  required_providers {
    curl = {
      version = "1.0.2"
      source  = "anschoewe/curl"
    }
  }
}

provider "curl" {
}

data "curl" "getMyIP" {
  http_method = "GET"
  uri = "https://checkip.amazonaws.com"
}

// Let's add some safety here:
//   If no my-ip is provided, find the external IP address via curl
//   If my-ip is provided, ensure it is in CIDR format by adding /32
//   Accept my-ip in both "xxx.xxx.xxx.xxx" and "xxx.xxx.xxx.xxx/yy" format

locals {
  tmp_ip = var.my-ip == "" ? trimspace(data.curl.getMyIP.response) : var.my-ip
  my_ip = strcontains(local.tmp_ip, "/") ? local.tmp_ip : format("%s/32", local.tmp_ip)
}
