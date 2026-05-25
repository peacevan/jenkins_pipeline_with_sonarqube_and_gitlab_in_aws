# jenkins_pipeline_with_sonarqube_and_gitlab_in_aws
Pipeline CI/CD para projetos em Go (Golang) com infraestrutura provisionada por Terraform na AWS — integração com Jenkins, SonarQube e GitLab.

<p align="center">
	<img src="img/Copilot_20260524_205122.png" alt="Architecture diagram (Copilot)" width="800" />
</p>

<p align="center">
	<img src="img/pipeline.webp" alt="Pipeline overview" width="800" />
</p>

## Tutorial detalhado (Medium)

Para o passo a passo completo, com prints e explicações detalhadas, veja o artigo no Medium:

https://medium.com/@peacevan/pipeline-ci-cd-com-terraform-aws-jenkins-sonarquber-gitlab-golang-c9f1b79ae379


Resumo executivo / objetivo
--------------------------
Fornecer um repositório demonstrativo que combina Terraform para provisionamento em AWS e uma pipeline de CI/CD que valida, testa e analisa código de um projeto em Go, servindo como material para portfólio e referência técnica.

Arquitetura da solução
----------------------
A solução provisiona os componentes principais em AWS: uma VPC com subnets, instâncias EC2 para Jenkins, SonarQube e GitLab (opcional), security groups e um key pair para acesso seguro. O Jenkins orquestra o fluxo de build/test/scan; SonarQube realiza análise estática e o GitLab funciona como repositório/trigger.

Stack utilizada
---------------
- Terraform
- AWS (EC2, VPC, SG, KeyPair)
- Jenkins
- SonarQube
- GitLab
- Go (Golang)

Recursos provisionados na AWS
-----------------------------
- VPC com subnets públicas/privadas
- Internet Gateway e rotas
- Security Groups (Jenkins, SonarQube, GitLab)
- EC2 instances para cada serviço
- Key Pair (módulo dedicado)
- Outputs principais (IP, IDs) via `outputs.tf`

Fluxo do pipeline CI/CD
-----------------------
1. Commit/push no repositório aciona o pipeline.
2. Jenkins: checkout → `go build` → `go test` → `golangci-lint` → `sonar-scanner`.
3. Em caso de sucesso, artefatos ou deploys são executados conforme configuração (opcional).

Estrutura do repositório
------------------------
- `modules/` — módulos Terraform (ec2, vpc, key_pair, etc.)
- `data/` — scripts de provisionamento e helpers
- `docs/` — documentação e planos
- `img/` — diagramas e evidências (screenshots)
- `Jenkinsfile` — pipeline de exemplo
- `terraform.tfvars.example` — modelo de variáveis
- `.github/workflows/terraform.yml` — validações de IaC

Como executar
-------------
1. Copie e edite variáveis:

```bash
cp terraform.tfvars.example terraform.tfvars
# edite terraform.tfvars com valores (subnets, ami_id, key_name, allowed_cidrs)
```

2. Valide e gere plano:

```bash
terraform fmt
terraform init -input=false -backend=false
terraform validate
terraform plan -out=tfplan -input=false
```

3. Aplique quando pronto:

```bash
terraform apply tfplan
```

Melhorias futuras
-----------------
- Finalizar ou refatorar o módulo GitLab.
- Adicionar `LICENSE` e `CONTRIBUTING.md`.
- Reforçar segurança (reduzir `allowed_cidrs`, políticas de IAM).
- Adicionar pre-commit hooks e segurança adicional (Checkov, tflint).
- Incluir mais evidências visuais e instruções detalhadas de build para Go.

Screenshots / evidências
------------------------
Imagens e diagramas estão em `img/` e são referenciadas em `docs/STEP_BY_STEP.md`.

Contribuição
------------
Abra PRs a partir de branches `improve/*` para sugestões e melhorias. Use `pr_body.md` como modelo para PRs.
