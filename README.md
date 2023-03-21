# exemplo de receita com terraform para deploy de estrutura de dados

### lista de recursos

```bash
Cria 2 buckets
* 1 conforme input github actions (bucket para pos processamento)
* 1 pre definido em variables.tf (bucket para pre processamento)

Cria EMR para processamento de dados

Cria Redshift para armazenamento de dados

Cria Elasticsearch para indexação e visualização de dados

Cria VPC para Elasticsearch

Cria politicas básicas de acesso para bucket (privado) e EMR

```


Visite [Apresentação estrutura](https://docs.google.com/presentation/d/1wO89bes4uGz2C02k4z0KaQX7N-s2WPC3olrw70-WY6U/edit?usp=sharing)
