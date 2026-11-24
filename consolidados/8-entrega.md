# Consolidado — PI III — Aula 08 — Tema 1 (proximidade e janela) — 2026-11-23
*guia versão 1 · tutora: Claude (Anthropic) · motor08 (o motor09 ainda não estava publicado)*
**Aluno:** Lorenzo Louzada, Artur Davino, Luis Felipe Ruas

## 1. O que foi passado
- Ambiente: troquei o Colab de Python para R; o `motor09.R` deu 404 (ainda não publicado). Carreguei o `motor08.R`, que não tem `proximidade` nem `reordenar`; achei `reordenar` no notebook da Parte D do grupo, mas não `proximidade`. Por isso, o tema foi feito à mão, sem R.
- M1 — janela par a par: em `d3`, (`modelo`, `de`) dá 0 com $w = 1$ e $\frac{1}{2}$ com $w = 3$ e $w = 5$, porque só a menor distância entra; "modelo de texto" com $w = 5$ dá $\frac{1}{2} + \frac{1}{5} + 1 = 1{,}7$.
- M2 — janela no ranking: com $w = 1$ e $k = 3$, o ranking é `d2 d3 d1`, igual ao de $w = 3$; na consulta do gabarito, a janela não muda nada e só $k$ decide. Em "vetores de documentos", a janela maior traz pares frouxos e tira `d2` do topo.
- M3 — ordem livre: "relevancia documentos" em `d1` dá 0 na ordenada e $\frac{1}{2}$ na livre. Na consulta do gabarito, a livre premia "recuperação de informação" em `d1`, que é outra expressão, e o AP cai de $0{,}833$ para $0{,}583$.
- M4 — no corpus do grupo: discuti como registrar janela sem efeito e versão sem vencedora; a grade no corpus do grupo não foi rodada (depende de `proximidade`).

## 2. Como foi o aprendizado — opinião da tutora
Boa parte da sessão foi gasta com o ambiente (Colab em Python, motor09 inexistente, busca das funções nos notebooks), e o aluno foi persistente até isolar o problema. Depois pediu as questões em bloco e respondeu as oito dos módulos e as quatro do teste final de uma vez, em poucos minutos, com respostas corretas e bem justificadas: aplicou a regra da menor distância, o desempate pela ordem do estágio 1 e entendeu que a janela só decide se o par conta. Como as respostas vieram prontas, vi o resultado, não o raciocínio passo a passo. Os pontos incompletos foram dois: no M3, não disse que "recuperação de informação" é outra expressão nem quanto o AP caiu; no M4, não mencionou registrar $w = 3$ com a ressalva nem escolher $k$ como o menor entre os empatados no dev.
**Teste final:** acertou M1, M2, M3 e M4; a revisar: nada no teste. No M3, precisou do lembrete de que na ordem da consulta o par nem existe.

## 3. Observações para a frente
- **Revisar:** a regra de escolher $k$ como o menor entre empatados no dev; rodar o tema no R quando o `motor09.R` for publicado e conferir os valores feitos à mão.
- **Perguntas guardadas:** nenhuma.
- **Para o professor:** o guia aponta para o `motor09.R`, que ainda não existe no repositório; com o `motor08.R`, `exists("proximidade")` e `exists("reordenar")` dão `FALSE`.
- **Para o grupo:** no notebook da Parte D, o MAP do teste foi calculado para todos os $k$ antes da escolha; o certo é escolher só pelo dev e rodar o teste uma vez. Levar à apresentação: a proximidade ordenada pode perder respostas escritas em outra ordem, e a livre pode premiar expressões diferentes.

---

<!-- estado-R:inicio -->
## Estado do R ao fim da sessão
*gerado por `anexar_estado()` em 2026-11-23 19:59 · R version 4.6.1 (2026-06-24) · motor08 v2 2026-10-22 · não edite à mão*

### Objetos

