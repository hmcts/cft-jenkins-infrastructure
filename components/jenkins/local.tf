locals {
  mi_environment = var.env == "ptlsbox" ? "cftsbox-intsvc" : var.env == "ptl" ? "cftptl-intsvc" : var.env
  mi_cft = {
    # DTS-CFTSBOX-INTSVC
    cftsbox-intsvc = {
      subscription_id = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
    },
    # DTS-CFTPTL-INTSVC
    cftptl-intsvc = {
      subscription_id = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
    }
  }
  common_tags = merge(
    module.tags.common_tags,
    { startupMode = "always" }
  )

  group_members = var.env == "ptl" ? "0292f26e-288e-4f5b-85fc-b99a53f0a2b1" : "ca6d5085-485a-417d-8480-c3cefa29df31"
}