subscription_id            = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
key_vault_name             = "cftsbox-intsvc"
cosmos_subscription_id     = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
mi_rg                      = "managed-identities-cftsbox-intsvc-rg"
operations_groups          = ["ptlsbox", "sbox"]
max_throughput             = "1000"
jenkins_disk_create_option = "Empty"

cosmos_databases = {
  jenkins = {
    name = "jenkins"
    containers = {
      "cve-reports" = {
        partition_key_path = "/build/git_url"
      }
      "performance-metrics" = {
        partition_key_path = "/_partitionKey"
        ignore_default_ttl = true
      }
      "pipeline-metrics" = {
        partition_key_path = "/_partitionKey"
        ignore_default_ttl = true
      }
    }
  }
  sds = {
    name = "sds-jenkins"
    containers = {
      "cve-reports" = {
        partition_key_path = "/build/git_url"
      }
      "performance-metrics" = {
        partition_key_path = "/_partitionKey"
        ignore_default_ttl = true
      }
      "pipeline-metrics" = {
        partition_key_path = "/_partitionKey"
        ignore_default_ttl = true
      }
    }
  }
}
