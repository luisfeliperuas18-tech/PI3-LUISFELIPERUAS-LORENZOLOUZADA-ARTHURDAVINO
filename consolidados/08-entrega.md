# Consolidado Aula 08 - Parte D: Reordenacao Neural

# Projeto

**P.I 3 - Projeto Integrador III**

## Integrantes

- Arthur Davino
- Lorenzo Louzada
- Luís Felipe Ruas

  ## Notebook

 `08-entrega .ipynb`

## Metodologia

Foi utilizado um cross-encoder multilingue para calcular
escores dos pares consulta-documento e reordenar o top-k
dos resultados obtidos pelo BM25.

Corpus: 220 documentos.
Consultas: 5.
Desenvolvimento: q01, q02 e q03.
Teste: q04 e q05.

## MAP no desenvolvimento

| k | MAP |
|---|---:|
| 0 | 0.658333 |
| 5 | 0.741667 |
| 10 | 0.742063 |
| 20 | 0.727778 |

## MAP no teste

| k | MAP |
|---|---:|
| 0 | 0.708 |
| 5 | 1.000 |
| 10 | 1.000 |
| 20 | 1.000 |

## Decisao

O parametro escolhido foi rerank_k = 5.
Embora k = 10 tenha o maior MAP no desenvolvimento,
a diferenca em relacao a k = 5 foi inferior a 0.005.
Foi escolhido k = 5 por apresentar desempenho
praticamente equivalente com menor custo computacional.

## Conclusao

O rerank melhorou o MAP do BM25 no desenvolvimento
de 0.658 para 0.742 e no teste de 0.708 para 1.000.
Os resultados indicam melhoria na ordenacao dos documentos
relevantes nas consultas avaliadas.

Os resultados devem ser interpretados considerando
o numero reduzido de consultas e julgamentos.

Configuracao final: rerank_k = 5.
