# jenkins_pipeline_with_sonarqube_and_gitlab_in_aws
criação de um pipeline completo com Jenkins, SonarQube e GitLab na AWS usando Terraform


## Passo a passo

### 1. INSTALAÇÃO DO JENKINS

- **JENKINS_URL**: <JENKINS_URL>

#### 1.1 - Acessar a instância EC2 do Jenkins (exemplo)

```sh
# use sua chave e o IP público substitua os placeholders abaixo
ssh -i <KEY_PAIR_FILE>.pem ubuntu@<JENKINS_PUBLIC_IP>
```

#### 1.2 - Definir o nome do host

```sh
sudo hostnamectl set-hostname jenkins
/bin/bash
```

#### 1.3 - Atualizar o Linux

```sh
sudo apt update
```

#### 1.4 - Instalar o Java

```sh
sudo apt install openjdk-11-jre
sudo apt-get install openjdk-17-jdk -y
```

#### 1.5 - Instalar o Jenkins

##### 1.5.1 - Adicionar repositório do Jenkins

```sh
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
```

##### 1.5.2 - Instalação do Jenkins

```sh
sudo apt-get update
sudo apt-get install jenkins
systemctl status jenkins
```

##### 1.5.3 - Acessar a URL http//:Ip_public:8080

Coloque a URL da tela do Jenkins aqui
------------------------------------------

### 2. INSTALAÇÃO DO SONARQUBE

Coloque os pré-requisitos aqui

#### 2.1 - Acessar a instância do SonarQube

```sh
# use sua chave e o IP público do SonarQube
ssh -i <KEY_PAIR_FILE>.pem ubuntu@<SONARQUBE_PUBLIC_IP>
sudo hostnamectl set-hostname sonarqube
```

# Jenkins pipeline com SonarQube e GitLab — Projeto de Portfólio

Resumo executivo
---------------
Projeto demonstrando automação DevOps na AWS com infraestrutura provisionada por Terraform e integração CI/CD via Jenkins, análise de qualidade com SonarQube e repositório de código GitLab. O repositório foi reorganizado para ser apresentado como case profissional: documentação limpa, variáveis parametrizáveis, e validações básicas de IaC.

Arquitetura (visão geral)
------------------------
- VPC com subnets públicas/privadas
- Instâncias EC2 para: Jenkins, SonarQube, GitLab e um host Docker
- Security Groups parametrizáveis (variável `allowed_cidrs`)
- State remoto opcional em S3 (configurado em `main.tf`)

Stack
-----
- Terraform (infraestrutura)
- AWS (EC2, VPC, Security Groups, EIP)
- Jenkins (CI server)
- SonarQube (code quality)
- GitLab (git hosting)

O que este repositório contém
-----------------------------
- Código Terraform modular em `modules/` (EC2, VPC, key pair)
- Scripts de provisionamento em `data/` (user-data)
- Exemplo de variáveis: `terraform.tfvars.example`
- Outputs padrão em `outputs.tf` e em cada módulo
- Workflow GitHub Actions para `terraform fmt` / `validate` e `tflint` em `.github/workflows/terraform.yml`

Como usar (resumido)
--------------------
1. Instalar Terraform 1.5.x e configurar AWS CLI/credenciais.
2. Copiar e ajustar `terraform.tfvars.example` → `terraform.tfvars` com valores reais (sem expor chaves no repo).
3. Inicializar e validar:

```bash
terraform init
terraform fmt
terraform validate
```

4. Para aplicar (ambiente de laboratório):

```bash
terraform apply -auto-approve
```

Observações importantes de segurança
----------------------------------
- Os valores `allowed_cidrs` em módulos defaultam para `["0.0.0.0/0"]` apenas para fins de laboratório. Antes de usar em produção, substitua por CIDRs restritos.
- Não commit seus arquivos `*.tfvars` com credenciais ou chaves privadas.
- Considere usar AWS Secrets Manager ou SSM Parameter Store para segredos.

Variáveis e onboarding
----------------------
- Veja `variables.tf` na raiz e `terraform.tfvars.example` para os exemplos de configuração.
- Principais variáveis:
  - `key_name`: nome do key pair EC2 (obrigatório)
  - `aws_region`: região AWS
  - `allowed_cidrs`: lista de CIDRs permitidos (restringir para produção)

Outputs úteis
-------------
- Os módulos expõem `instance_id`, `public_ip` e `security_group_id` para facilitar verificação após o `apply`.

Qualidade e CI
--------------
- Adicionado workflow GitHub Actions: `.github/workflows/terraform.yml` — roda `terraform fmt -check`, `terraform init` e `terraform validate`, e `tflint`.
- Recomenda-se integrar `pre-commit` para rodar `terraform fmt` localmente.

Decisões e mudanças feitas (nota de manutenção)
---------------------------------------------
- Sanitização: removidos IPs públicos e credenciais do README (substituídos por placeholders).
- Padronização: `key_name` agora é variável com `type = string` sem default em módulos EC2.
- Segurança: adicionada variável `allowed_cidrs` para parametrizar regras de SG.
- Correção: renomeado módulo `ec2_sonarqube` (corrigido typo de `ec2_sonarquber`).

Evidências e imagens
---------------------
- Inclua screenshots em `img/` (ex.: `img/pipeline.webp`, `img/diagrama.webp`) e referencie aqui.

Roadmap (sugestões rápidas)
--------------------------
- Automatizar validações em PRs (feito parcialmente com Actions).
- Adicionar `pre-commit` + `tflint` configs.
- Implementar outputs e exemplos de uso em `README` com resultados reais (após deploy).
- Considerar HTTPS (ALB + cert) e DNS para melhorar apresentação do case.

Contribuição
------------
Sinta-se à vontade para abrir PRs; para mudanças maiores crie uma branch com escopo claro (ex.: `improve/readme`) e inclua uma descrição concisa das alterações.

Licença / Uso
------------
Este repositório é um projeto de estudo/portfólio. Não exponha credenciais privadas em commits públicos.

---

Se quiser, eu adapto esse README para uma versão em inglês ou crio uma seção "Try it" com comandos passo a passo mais detalhados.


```sh
