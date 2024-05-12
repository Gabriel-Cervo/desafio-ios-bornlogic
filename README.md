# Desafio iOS - BornLogic

## Visão Geral:

O presente aplicativo é o resultado de um desafio técnico para a BornLogic, e contava com os seguintes requisitos:
 - O app deve consumir a seguinte API: https://newsapi.org
 - O app deve conter duas telas
 - Na primeira tela, exibir do artigo as imagens, autores, títulos e as descrições utilizando UITableView ou UICollectionView
 - Ao selecionar uma célula, exibir na segunda tela a imagem, a data de publicação e o conteúdo do artigo, respectivamente

O projeto também contava com os seguintes requisitos opcionais (desejáveis):
  - View Code para auto layout
  - Utilizar Design Patterns
  - Utilizar frameworks nativos
  - Protocol Oriented Programming
  - Princípios do SOLID
  - Ser criativo com a construção do Layout
  - Escrever testes com XCTest

O projeto conta com um Design feito seguindo as normas da [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines) da Apple, utilizando da melhor forma os componentes nativos do sistema.

## Tecnologias Utilizadas:

Para este projeto foram utilizados <b>Swift</b>, <b>UIKit</b> e <i>XCTest</i> para os testes. Através do <i>UIKit</i>, o projeto utilizou de <i>View Code</i> para o <i>auto layout</i>.

O app também utilizou dos seguintes <i>Design Patterns</i>:
  - Factory
  - Singleton
  - Strategy

## Arquitetura:

O projeto conta com a arquitetura MVVM (Model-View-ViewModel) e segue os conceitos da <i>Clean Architecture</i>, realizando a separação em camadas. A arquitetura implementada permite de modo fácil retirar, atualizar ou inserir novas funcionalidades com bastante facilidade e manutenabilidade, permitindo que o app escale caso necessário.

## Testes:

O projeto conta com testagem unitária utilizando <i>XCTest</i>. Os testes foram organizados a nível de funcionalidade, contando com mocks para cada testes não depender de outras camadas.

## Dependências:

O projeto consta apenas com o <b>Kingfisher</b> como dependência (instalado através do <i>Swift Package Manager</i>). Este é usado para o <i>download</i> e <i>cache</i> das imagens baixadas para as notícias.

## Próximos Passos:

Como o projeto teve um escopo mais limitado devido ao fato de ser um teste técnico, certas coisas foram deixadas de fora visto que não eram essenciais. Sendo assim, para novas versões é possível adicionar essas funcionalidades e telas, sendo elas:
- Compartilhamento de notícia
- Busca por notícia
- Adição de filtros
- Salvar notícias favoritas
