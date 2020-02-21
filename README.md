# README #

## ---- Português ---- ##

Este documento README tem como objetivo fornecer as informações necessárias para realização do projeto Empresas.

### Objetivo ###
* Criação de uma API em .NET que atendam aos requisitos do escopo do projeto, listados abaixo.
* Você deve realizar um fork deste repositório e, ao finalizar, enviar o link do seu repositório para a nossa equipe. Lembre-se, **NÃO** é necessário criar um Pull Request para isso.
* Nós iremos realizar a avaliação e te retornar um email com o resultado.

### O que será avaliado? ###
* A ideia com este teste é ter um melhor entendimento das suas habilidades com a tecnologia .Net, assim como seus frameworks. Mas de qualquer forma, uma boa padronização e organização, são **MUITO** bem vindas.
* A qualidade e desempenho do seu código.
* Sua capacidade de organizar o código.
* Capacidade de tomar decisões.

### ESCOPO DO PROJETO ###
* Deve ser criada uma API em .NET, ou .NET Core.
* A API deve fazer o seguinte:
* Login e verificação de acesso de usuários registrados
	* Para o login usamos padrões OAuth 2.0.
* Listagem de Empresas
* Detalhamento de Empresas
* Filtro de Empresas por nome e tipo


### Informações Importantes ###

* Modelo de Integração disponível a partir de uma collection para Postman (https://www.getpostman.com/apps) disponível neste repositório.

* A API deve funcionar exatamente da mesma forma que a disponibilizada na collection do postman, mais abaixo os acessos a API estarão disponíveis em nosso servidor.

* Mantenha a mesma estrutura do postman em sua API, ou seja, ela deve ter os mesmo atributos, respostas, rotas e tratamentos, funcionando igual ao nosso exemplo.

* Quando seu código for finalizado e disponibilizado para validarmos, vamos subir em nosso servidor e realizar a integração com o app. 

* Independente de onde conseguiu chegar no teste é importante disponibilizar seu fonte para analisarmos.

* É obrigatório utilização de Banco de Dados Sql Server.

* Não esqueça de nos enviar um dump/script, da base de dados utilizada.


### Dados para Teste ###

* Servidor: http://empresas.ioasys.com.br
* Versão da API: v1
* Usuário de Teste: testeapple@ioasys.com.br
* Senha de Teste : 12341234

### Dicas ###

* Guideline rails http://guides.rubyonrails.org/index.html
* Componente de autenticação https://github.com/rizel10/simple_token_auth
* Componente de autenticação https://github.com/lynndylanhurley/devise_token_auth

## ---- English ---- ##

This document aims to provide the information needed to develop Enterprise's project.

### Goal ###
* Development of an .NET API that meets the requirements of the Project Scope listed below.
* You must fork this repository and send the link of your own repository to our team. Remember: it's **NOT** necessary to do a Pull Request to acomplish this.
* We will evaluate your code and send you an email with the result asap.

### What will be evaluated? ###

* The purpose of this test is to have a better idea of your .Net knowledge and the all frameworks that comes with it as well. Nevertheless, the use of patterns and a good organization will be greatly appreciated.
* The quality and performance of your code.
* Your capacity of organize your code.
* Effectiveness of your decision-making

### PROJECT SCOPE ###
* Develop an API in .NET or .NET Core.
* The API should do the following:
* Login and authentication of registered users.
    * OAuth 2.0 patterns are recommended.
* Enterprise listing.
* Enterprise filter by name and type.


### Important ###

* Integration model is in the Postman (https://www.getpostman.com/apps) collection availabled in this repository (https://bitbucket.org/ioasys/empresas-dotnet/src/582aaa55ca60/App_Empresas.postman_collection?at=master)

* The API must work exactly the same way as the one available in the postman collection. Below the acess and credentials are provided.

* Keep the same structure of the collection in your API, in other words, it should have the same attributes, responses, routes and treatments, working just like our example.

* After you finish your code and make it avaliable to us evaluate, we will deploy it on our servers and integrate with the app.

* Regardless of how much you acomplish it's important to make it avaliable so that we can evaluate it properly.

* It's mandatory to use a SQL Server Database.

* Don't forget to send us a dump/script of the database. (You can use migrations if you want to)

### Test Info ###

* Server: http://empresas.ioasys.com.br
* API Version: v1
* Test User: testeapple@ioasys.com.br
* Test Password : 12341234