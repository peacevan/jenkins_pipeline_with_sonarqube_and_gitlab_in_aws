
Aqui está o passo a passo enxuto e atualizado para instalação e configuração (moveram-se detalhes e scripts para `data/`).

## Resumo

Guia prático para instalar Jenkins, SonarQube e GitLab em instâncias EC2 provisionadas via Terraform. Este documento foca em passos claros, idempotentes e checagens pós-instalação.

## Sumário
- [Pré-requisitos](#pre-requisitos)
- [Placeholders comuns](#placeholders-comuns)
- [Instalação do Jenkins](#instalacao-do-jenkins)
- [Instalação do SonarQube](#instalacao-do-sonarqube)
- [Instalação do GitLab](#instalacao-do-gitlab)
- [Checks pós-instalação](#checks-pos-instalacao)
- [Troubleshooting comum](#troubleshooting-comum)
- [Segurança e boas práticas](#seguranca-e-boas-praticas)
- [Referências e scripts](#referencias-e-scripts)

## Pré-requisitos
- Acesso AWS com permissão para criar recursos (EC2, VPC, SG, KeyPair).
- Terraform 1.5.x instalado.
- AWS CLI configurado (`aws configure`) ou credenciais por variável de ambiente.
- Cliente SSH (`ssh`) disponível.

## Placeholders comuns
- `<KEY_PAIR_FILE>` — arquivo PEM local da key pair.
- `<KEY_PAIR_NAME>` — nome da key pair no AWS.
- `<JENKINS_PUBLIC_IP>`, `<SONARQUBE_PUBLIC_IP>`, `<GITLAB_PUBLIC_IP>` — IPs públicos das EC2 (após apply).
- `<SONAR_DB_USER>`, `<SONAR_DB_PASSWORD>` — credenciais do banco do SonarQube (use Secrets Manager/SSM).

## Instalação do Jenkins

1. Conecte-se à instância (exemplo):

```sh
ssh -i <KEY_PAIR_FILE>.pem ubuntu@<JENKINS_PUBLIC_IP>
```

2. Pré-requisitos na instância (idempotente):

```sh
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-11-jre
```

3. Instalar Jenkins (saída não interativa):

```sh
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc >/dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list >/dev/null
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins
sudo systemctl enable --now jenkins
sudo systemctl status jenkins --no-pager
```

4. Acesse o console: `http://<JENKINS_PUBLIC_IP>:8080`. Use a senha inicial em `/var/lib/jenkins/secrets/initialAdminPassword`.

## Instalação do SonarQube

1. Requisitos (memória e kernel):

```sh
sudo sysctl -w vm.max_map_count=524288
sudo sysctl -w fs.file-max=131072
ulimit -n 131072
ulimit -u 8192
```

2. Instalar PostgreSQL (exemplo mínimo):

```sh
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql postgresql-contrib
sudo -u postgres psql -c "CREATE USER sonar WITH ENCRYPTED PASSWORD '<SONAR_DB_PASSWORD>'"
sudo -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar"
```

3. Baixar e configurar SonarQube (ajuste versão conforme necessidade):

```sh
cd /tmp
wget -q https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip
sudo apt-get install -y unzip
sudo unzip -o sonarqube-9.9.0.65466.zip -d /opt
sudo mv /opt/sonarqube-9.9.0.65466 /opt/sonarqube
sudo groupadd --system sonar || true
sudo useradd --system --create-home --gid sonar sonar || true
sudo chown -R sonar:sonar /opt/sonarqube
```

4. Ajustar `sonar.properties` para apontar para o PostgreSQL (use placeholders/SSM):

```properties
sonar.jdbc.username=<SONAR_DB_USER>
sonar.jdbc.password=<SONAR_DB_PASSWORD>
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube
```

5. Criar serviço systemd e iniciar (veja `docs/STEP_BY_STEP.md` para template):

```sh
sudo systemctl enable --now sonar
sudo systemctl status sonar --no-pager
```

## Instalação do GitLab (CE)

Instalar GitLab em produção tem requisitos próprios. Para um ambiente de laboratório, siga o procedimento oficial resumido:

```sh
sudo apt-get update -y
sudo apt-get install -y curl openssh-server ca-certificates tzdata
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://<GITLAB_PUBLIC_IP>" apt-get install -y gitlab-ce
```

Após a instalação, verifique a página web `http://<GITLAB_PUBLIC_IP>` e registre a senha inicial conforme o instalador mostrar.

## Checks pós-instalação
- Verifique serviços: `sudo systemctl status jenkins sonar gitlab-runsvdir`.
- Verifique portas: `ss -tunlp | grep -E ":8080|:9000|:80|:443"`.
- Verifique logs: `/var/log/jenkins/`, `/opt/sonarqube/logs/`, `/var/log/gitlab/`.

## Troubleshooting comum
- Jenkins não sobe: verifique `/var/lib/jenkins/secrets/initialAdminPassword` e logs em `/var/log/jenkins/jenkins.log`.
- SonarQube erro DB: confirme usuário/senha e endereço no `sonar.properties` e que o Postgres aceita conexões locais.
- GitLab instalação falha: confira requisitos de memória e disco.

## Segurança e boas práticas
- Nunca commite `*.tfvars` com segredos.
- Use AWS SSM/Secrets Manager para armazenar credenciais do SonarQube e tokens do Jenkins.
- Ajuste `allowed_cidrs` nas variáveis do Terraform antes de aplicar em produção.

## Referências e scripts
- Scripts de provisionamento e user-data estão em `data/` (ex.: `data/data_jenkins.sh`, `data/data_sonarqube.sh`, `data/data_gitlab.sh`).
- Links oficiais: Jenkins, SonarQube, GitLab docs.


##### Acessar a URL http//:Ip_public:8080

Coloque a URL da tela do Jenkins aqui
------------------------------------------


### Instalação do SonarQube

#### Pré-requisitos

Coloque os pré-requisitos aqui

#### Acessar a Instância do SonarQube

```sh
# use sua chave e o IP público do SonarQube
ssh -i <KEY_PAIR_FILE>.pem ubuntu@<SONARQUBE_PUBLIC_IP>
sudo hostnamectl set-hostname sonarqube
```

... (o documento continua com instruções detalhadas de instalação do SonarQube, PostgreSQL e GitLab)

Veja instruções detalhadas de instalação e configuração para Jenkins, SonarQube e GitLab no arquivo original agora localizado em `docs/STEP_BY_STEP.md`.

--

Nota: o conteúdo detalhado inclui comandos de instalação do Jenkins, SonarQube (com PostgreSQL) e GitLab, além de exemplos de configuração. Substitua valores sensíveis por placeholders antes de compartilhar publicamente.
