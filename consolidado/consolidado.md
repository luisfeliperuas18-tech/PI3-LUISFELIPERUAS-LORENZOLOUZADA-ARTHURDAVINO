# Consolidado

## Projeto

**P.J.R.I. — Projeto Integrador**

## Integrantes

- Lorenzo Ribeiro Louzada
- Luis Felipe Ruas
- Arthur Davino

## Descrição

Este projeto apresenta a criação e a análise de um corpus textual sobre municípios da Baixada Santista. Os dados foram obtidos de páginas da Wikipédia referentes aos municípios de Santos, São Vicente e Cubatão.

As atividades foram desenvolvidas em R, utilizando notebooks Jupyter. O trabalho contempla coleta de textos, organização dos parágrafos, tokenização, criação de vocabulário, cálculo da frequência dos termos, remoção de stopwords e aplicação de stemming.

## Arquivos do projeto

### `corpus-baixada-santista-sem-snow.ipynb`

Este notebook apresenta a construção e a análise inicial do corpus sem a utilização do pacote SnowballC. As principais etapas são:

- definição das páginas utilizadas como fonte;
- coleta dos textos com o pacote `rvest`;
- extração dos parágrafos;
- formação do corpus textual;
- limpeza e preparação dos textos;
- tokenização das palavras;
- criação do vocabulário;
- cálculo da frequência dos termos;
- identificação dos termos mais frequentes.

Essa versão funciona como análise inicial e permite observar os termos em sua forma original.

### `corpus-baixada-santista-com-snow.ipynb`

Este notebook amplia o processamento do corpus com a utilização do pacote `SnowballC`. As principais etapas são:

- coleta e organização dos textos por município;
- identificação individual dos parágrafos;
- limpeza e tokenização dos textos;
- remoção de stopwords da língua portuguesa;
- aplicação de stemming para reduzir palavras às suas formas radicais;
- criação do vocabulário processado;
- análise da frequência dos termos;
- consulta e análise de parágrafos específicos.

Essa versão permite reduzir variações de uma mesma palavra e destacar termos mais representativos do conteúdo analisado.

## Comparação das abordagens

Os dois notebooks permitem comparar o corpus antes e depois da aplicação do stemming. A versão sem SnowballC preserva as palavras em suas formas originais, enquanto a versão com SnowballC reduz as palavras aos seus radicais.

A remoção de stopwords também contribui para diminuir a presença de artigos, preposições e conjunções, tornando mais evidentes os termos relacionados ao conteúdo dos municípios estudados.

## Estrutura do repositório

- `codigo/`: contém os notebooks com os códigos e as análises desenvolvidas em R;
- `to-delete/`: armazena temporariamente arquivos destinados à exclusão;
- `consolidado.md`: reúne a descrição e a organização dos materiais do projeto.

## Tecnologias utilizadas

- R;
- Jupyter Notebook;
- pacote `rvest`;
- pacote `SnowballC`;
- coleta de dados de páginas web;
- processamento de linguagem natural;
- tokenização;
- remoção de stopwords;
- stemming;
- análise de frequência de termos.
