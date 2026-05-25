Resumo:
- Sanitização do README e documentação
- Adição de terraform.tfvars.example e outputs.tf
- Padronização de variáveis (key_name, allowed_cidrs)
- Remoção de exposição de chave privada e placeholders sensíveis
- Criação do módulo modules/ec2_sonarqube (corrigido typo)
- Inclusão do workflow .github/workflows/terraform.yml para validações (fmt/validate/tflint)

O que foi feito (checklist):
- [x] README reescrito e sanitizado
- [x] terraform.tfvars.example adicionado
- [x] outputs.tf adicionado
- [x] Módulos parametrizados (`key_name`, `allowed_cidrs`)
- [x] Private key output removido
- [x] Workflow de CI adicionado

Notas importantes:
- Branch: improve/readme-tfvars-outputs (push realizado)
- Antes de aplicar em produção, revise `allowed_cidrs` e variáveis sensíveis

Solicito revisão rápida para mesclar essas melhorias focadas em documentação, segurança e qualidade de IaC.
