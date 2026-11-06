# Consolidado, PI III, Aula 07, Parte D: LSA e busca híbrida

Projeto Integrador III, Motor de Busca. Grupo Porto da Baixada: Arthur Davino Rizzo, Lorenzo Ribeiro Louzada e Luis Felipe Ruas do Nascimento.
Data: 6 de novembro de 2026. Motor do curso: motor08. Código: `aula07_parteD.ipynb`. Configuração: `7-entrega-config.R`.

## 1. O que a tarefa pedia

1. Rodar `lsa(ix, k)` no corpus do grupo e comparar o top 5 de `ranking_lsa` com o do BM25 numa consulta, lendo os textos.
2. Calcular o MAP do BM25, da LSA com alguns k (10, 20, 50 e até o número de documentos) e do `rrf(BM25, LSA)`; escolher modelo e k no dev e relatar no teste uma vez.
3. Registrar a decisão (`modelo`, `lsa_k` e `rrf_c`) no `config.R` e na ficha do projeto.

## 2. O que foi feito

Preparação. É a mesma da Aula 06: corpus de 220 trechos (Santos, São Vicente e Cubatão), 4.757 termos depois da limpeza com acentos transliterados e sem stopwords, e 86 julgamentos resolvidos (o item sem maioria da Entrega 05 ficou de fora). Os relevantes por consulta (grau 2) são 2, 2, 2, 1 e 2 para q01 a q05. Como conferência, a base da Aula 06 foi reproduzida: AP de 0,667, 0,417 e 1,000 nas consultas do dev, MAP de 0,694. Dev: q01 a q03. Teste: q04 e q05.

Tarefa 1, a LSA. A `lsa(ix, k)` faz a SVD da matriz TF IDF (4.757 termos por 220 documentos) e guarda k dimensões: U (termos por k), os k valores singulares e D (documentos por k). A consulta é dobrada para o espaço reduzido, `qk = U' q`, e o ranking é o cosseno entre `qk` e cada linha de D. Com k = 20, os primeiros valores singulares são 135,5, 109,1, 78,8, 68,9 e 67,2.

Top 5 na q01, "fundação de Santos", lendo os textos. Os dois relevantes (grau 2) são `san_89a217bd1e` e `san_787b827e51`.

| Pos. | BM25 | Grau | O texto diz |
|---|---|---|---|
| 1 | san_89a217bd1e | 2 | atribui a fundação de Santos a Brás Cubas, em 1536 |
| 2 | san_b93b880263 | 0 | trecho de referências bibliográficas, com "Santos" repetido |
| 3 | san_31603f8e29 | 0 | bibliografia, com uma editora chamada Fundação Dinarco Reis |
| 4 | san_787b827e51 | 2 | Santos elevada à categoria de cidade, em 1839 |
| 5 | sv_758239684f | 0 | referência sobre as eleições de 1532 em São Vicente |

| Pos. | LSA, k = 20 | Grau | O texto diz |
|---|---|---|---|
| 1 | sv_e795fc704f | sem julgamento | expedição de Martim Afonso de Sousa e desembarque em São Vicente, em 1532 |
| 2 | sv_651336a6c4 | 0 | referência bibliográfica |
| 3 | sv_41af95d229 | sem julgamento | São Vicente marca o início da colonização, fundada em 1532 |
| 4 | sv_70b5fb2a9e | sem julgamento | referências sobre São Vicente (onda de 1541, berço da democracia) |
| 5 | sv_81789aaee1 | 0 | bibliografia sobre fortificações |

Posição dos dois relevantes: BM25 em 4 e 1; LSA com k = 20 em 101 e 23.

Leitura. O BM25 acerta porque "fundação" é rara (aparece em 8 dos 220 trechos) e "Santos" casa com os trechos certos; os erros dele são trechos de bibliografia que repetem palavras da consulta. A LSA acha o tema, e todos os cinco trechos dela são de São Vicente e falam de fundação, colonização e 1532. Mas é a cidade errada: "Santos" aparece em 114 dos 220 trechos (IDF de 0,66) e pesa pouco no espaço reduzido, então o eixo "início da colonização" domina. Para a q01 isso é erro. A LSA captura o assunto e perde o nome próprio, e o BM25 faz o contrário.

Tarefa 2, o MAP no dev (AP por consulta e MAP). O RRF usa c = 60 e junta o BM25 com a LSA do k indicado.

| Candidato | q01 | q02 | q03 | MAP dev |
|---|---|---|---|---|
| BM25 | 0,750 | 0,225 | 1,000 | 0,658 |
| LSA k = 10 | 0,023 | 0,375 | 0,069 | 0,156 |
| LSA k = 20 | 0,032 | 0,417 | 0,096 | 0,181 |
| LSA k = 50 | 0,034 | 0,292 | 0,194 | 0,173 |
| LSA k = 220 | 0,667 | 0,417 | 1,000 | 0,694 |
| Híbrido k = 10 | 0,183 | 0,450 | 0,141 | 0,258 |
| Híbrido k = 20 | 0,183 | 0,500 | 0,267 | 0,317 |
| Híbrido k = 50 | 0,174 | 0,393 | 1,000 | 0,522 |
| Híbrido k = 220 | 0,700 | 0,268 | 1,000 | 0,656 |

Só para ver o formato da curva (não entrou na escolha), a LSA sozinha, no dev, dá MAP de 0,019 com k = 2, 0,067 com k = 5, 0,553 com k = 100, 0,617 com k = 150 e 0,694 com k = 200 e 220. O parâmetro c do RRF mexeu pouco: de c = 10 a c = 100, o MAP dev do híbrido com k = 10 foi de 0,303 a 0,254, com k = 20 de 0,395 a 0,299, com k = 50 de 0,539 a 0,520 e com k = 220 ficou em 0,656. Nenhum híbrido passou do BM25 em nenhum c.

