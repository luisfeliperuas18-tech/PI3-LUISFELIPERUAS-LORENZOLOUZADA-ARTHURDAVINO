# Como é composto, em termos de vocabulário, o corpus textual sobre os municípios de Santos, São Vicente e Cubatão extraído da Wikipédia?

Fatec Baixada Santista, Rubens Lara
Tecnologia em Ciência de Dados | Projeto Integrador | Professor(a): preencher

Arthur Davino Rizzo, RA 0051352511016
Lorenzo Ribeiro Louzada, RA 0051352511030
Luis Felipe Ruas do Nascimento, RA 0051352511032

## 1. Introdução

A análise de textos permite transformar conteúdo escrito em dados que podem ser organizados, contabilizados e posteriormente utilizados em técnicas de mineração de texto e processamento de linguagem natural. Nesse contexto, a construção de um corpus constitui uma etapa inicial importante, pois reúne os documentos que serão submetidos às etapas de preparação e análise.

Este trabalho apresenta a construção de um corpus textual sobre três municípios da Baixada Santista: Santos, São Vicente e Cubatão. Os textos foram coletados das páginas correspondentes desses municípios na Wikipédia em língua portuguesa, Wikipédia (2026b, 2026c, 2026a). A coleta foi realizada programaticamente em R com auxílio do pacote rvest, utilizado para leitura de páginas HTML e extração de elementos de documentos web, Wickham (2025).

O objetivo desta etapa do Projeto Integrador é organizar um conjunto textual sobre os municípios selecionados, realizar uma tokenização inicial e observar a frequência dos termos presentes no corpus. A análise também permite identificar limitações da contagem bruta de palavras, especialmente a grande presença de artigos, preposições e conjunções entre os termos mais frequentes.

## 2. O corpus e o processo de construção

O corpus foi construído a partir de três documentos, um para cada município selecionado: Santos, São Vicente, Cubatão. No notebook do projeto, os endereços das três páginas foram armazenados em um vetor e, em seguida, foi criada uma função denominada *baixar_texto*. Essa função utiliza *read_html()* para carregar a página, *html_elements()* para selecionar os elementos HTML do tipo parágrafo (*p*) e *html_text2()* para extrair seu conteúdo textual.

Os textos extraídos das três páginas foram armazenados no objeto *docs*. A verificação de seu comprimento confirmou a presença de 3 documentos. Posteriormente, esses documentos foram concatenados em um único texto para possibilitar uma análise conjunta do vocabulário da amostra.

Antes da contagem, todo o conteúdo foi convertido para letras minúsculas por meio de `tolower()`. A tokenização foi realizada com `strsplit()`, utilizando como separadores os caracteres que não correspondiam a letras. Tokens vazios foram removidos. Como resultado dessa etapa, foram identificados 3.441 termos distintos no vocabulário do corpus.

**Tabela 1, Documentos que compõem o corpus**

| Documento | Fonte |
|---|---|
| Santos | Wikipédia em língua portuguesa |
| São Vicente | Wikipédia em língua portuguesa |
| Cubatão | Wikipédia em língua portuguesa |

*Fonte: elaborada pelos autores a partir do notebook do projeto.*

## 3. Análise exploratória do corpus

Após a tokenização, foi construída uma tabela de frequência utilizando `table()` e ordenação decrescente. A Tabela 2 apresenta os dez termos mais frequentes encontrados no corpus.

A Figura 1 representa graficamente os mesmos resultados.

Os resultados mostram que a maior parte dos termos com maior frequência é formada por palavras funcionais da língua portuguesa. Entre os dez termos mais recorrentes aparecem artigos, preposições e conjunções como "de", "a", "e", "o", "do", "da", "em" e "que". Por serem palavras muito comuns na construção de frases, suas altas frequências não significam, necessariamente, que representem os temas centrais dos documentos.

Entre os termos apresentados, "santos" aparece 150 vezes e "cidade" 138 vezes. Esses termos possuem relação mais direta com o domínio do corpus, embora a análise disponível nesta etapa ainda não permita comparar formalmente a importância de cada palavra entre os três municípios.

**Tabela 2, Dez termos mais frequentes no corpus**

| Termo | Frequência |
|---|---:|
| de | 852 |
| a | 479 |
| e | 388 |
| o | 387 |
| do | 321 |
| da | 261 |
| em | 237 |
| que | 167 |
| santos | 150 |
| cidade | 138 |

*Fonte: elaborada pelos autores a partir do corpus analisado.*

![Figura 1, Frequência dos dez termos mais recorrentes no corpus](PI-Corpus-figura1.png)

*Figura 1, Frequência dos dez termos mais recorrentes no corpus. Fonte: elaborada pelos autores a partir dos resultados do notebook.*

## 4. Considerações finais

O trabalho resultou na construção de um corpus formado por 3 documentos referentes a Santos, São Vicente e Cubatão. A coleta automática dos parágrafos, a normalização para letras minúsculas e a tokenização permitiram obter um vocabulário de 3.441 termos distintos e realizar uma primeira análise de frequência.

A análise demonstrou que uma contagem simples de palavras é fortemente influenciada por termos gramaticais de alta frequência. Esse resultado indica que uma etapa posterior deve considerar a remoção de stopwords, como já apontado no próprio notebook, para que palavras mais representativas do conteúdo possam ganhar destaque.

Como continuidade do Projeto Integrador, o corpus poderá passar por etapas adicionais de limpeza e preparação. A partir delas, será possível comparar o vocabulário dos municípios e aplicar outras técnicas de análise textual. Entretanto, essas etapas representam trabalhos futuros e não fazem parte dos resultados já obtidos no notebook analisado.

## Referências

WICKHAM, H. *rvest, Easily Harvest (Scrape) Web Pages*. 2025. Pacote R. Utilizado para leitura e extração de conteúdo HTML.

WIKIPÉDIA. *Cubatão*. 2026. Disponível em: <https://pt.wikipedia.org/wiki/Cubat%C3%A3o>. Acesso em: 2 out. 2026.

WIKIPÉDIA. *Santos*. 2026. Disponível em: <https://pt.wikipedia.org/wiki/Santos>. Acesso em: 2 out. 2026.

WIKIPÉDIA. *São Vicente (São Paulo)*. 2026. Disponível em: <https://pt.wikipedia.org/wiki/S%C3%A3o_Vicente_(S%C3%A3o_Paulo)>. Acesso em: 2 out. 2026.
