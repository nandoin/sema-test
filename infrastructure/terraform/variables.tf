variable "region_aws" {
  description = "Região para deploy"
  type        = string
  default     = ""
}

variable "bucket_name_raw" {
  description = "nome do bucket"
  type        = string
  default     = "sema-raw"
}

variable "bucket_acl_raw" {
  description = "politica do bucket"
  type        = string
  default     = "private"
}

variable "bucket_name_clean" {
  description = "nome do bucket"
  type        = string
  default     = ""
}

variable "bucket_acl_clean" {
  description = "politica do bucket"
  type        = string
  default     = "private"
}

variable "bucket_prefix" {
  description = "prefixo bucket"
  type        = string
  default     = "*"
}

variable "bucket_object_extension" {
  description = "extensão arquivos bucket"
  type        = string
  default     = ".raw"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "account_id" {
  default = 823892739827
}