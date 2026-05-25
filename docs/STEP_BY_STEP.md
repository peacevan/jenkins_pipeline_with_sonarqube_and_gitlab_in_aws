Aqui está o passo a passo detalhado para instalação e configuração (movido de `STEP_BY_STEP.MD`).


## Resumo

### Instalação do Jenkins

- **JENKINS_URL**: <JENKINS_URL>
- **IP DA INSTÂNCIA DO JENKINS**: <JENKINS_PUBLIC_IP>

#### Acessar a Instância EC2 do Jenkins

```sh
# use sua chave e o IP público substitua os placeholders abaixo
ssh -i <KEY_PAIR_FILE>.pem ubuntu@<JENKINS_PUBLIC_IP>
```

#### Definir o Nome do Host

```sh
sudo hostnamectl set-hostname jenkins
/bin/bash
```

#### Atualizar o Linux

```sh
sudo apt update
```

#### Instalar o Java

```sh
sudo apt install openjdk-11-jre
sudo apt-get install openjdk-17-jdk -y
```


#### Instalar o Jenkins

##### Adicionar Repositório do Jenkins

```sh
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
```


##### Instalação do Jenkins

```sh
sudo apt-get update
sudo apt-get install jenkins
systemctl status jenkins
```

##### Acessar a URL http//:Ip_public:8080

Coloque a URL da tela do Jenkins aqui
------------------------------------------


### Instalação do SonarQube

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