A regra de decisão foi fixada antes de olhar o teste: vence o maior MAP no dev, e empate (diferença de até 0,005) fica com o mais simples. O vencedor é a LSA com k = 220 (MAP dev 0,694), contra 0,658 do BM25.

O teste, rodado uma única vez:

| Sistema | q04 | q05 | MAP teste |
|---|---|---|---|
| BM25 | 1,000 | 0,417 | 0,708 |
| Escolhido (LSA, k = 220) | 1,000 | 0,333 | 0,667 |

Tarefa 3, a decisão registrada, em `7-entrega-config.R`:

```r
  # --- Aula 07: LSA e hibrido ---
  modelo  = "lsa",     # decisao no dev
  lsa_k   = 220,       # k escolhido no dev (220 = numero de documentos)
  rrf_c   = 60         # padrao de Cormack et al.; nao foi ajustada, porque o hibrido nao foi o escolhido
```

## 3. Leitura dos resultados

1. A LSA só chega ao nível do BM25 quando k é igual ao número de documentos, e aí ela não comprime nada. Com k = 220 (posto cheio) o ranking é o do cosseno TF IDF da Aula 02: a razão entre os escores das duas é constante (3,489) nos 215 documentos com cosseno positivo na q01, e o MAP dev (0,694) é o mesmo da base da Aula 06. Com k de 10 a 50, o MAP dev fica entre 0,16 e 0,18.
2. A escolha do dev não se confirmou no teste: 0,667 contra 0,708 do BM25. A diferença vem da q05 (0,333 contra 0,417), e a q04 empata em 1,000. Com duas consultas de teste, e a q04 com um único relevante, não dá para dizer que um modelo é melhor. O que se pode dizer é que a LSA não trouxe ganho sobre o BM25 neste corpus.
3. A LSA ajuda onde a consulta é conceito e não nome. Na q02, "primeira cidade do Brasil", a LSA com k = 20 tem AP de 0,417 contra 0,225 do BM25, e os híbridos com k = 10 e k = 20 chegam a 0,450 e 0,500. Nas consultas de nome próprio (q01 e q03) a LSA com k pequeno piora muito. É uma consulta só, então vale como pista e não como conclusão.
4. No dev, nenhum híbrido superou o melhor candidato individual. Como o RRF dá o mesmo peso aos dois rankings, um lado ruim puxa o resultado para baixo.

## 4. Limites

1. São 5 consultas (3 no dev e 2 no teste), com 1 ou 2 relevantes cada. Uma posição a mais ou a menos muda muito o AP, e diferenças de 0,03 a 0,04 estão dentro do ruído.
2. Os julgamentos foram feitos antes de existir LSA, em 14 a 26 trechos por consulta (86 de 220), e trecho sem julgamento conta como não relevante. No top 10 do dev, o BM25 tem 0 de 30 posições sem julgamento; a LSA com k = 20 tem 16 de 30 e com k = 50 tem 11 de 30. Isso favorece sistemas lexicais. Um exemplo é `sv_41af95d229`, que fala do início da colonização e do primeiro núcleo institucional do Brasil e, pelo texto, parece tratar do tema da q02, mas ninguém o julgou. Para comparar a LSA com justiça, o grupo teria que julgar também o topo dela, e o kappa entre Lorenzo e Arthur Davino na Entrega 05 (0,393) já era fraco.
3. Os k do slide são poucos. Os valores extras (2, 5, 100, 150 e 200) foram olhados só no dev, para ver a curva, e não entraram na escolha.
4. Foi excluído do qrels o item sem maioria da Entrega 05.

## 5. Como esta parte foi feita, opinião da tutora

Eu não conduzi esta aula em sessão com o grupo. Rodei o código no meu ambiente, com o mesmo `motor08.R`, o mesmo corpus do repositório e os julgamentos reconstruídos do CSV da Entrega 05 pela regra do relatório (unanimidade ou maioria). A reconstrução bate com o que o grupo tinha na Aula 06: 86 itens, relevantes por consulta 2, 2, 2, 1 e 2, e os mesmos AP da base. Mesmo assim, o grupo precisa rodar o notebook no Colab e conferir que os números saem iguais, ler os textos do item 4 do notebook e confirmar a leitura que fiz, e dizer se concorda com a regra de decisão. Essa regra (maior MAP no dev, empate de até 0,005 fica o mais simples) é minha, definida antes de olhar o teste. Não tenho como dizer quem do grupo participou. Verificação final: não aplicada.

## 6. Para a ficha do projeto

Aula 07: LSA (SVD do TF IDF) e híbrido por RRF avaliados no corpus de 220 trechos. Decisão no dev (q01 a q03, MAP): modelo lsa com k = 220 (MAP 0,694; BM25 0,658). Teste (q04 e q05, uma vez): 0,667 contra 0,708 do BM25, sem ganho. `rrf_c = 60`, sem ajuste. Limites: k = 220 equivale ao cosseno TF IDF, e os julgamentos, feitos sem LSA, favorecem o BM25.

## 7. O que o grupo ainda decide

Como o teste não confirmou ganho, o grupo pode preferir manter o BM25 como modelo do motor. Isso é possível, mas é decisão tomada depois de ver o teste: deve ser registrada assim na ficha (com a linha `modelo = "bm25"` no config) e não apresentada como resultado do dev. Vale levar essa dúvida ao professor, junto com a questão de julgar o topo da LSA.

Depois de salvar este arquivo e a ficha na pasta do Colab, rode `anexar_estado("aula07_parteD_consolidado.md")` e `anexar_estado("00_FICHA_PROJETO.md")` para anexar o estado do R.
