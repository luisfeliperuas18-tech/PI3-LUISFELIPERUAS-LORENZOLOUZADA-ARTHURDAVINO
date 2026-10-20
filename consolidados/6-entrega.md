# Consolidado, PI III, Aula 06, Parte D, 2026-10-09
*guia versão 1 · tutora: Alexa (Claude) · sessão de grupo · motor06*
**Grupo:** Arthur Davino, Lorenzo Louzada, Luís Felipe Ruas · **presentes:** Davino (os demais a confirmar) · **digitou:** Davino, em todos os módulos

## 1. O que foi feito
* M7: Rocchio no gabarito do grupo (q01); completa contra residual
* M8: pseudorrealimentação em todas as consultas de desenvolvimento; teste relatado uma vez
* M9: decisão sem PRF; `config.R` e ficha

## 2. Como o grupo trabalhou, opinião da tutora
A sessão foi conduzida por uma pessoa do grupo, que rodou todo o código e conferiu as saídas com o esperado. As funções foram copiadas da teoria, não reescritas, e o teste no corpus do curso passou. Houve um achado bom do grupo: a ligação do `acentos = "manter"` com palavras partidas no corpus de vocês, corrigida com `translit`. O ponto fraco: várias respostas e decisões foram delegadas à tutora (a frase do checkpoint 7, a divisão dev e teste, a escolha do $k$ e a frase da decisão), então a compreensão de por que a completa é otimista e de por que o Rocchio atrapalhou a q01 ainda precisa ser fixada pelo grupo. A $k$ foi escolhida só no desenvolvimento e o teste rodou uma vez, sem ajuste depois. O grupo leu os documentos do *drift*.

## 3. Observações para a frente
* **Para a próxima sessão prática (Aula 07):** confirmar a decisão com o Lorenzo e o Luís Felipe, escrever a análise da q01 e rejulgar juntos o item sem maioria.
* **Perguntas guardadas:** o ganho é significativo? (Aula 16); achar documentos com outras palavras (Aula 07)
* **Produzido:** ver a entrada "Aula 06" na linha do tempo da ficha do projeto
* **Ficha atualizada:** sim, reconstruída; seções alteradas: 1 a 7 e cabeçalho

---

<!-- estado-R:inicio -->
## Estado do R ao fim da sessão
*gerado por `anexar_estado()` em 2026-10-12 17:14 · R version 4.6.1 (2026-06-24) · motor06 v1 2026-10-01 · não edite à mão*

### Objetos

