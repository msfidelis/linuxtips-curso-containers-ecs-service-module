resource "aws_service_discovery_service" "main" {

  count = var.service_discovery_namespace != null ? 1 : 0

  name = var.service_name

  dns_config {
    namespace_id = var.service_discovery_namespace

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}