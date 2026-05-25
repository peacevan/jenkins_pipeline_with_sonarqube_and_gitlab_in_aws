# Resumo

## Sumário
- [Passo a passo](#passo-a-passo)
- [Arquitetura](#arquitetura)
- [Quickstart](#quickstart)
- [Pré-requisitos](#pré-requisitos)
- [Segurança](#seguran%C3%A7a)
- [Links úteis](#links-%C3%BAteis)

Resumo curto do projeto: este repositório demonstra uma pipeline de CI/CD self-hosted usando Jenkins, GitLab e SonarQube provisionados em AWS (VPC, subnets, EC2). O objetivo é servir como referência para automação de infraestrutura com Terraform e exemplos de integração CI.

## Arquitetura
- Jenkins: servidor de integração contínua para orquestrar builds e pipelines.
- GitLab: repositório Git self-hosted / runner (exemplo de integração).
- SonarQube: análise estática de código e qualidade.
- Rede: VPC pública/privada, Internet Gateway, rotas e security groups.
- Provisionamento: módulos Terraform em `modules/` que criam KeyPair, VPC e instâncias EC2.

Veja o diagrama em `img/diagrama.webp` para uma visão rápida da topologia.

## Quickstart
1. Copie o exemplo de variáveis e edite valores sensíveis:

```bash
cp terraform.tfvars.example terraform.tfvars
# edite terraform.tfvars conforme sua conta AWS (subnets, ami_id, key_name, allowed_cidrs)
```

2. Validações rápidas (local):

```bash
terraform fmt
terraform init -input=false -backend=false
terraform validate
terraform plan -out=tfplan -input=false
# para aplicar: terraform apply tfplan
```

## Pré-requisitos
- Terraform (recomendado ~1.5.x)
- Conta AWS configurada (`aws configure`) ou credenciais via environment
- Git
- Docker (opcional para builds/runner)
- tflint, sonar-scanner (opcionais para lint/scan)

## Segurança
- Variáveis sensíveis não devem ser commitadas: nunca comite `*.tfvars` com chaves/segredos.
- `allowed_cidrs` é parametrizável; o valor padrão é aberto para laboratório — restrinja para produção.
- A geração de arquivo de chave privada é opt-in: `create_local_key_file = false` por padrão nos módulos.
- Use Secrets Manager / SSM Parameter Store para segredos em CI.

## Links úteis
- `docs/STEP_BY_STEP.md` — instruções detalhadas de instalação e configuração.
- `Jenkinsfile` — exemplo de pipeline declarativa para Jenkins.
- `terraform.tfvars.example` — modelo de variáveis.
- `modules/` — módulos Terraform organizados por responsabilidade.

## Autor
- Projeto organizado por `peacevan` — ver histórico de commits no repositório.

---

Veja `docs/STEP_BY_STEP.md` para o passo a passo completo de provisionamento e configuração.