| objeto | tipo | tamanho | valor / amostra |
|---|---|---|---|
| `base` | numeric, nomeado | 220 | san_89a217bd1e 0.1423, sv_758239684f 0.1118, san_b93b880263 0.1093, sv_651336a6c4 0.1059, san_31603f8e29 0.09443, san_787b827e51 0.09293, ... |
| `cfg$limpar` | logical | 1 | TRUE |
| `cfg$acentos` | character | 1 | translit |
| `cfg$stopwords` | character | 0 |  |
| `cfg$k1` | numeric | 1 | 1.2 |
| `cfg$b` | numeric | 1 | 0.75 |
| `cfg$limiar` | numeric | 1 | 2 |
| `cfg$prf_k` | numeric | 1 | 0 |
| `cfg$rocchio` | numeric, nomeado | 3 | a 1, b 0.75, g 0.15 |
| `consultas` | character, nomeado | 5 | q01 fundação de Santos, q02 primeira cidade do Brasil, q03 recuperação ambiental Cubatão, q04 urbanização e saneamento Sa..., q05 origem da democracia São Vi... |
| `cp` | data.frame | 220 × 8 | colunas: id, titulo, texto, data, fonte, url, pagina_inicio, pagina_fim |
| `dev` | character | 3 | q01, q02, q03 |
| `Dnr` | character | 4 | sv_758239684f, san_b93b880263, sv_651336a6c4, san_31603f8e29 |
| `docs` | character, nomeado | 220 | san_a489c65e47 Santos é um município brasi..., san_8cc33c2b34 Fundada em 1546 por Brás Cu..., san_8041328d59 Cidade mais populosa do lit..., san_347775ef72 O Guinness World Records si..., san_8f6ce77837 Verificam-se relatos a resp..., san_df1733f972 A coroa portuguesa interess..., ... |
| `Dr` | character | 2 | san_787b827e51, san_89a217bd1e |
| `Dr_v` | character | 1 | san_89a217bd1e |
| `fora` | character | 6 | san_787b827e51, san_89a217bd1e, sv_758239684f, san_b93b880263, sv_651336a6c4, san_31603f8e29 |
| `fora_v` | character | 5 | san_89a217bd1e, sv_758239684f, san_b93b880263, sv_651336a6c4, san_31603f8e29 |
| `g` | integer, nomeado | 17 | cub_046cac2e01 0, cub_753014eb08 0, cub_81ad47f21e 0, cub_89803e0d22 0, cub_93be0b43c3 0, san_020f4d07d6 0, ... |
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
| `ix_aula$tokens` | list | 8 | elementos: d1, d2, d3, d4, d5, d6, d7, d8 |
| `ix_aula$vocab` | character | 45 | a, acelera, aprendizado, avaliacao, bm25, busca, ... |
| `ix_aula$tf` | matrix | 45 × 8 | linhas: a, acelera, aprendizado, ... \| colunas: d1, d2, d3, d4, ... |
| `ix_aula$N` | integer | 1 | 8 |
| `ix_aula$df` | numeric, nomeado | 45 | a 4, acelera 1, aprendizado 1, avaliacao 1, bm25 1, busca 2, ... |
| `ix_aula$idf_tfidf` | numeric, nomeado | 45 | a 0.6931, acelera 2.079, aprendizado 2.079, avaliacao 2.079, bm25 2.079, busca 1.386, ... |
| `ix_aula$w` | matrix | 45 × 8 | linhas: a, acelera, aprendizado, ... \| colunas: d1, d2, d3, d4, ... |
| `ix_aula$wn` | matrix | 45 × 8 | linhas: a, acelera, aprendizado, ... \| colunas: d1, d2, d3, d4, ... |
| `ix_aula$postings` | list | 45 | elementos: recuperacao, de, informacao, ordena, documentos, por, relevancia, o, ... |
| `ix_aula$dl` | numeric, nomeado | 8 | d1 7, d2 9, d3 9, d4 6, d5 9, d6 8, ... |
| `ix_aula$avgdl` | numeric | 1 | 8 |
| `ix_aula$idf_bm25` | numeric, nomeado | 45 | a 0.6931, acelera 1.792, aprendizado 1.792, avaliacao 1.792, bm25 1.792, busca 1.281, ... |
| `k_grupo` | numeric | 1 | 3 |
| `MOTOR_VERSAO` | character | 1 | motor06 v1 2026-10-01 |
| `nec` | data.frame | 5 × 4 | colunas: consulta, texto_consulta, necessidade, escopo |
| `novo` | numeric, nomeado | 220 | san_787b827e51 0.8126, san_89a217bd1e 0.6033, san_9083a32966 0.17, san_54fa31513b 0.1512, san_7dd7e6aece 0.1324, san_de7d8d08a4 0.109, ... |
| `novo_v` | numeric, nomeado | 220 | san_89a217bd1e 0.9678, san_7dd7e6aece 0.1814, san_54fa31513b 0.1321, san_787b827e51 0.1097, san_b5cecbea4a 0.07444, cub_89803e0d22 0.06819, ... |
| `q` | character | 1 | q01 |
| `q_aula` | numeric, nomeado | 45 | a 0, acelera 0, aprendizado 0, avaliacao 0, bm25 0, busca 0, ... |
| `q0` | numeric, nomeado | 4757 | 0 0, 000 0, 0001 0, 001 0, 0026 0, 004 0, ... |
| `qrels$q01` | integer, nomeado | 17 | cub_046cac2e01 0, cub_753014eb08 0, cub_81ad47f21e 0, cub_89803e0d22 0, cub_93be0b43c3 0, san_020f4d07d6 0, ... |
| `qrels$q02` | integer, nomeado | 14 | cub_44c4c9211a 0, cub_b4e7969f47 0, san_1b34499bbc 0, san_210fda9d50 0, san_3f6b262b49 0, san_8041328d59 0, ... |
| `qrels$q03` | integer, nomeado | 14 | cub_046cac2e01 0, cub_0c499fd134 0, cub_1da16ed809 1, cub_3aa38bc5f7 0, cub_438f3ae0cb 0, cub_5fd1d7160a 0, ... |
| `qrels$q04` | integer, nomeado | 26 | cub_046cac2e01 0, cub_753014eb08 0, cub_81ad47f21e 0, cub_89803e0d22 0, cub_93be0b43c3 0, cub_b4e7969f47 0, ... |
| `qrels$q05` | integer, nomeado | 15 | cub_0767082add 0, cub_6d1fba4452 0, cub_89803e0d22 0, cub_a8c8d09197 0, san_1b178c7457 0, san_1e22505f02 0, ... |
| `qs` | character | 5 | q01, q02, q03, q04, q05 |
| `R_q` | integer, nomeado | 5 | q01 2, q02 2, q03 2, q04 1, q05 2 |
| `REPO` | character | 1 | https://raw.githubuserconte... |
| `rs` | data.frame | 86 × 3 | colunas: consulta, documento, grau |
| `tab_dev` | matrix | 4 × 3 | linhas: base, k2, k3, ... \| colunas: q01, q02, q03 |
| `tab_teste` | matrix | 2 × 2 | linhas: base, prf \| colunas: q04, q05 |
| `teste` | character | 2 | q04, q05 |
| `top5` | character | 5 | san_89a217bd1e, sv_758239684f, san_b93b880263, sv_651336a6c4, san_31603f8e29 |
| `usar` | character | 5 | q01, q02, q03, q04, q05 |

### Funções definidas

`anexar_estado`, `ap`, `ap_q`, `bm25`, `bm25_doc`, `busca_AND`, `busca_booleana`, `cfg_aula`, `cosseno`, `dcg`, `docs_aula`, `estado`, `gabarito_aula`, `idf_bm25`, `idf_classico`, `indice_invertido`, `kappa_cohen`, `kappa_matriz`, `ler_qrels`, `limpar`, `matriz_tf`, `metricas`, `montar`, `ndcg`, `norm_cols`, `precisao_k`, `preparar`, `prf`, `ranking_bm25`, `ranking_cosseno`, `ranking_motor`, `ranking_vetor`, `recall_k`, `relevancia`, `residual`, `rocchio`, `rr`, `saturacao`, `sem_stop`, `stopwords_aula`, `tokenizar`, `vetor_consulta`
<!-- estado-R:fim -->

