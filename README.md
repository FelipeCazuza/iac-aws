
# Resumo do projeto


Primeiro projeto de Infraestrutura como código com Terraform e Ansible, utilizando Terraform para provisionamento e AWS como provedor da infraestrutura.

  

## 🔨 Funcionalidades do projeto

  

A partir desse projeto você pode:

  

- Criar ambientes para aplicações com Django.
  

Neste projeto são exploradas as seguintes técnicas e tecnologias:

  

-  **Criação de maquina, vpc e security group**: criação de maquinas de forma automática pelo terraform e atribuição do Elastic IP na AWS feito de forma automática.

-  **Utilização de módulos**: Utilização dos módulos do Terraform e Ansible, desenvolvidos pelos provedores e comunidade

 
  

## 🛠️ Abrir e rodar o projeto

  

O projeto foi desenvolvido no VSC (Visual Studio Code), sendo assim, instale o VSC (pode ser uma versão mais recente) e, na tela inicial, procure a opção extensões, ou aperte Ctrl+Shift+X, e busque por HashiCorp Terraform, assim teremos o suporte do intellisense, tornando o trabalho de escrever o código mais rápido.

  

> Caso baixou o zip, extraia o projeto antes de procurá-lo, pois não é possível abrir via arquivo zip

  

Vá até a paste a abra a pasta do projeto. Após abrir o projeto abra um terminal, pode ser o integrado com o VSC, navegue até a pasta `env/Prod`  e execute o comando `terraform init` dentro dela, agora temos o Terraform iniciado e podemos começar a utilizá-lo. Para criar a infraestrutura, execute o `terraform apply`.

  

🏆
