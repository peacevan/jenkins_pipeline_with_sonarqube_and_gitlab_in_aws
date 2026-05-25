Aqui está o passo a passo detalhado para instalação e configuração (movido de `STEP_BY_STEP.MD`).

## RESUMO

### 1. INSTALAÇÃO DO JENKINS

-- **JENKINS_URL**: <JENKINS_URL>
-- **IP DA INSTÂNCIA DO JENKINS**: <JENKINS_PUBLIC_IP>

#### 1.1 - Acessar a instância EC2 do Jenkins

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

... (o documento continua com instruções detalhadas de instalação do SonarQube, PostgreSQL e GitLab)

Veja instruções detalhadas de instalação e configuração para Jenkins, SonarQube e GitLab no arquivo original agora localizado em `docs/STEP_BY_STEP.md`.

--

Nota: o conteúdo detalhado inclui comandos de instalação do Jenkins, SonarQube (com PostgreSQL) e GitLab, além de exemplos de configuração. Substitua valores sensíveis por placeholders antes de compartilhar publicamente.