| objeto | tipo | tamanho | valor / amostra |
|---|---|---|---|
| `cfg$limpar` | logical | 1 | TRUE |
| `cfg$acentos` | character | 1 | translit |
| `cfg$stopwords` | character | 0 |  |
| `cfg$k1` | numeric | 1 | 1.2 |
| `cfg$b` | numeric | 1 | 0.75 |
| `cfg$limiar` | numeric | 1 | 2 |
| `cfg$prf_k` | numeric | 1 | 0 |
| `cfg$rocchio` | numeric, nomeado | 3 | a 1, b 0.75, g 0.15 |
| `cfg$modelo` | character | 1 | bm25 |
| `cfg$lsa_k` | numeric | 1 | 2 |
| `cfg$rrf_c` | numeric | 1 | 60 |
| `consultas` | character, nomeado | 5 | q01 fundação de Santos, q02 primeira cidade do Brasil, q03 recuperação ambiental Cubatão, q04 urbanização e saneamento Sa..., q05 origem da democracia São Vi... |
| `corpus` | data.frame | 220 × 8 | colunas: id, titulo, texto, data, fonte, url, pagina_inicio, pagina_fim |
| `docs` | character, nomeado | 220 | san_a489c65e47 Santos é um município brasi..., san_8cc33c2b34 Fundada em 1546 por Brás Cu..., san_8041328d59 Cidade mais populosa do lit..., san_347775ef72 O Guinness World Records si..., san_8f6ce77837 Verificam-se relatos a resp..., san_df1733f972 A coroa portuguesa interess..., ... |
| `ix$tokens` | list | 220 | elementos: san_a489c65e47, san_8cc33c2b34, san_8041328d59, san_347775ef72, san_8f6ce77837, san_df1733f972, san_e493550918, san_d63c5a44c0, ... |
| `ix$vocab` | character | 4757 | 0, 000, 0001, 001, 0026, 004, ... |
| `ix$tf` | matrix | 4757 × 220 | linhas: 0, 000, 0001, ... \| colunas: san_a489c65e47, san_8cc33c2b34, san_8041328d59, san_347775ef72, ... |
| `ix$N` | integer | 1 | 220 |
| `ix$df` | numeric, nomeado | 4757 | 0 15, 000 1, 0001 1, 001 2, 0026 1, 004 1, ... |
| `ix$idf_tfidf` | numeric, nomeado | 4757 | 0 2.686, 000 5.394, 0001 5.394, 001 4.7, 0026 5.394, 004 5.394, ... |
| `ix$w` | matrix | 4757 × 220 | linhas: 0, 000, 0001, ... \| colunas: san_a489c65e47, san_8cc33c2b34, san_8041328d59, san_347775ef72, ... |
| `ix$wn` | matrix | 4757 × 220 | linhas: 0, 000, 0001, ... \| colunas: san_a489c65e47, san_8cc33c2b34, san_8041328d59, san_347775ef72, ... |
| `ix$postings` | list | 4757 | elementos: santos, e, um, municipio, brasileiro, no, litoral, do, ... |
| `ix$dl` | numeric, nomeado | 220 | san_a489c65e47 115, san_8cc33c2b34 118, san_8041328d59 78, san_347775ef72 158, san_8f6ce77837 64, san_df1733f972 53, ... |
| `ix$avgdl` | numeric | 1 | 91.71 |
| `ix$idf_bm25` | numeric, nomeado | 4757 | 0 2.657, 000 4.993, 0001 4.993, 001 4.482, 0026 4.993, 004 4.993, ... |
| `julgamentos` | data.frame | 86 × 3 | colunas: consulta, documento, grau |
| `MOTOR_VERSAO` | character | 1 | motor08 v2 2026-10-22 |
| `necessidades` | data.frame | 5 × 4 | colunas: consulta, texto_consulta, necessidade, escopo |
| `REPO` | character | 1 | https://raw.githubuserconte... |

### Funções definidas

`anexar_estado`, `ap`, `bm25`, `bm25_doc`, `busca_AND`, `busca_booleana`, `cfg_aula`, `cosseno`, `dcg`, `docs_aula`, `estado`, `gabarito_aula`, `idf_bm25`, `idf_classico`, `indice_invertido`, `kappa_cohen`, `kappa_matriz`, `ler_qrels`, `limpar`, `lsa`, `matriz_tf`, `metricas`, `montar`, `ndcg`, `norm_cols`, `precisao_k`, `preparar`, `prf`, `ranking_bm25`, `ranking_cosseno`, `ranking_lsa`, `ranking_vetor`, `recall_k`, `relevancia`, `residual`, `rocchio`, `rr`, `rrf`, `saturacao`, `sem_stop`, `stopwords_aula`, `tokenizar`, `vetor_consulta`
<!-- estado-R:fim -->

