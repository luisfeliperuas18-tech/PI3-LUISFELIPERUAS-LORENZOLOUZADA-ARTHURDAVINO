cfg <- list(
  limpar    = TRUE,                           # limpeza da Aula 03
  acentos   = "translit",                     # tira acentos (decidido na Aula 06)
  stopwords = character(0),                   # sem lista de stopwords
  k1 = 1.2, b = 0.75,                         # BM25
  limiar    = 2,                              # grau 2 conta como relevante
  # --- Aula 06: realimentacao ---
  prf_k   = 0,                                # 0 = sem pseudo-realimentacao
  rocchio = c(a = 1, b = 0.75, g = 0.15),     # pesos do Rocchio
  # --- Aula 07: LSA e hibrido ---
  modelo  = "lsa",                            # decisao no dev: "bm25", "lsa" ou "hibrido"
  lsa_k   = 220,                              # k escolhido no dev (220 = numero de documentos)
  rrf_c   = 60                                # constante do RRF (padrao de Cormack et al.; nao foi ajustada)
)
