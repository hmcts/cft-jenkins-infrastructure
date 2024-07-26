locals {
  excluded_environments   = ["ptl", "sbox", "ptlsbox"]
  mi_environment          = var.env
  is_excluded_environment = contains(local.excluded_environments, local.mi_environment)

  mi_cft = {
    aat = {
      subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    demo = {
      subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    preview = {
      subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    ithc = {
      subscription_id = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    perftest = {
      subscription_id = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    prod = {
      subscription_id = "8999dec3-0104-4a27-94ee-6588559729d1"
    }
  }
}
