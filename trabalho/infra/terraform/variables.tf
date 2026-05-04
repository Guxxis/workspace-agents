variable "do_token" {
  description = "Digital Ocean Personal Access Token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Região do Data Center"
  type        = string
  default     = "nyc3"
}

variable "droplet_size" {
  description = "Tamanho do Droplet. Como rodará Jenkins (Java), recomenda-se mínimo 4GB RAM."
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "ssh_key_id" {
  description = "O ID ou Fingerprint da sua chave SSH pública já cadastrada na Digital Ocean"
  type        = string
}
