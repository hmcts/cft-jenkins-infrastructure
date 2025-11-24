subscription_id                 = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
jenkins_disk_source_resource_id = "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/disks-ptl-rg/providers/Microsoft.Compute/snapshots/jenkins-disk-snapshot-26th-Jan"
jenkins_disk_create_option      = "Copy"
key_vault_name                  = "cftptl-intsvc"
cosmos_subscription_id          = "8999dec3-0104-4a27-94ee-6588559729d1"
mi_rg                           = "managed-identities-cftptl-intsvc-rg"
operations_groups               = ["demo", "dev", "ithc", "ptl", "prod", "stg", "test"]
max_throughput                  = "1000"

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
