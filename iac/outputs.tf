# export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}

# export the second availability zone
output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}

# website url
output "website_url" {
  value = join("", ["https://", var.record_name, ".", var.domain_name])
}