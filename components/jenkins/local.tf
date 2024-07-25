locals {
  mi_environment = var.env == "sbox" ? "sandbox" : var.env == "prod" ? "cftptl-intsvc" : var.env
  mi_cft = {
    # DTS-CFTSBOX-INTSVC
    cftsbox-intsvc = {
      subscription_id = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
    }
    # DTS-CFTPTL-INTSVC
    cftptl-intsvc = {
      subscription_id = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
    }
  }
}
