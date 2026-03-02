resource "time_offset" "expiry" {
  offset_years = var.keep-until
}

locals {
  keep_until_date = formatdate("YYYY-MM-DD", time_offset.expiry.rfc3339)
}
