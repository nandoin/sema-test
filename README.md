# exemplo de receita com terraform para deploy de estrutura de dados

### lista de recursos

```bash
Cria 2 buckets
* 1 conforme input do github actions (bucket para pos processamento)
* 1 pre definido em variables.tf (bucket para pre processamento)

Cria EMR para processamento de dados

Cria Redshift para armazenamento de dados

Cria Elasticsearch para indexação e visualização de dados

Cria VPC para Elasticsearch

Cria politicas básicas de acesso para bucket (privado) e EMR

```
