# Plano do Pipeline

Este documento descreve o plano de implementação do pipeline CI/CD integrado com Jenkins, SonarQube, GitLab e Docker, e a infraestrutura provisionada via Terraform na AWS. O conteúdo foi normalizado a partir do arquivo original de planejamento.

## Visão Geral
O pipeline automatiza: build, testes, análise estática (SonarQube), construção de imagem Docker e deploy em instâncias EC2 provisionadas pelo Terraform. A integração pode ser feita via GitLab (webhooks) ou acionada diretamente no Jenkins.

## Passos Principais

### Passo 1 — Configuração do Ambiente AWS com Terraform
- Instalar Terraform localmente.
- Criar/organizar os arquivos Terraform (`providers.tf`, `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`) e módulos em `modules/`.
- Configurar credenciais AWS com variáveis de ambiente ou profile do AWS CLI.
- Definir recursos: VPC, subnets, Internet Gateway, Route Tables, EC2, Security Groups, Key Pair, etc.
- `terraform init` e `terraform apply` para provisionamento (revise `allowed_cidrs` antes de aplicar em produção).

### Passo 2 — Configuração do Repositório (GitLab)
- Criar o repositório no GitLab e organizar branches (ex.: `main`, `develop`, `improve/*`).
- Configurar um Runner do GitLab (ou usar runners hospedados) com acesso aos recursos necessários.
- Proteger branches e configurar políticas de merge/PR conforme o fluxo desejado.

### Passo 3 — Configuração do Jenkins
- Instalar Jenkins (EC2/Container) e os plugins necessários (GitLab, Docker, Pipeline).
- Configurar credenciais seguras (Jenkins credentials, tokens do SonarQube, credenciais do registro Docker).
- Criar `Jenkinsfile` que descreva estágios: checkout, build, test, sonar, docker-build, docker-push, deploy.

### Passo 4 — Configuração do SonarQube
- Instalar e configurar SonarQube (ou usar serviço gerenciado).
- Criar token de acesso para integração com Jenkins.
- Definir regras e quality gates relevantes ao projeto.

### Passo 5 — Build e Deploy com Docker
- No `Jenkinsfile`, construir a imagem Docker, executar testes e enviar para um registro (Docker Hub ou ECR).
- Fazer deploy das imagens nas instâncias EC2 (por exemplo, via `docker run` ou com um orquestrador leve).

### Passo 6 — Automatização e Monitoramento
- Configurar triggers: webhooks do GitLab para Jenkins ou pipelines GitLab CI.
- Configurar notificações (Slack, e-mail) e monitoramento básico para o pipeline.

## Considerações de Segurança e Operação
- Nunca comitar `*.tfvars` com chaves/segredos. Use SSM/Secrets Manager ou variáveis de ambiente.
- Ajuste `allowed_cidrs` para faixas confiáveis antes de produção.
- Habilite autenticação e roles mínimas para os serviços.

## Resultado Esperado
Um fluxo automatizado que permite entregar código testado e analisado com qualidade (SonarQube), empacotado como imagem Docker e implantado em infraestrutura criada por Terraform, com rastreabilidade via GitLab/Jenkins.

## Próximos Passos Sugeridos
- Documentar o `Jenkinsfile` de exemplo no repositório.
- Adicionar exemplos de `gitlab-ci.yml` (se desejar fluxo GitLab CI).
- Incluir diagrama arquitetural em `img/` e exemplos de screenshots do pipeline.
