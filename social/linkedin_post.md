<!-- LinkedIn post + first comment ready to paste -->

# Post curto (feed)

Atualizei meu projeto de portfólio: Pipeline CI/CD self‑hosted para projetos em Go — Jenkins + SonarQube + GitLab, provisionado com Terraform na AWS.

Principais melhorias: README reestruturado, módulos Terraform parametrizados, remoção de outputs sensíveis, validações IaC (GitHub Actions) e `Jenkinsfile` de exemplo.

Código: https://github.com/peacevan/jenkins_pipeline_with_sonarqube_and_gitlab_in_aws

Tutorial completo: https://medium.com/@peacevan/pipeline-ci-cd-com-terraform-aws-jenkins-sonarquber-gitlab-golang-c9f1b79ae379

Feedback e sugestões bem‑vindos! ✅

--

# Versão completa (primeiro comentário / post estendido)

Atualizei e deixei este repositório pronto para portfólio. Resumo das alterações e motivação:

- Reescrita do `README.md` e organização da pasta `docs/` (quickstart, resumo, passo‑a‑passo).
- Parametrização e limpeza dos módulos Terraform (remoção de defaults sensíveis, `key_name` e `allowed_cidrs` parametrizados).
- Remoção de outputs que expunham chaves; geração de chave privada agora é opt‑in (`create_local_key_file=false`).
- Validações automáticas adicionadas: `terraform fmt`, `terraform validate`, `tflint` via GitHub Actions.
- `Jenkinsfile` de exemplo adicionado e scripts padronizados em `data/`.
- Imagens e screenshots incluídas para evidência visual (diagrama e pipeline).

Como testar rapidamente (local):

```bash
cp terraform.tfvars.example terraform.tfvars
terraform fmt
terraform init -input=false -backend=false
terraform validate
terraform plan -out=tfplan -input=false
```

Repositório: https://github.com/peacevan/jenkins_pipeline_with_sonarqube_and_gitlab_in_aws

Tutorial detalhado (Medium): https://medium.com/@peacevan/pipeline-ci-cd-com-terraform-aws-jenkins-sonarquber-gitlab-golang-c9f1b79ae379

Se quiser, posso preparar um carrossel com 4 imagens (diagrama + pipeline + Jenkins + SonarQube) pronto para upload.

--

# Sugestões de mídia e legenda

- Imagem principal do post: `img/pipeline.webp` (use como mídia do post). Legenda curta: "Pipeline CI/CD auto‑hospedado para projetos Go — Terraform + Jenkins + SonarQube".
- Carrossel sugerido (ordem): 1) `img/diagrama.webp` — visão arquitetural; 2) `img/pipeline.webp` — fluxo; 3) screenshot Jenkins; 4) screenshot SonarQube.

# Hashtags recomendadas

#DevOps #Terraform #AWS #CI #Jenkins #SonarQube #Golang #InfrastructureAsCode

# CTA sugerida

"Confira o repositório e deixe seu feedback — dicas e melhorias são bem‑vindas!"
