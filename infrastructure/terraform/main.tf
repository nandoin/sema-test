# Definição do provider AWS
provider "aws" {
  region = var.region_aws # Defina a região desejada
  access_key = "xxx" # Seguir padrao, puxar variaveis locais ou secret
  secret_key = "yyy" # Seguir padrao, puxar variaveis locais ou secret
  token = "zzz"
}

## Criando recursos
# Criação do bucket S3
resource "aws_s3_bucket" "bucket_raw" {
  bucket = var.bucket_name_raw #nome do bucket desejado
  acl    = var.bucket_acl_raw # política de acesso ao bucket
}

resource "aws_s3_bucket" "bucket_clean" {
  bucket = var.bucket_name_clean #nome do bucket desejado
  acl    = var.bucket_acl_clean # política de acesso ao bucket

}
resource  "aws_s3_bucket_object_lock_configuration" "object_lock" {
  bucket = var.bucket_name_clean
  object_lock_enabled = "Enabled"
  rule {
    default_retention {
    mode = "GOVERNANCE" # Define a governança da retenção
    days = 1876
    }
  }
  }

# Criacao EMR
resource "aws_emr_cluster" "sema_emr" {
  name          = "sema-emr"
  release_label = "emr-6.4.0"
  service_role  = "EMR_DefaultRole"
  visible_to_all_users = true

  # Configuração do hardware
  master_instance_group {
    instance_type = "m5.xlarge"
    instance_count = 1
  }

  core_instance_group {
    instance_type = "m5.xlarge"
    instance_count = 2
  }
}

# Criação do cluster Redshift
resource "aws_redshift_cluster" "sema_redshift" {
  cluster_identifier = "sema-redshift"
  node_type          = "dc2.large"
  master_username    = "Adminadminadmin"
  master_password    = "Senha123"
  cluster_subnet_group_name = "default"
  publicly_accessible = false
  
}

# Criação do domínio Elasticsearch
resource "aws_elasticsearch_domain" "sema_elasticsearch" {
  domain_name           = "elk-sema"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type = "r4.large.elasticsearch"
  }

vpc_options {
    subnet_ids = [aws_subnet.private.id]
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Terraform = "true"
  }
}

## Criando politicas
# Definição da política de acesso ao bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_name_raw

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AllowS3GetObject",
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = ["arn:aws:s3:::${aws_s3_bucket.bucket_clean.id}/*"]
      }
    ]
  })
}

# Politicas EMR
resource "aws_iam_policy" "emr_policy" {
  name        = "emr-policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = ["emr:*"]
        Resource  = [aws_emr_cluster.sema_emr.arn]
      }
    ]
  })
}
