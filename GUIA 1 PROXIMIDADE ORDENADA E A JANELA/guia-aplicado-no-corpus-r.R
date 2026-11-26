# ==========================================================================
# PI III, Aula 08, Tema 1: proximidade e janela aplicada ao corpus do grupo
# Pipeline: BM25 (estágio 1) -> reordena o top k pela proximidade (estágio 2)
# ==========================================================================

# ---- 1. Ambiente (igual ao guia) -----------------------------------------
REPO <- paste0(
  "https://raw.githubusercontent.com/",
  "luisfeliperuas18-tech/",
  "PI3-LUISFELIPERUAS-LORENZOLOUZADA-ARTHURDAVINO/main/"
)

source("https://raw.githubusercontent.com/fractalarea/pi3-motor-de-busca/main/motor/motor08.R")

cfg <- cfg_aula()
cfg$acentos <- "translit"

corpus <- read.csv(
  paste0(REPO, "estrutura/codigo/corpus/corpus_baixada_santista.csv"),
  fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE
)
necessidades <- read.csv(
  paste0(REPO, "estrutura/codigo/to%20delete/5-entrega-necessidades.csv"),
  fileEncoding = "UTF-8-BOM", stringsAsFactors = FALSE
)
julgamentos <- read.csv(
  paste0(REPO, "estrutura/codigo/corpus/7-qrels_consolidado_resolvidos.csv"),
  stringsAsFactors = FALSE
)

docs      <- setNames(corpus$texto, corpus$id)
consultas <- setNames(necessidades$texto_consulta, necessidades$consulta)
ix        <- montar(docs, cfg)

qrels <- lapply(unique(julgamentos$consulta), function(q) {
  d <- julgamentos[julgamentos$consulta == q, ]
  setNames(d$grau, d$documento)
})
names(qrels) <- unique(julgamentos$consulta)

dev   <- c("q01", "q02", "q03")
teste <- c("q04", "q05")

cat("Documentos:", length(docs), "| Consultas:", length(consultas),
    "| Julgamentos:", nrow(julgamentos), "\n")

# ---- 2. A função de proximidade ------------------------------------------
# Para cada par de termos distintos da consulta, pega a MENOR distância entre
# as ocorrências no documento. Se a distância cabe na janela w, o par vale
# 1 / distância (colado = 1, um termo no meio = 1/2, ...). Senão vale 0.
# ordenada = TRUE: o par só conta se aparece na mesma ordem da consulta.
proximidade <- function(termos, tokens, w, ordenada = TRUE) {
  termos <- unique(termos)
  if (length(termos) < 2) return(0)
  pos <- lapply(termos, function(t) which(tokens == t))
  total <- 0
  for (i in 1:(length(termos) - 1)) {
    for (j in (i + 1):length(termos)) {
      pa <- pos[[i]]; pb <- pos[[j]]
      if (!length(pa) || !length(pb)) next
      d <- outer(pa, pb, function(a, b) b - a)          # distância com sinal
      d <- if (ordenada) d[d > 0] else abs(d)[d != 0]
      if (!length(d)) next
      dmin <- min(d)
      if (dmin <= w) total <- total + 1 / dmin
    }
  }
  total
}

# Conferência à mão (a lógica do M1 e do M3 do consolidado):
tk <- c("modelo", "x", "de", "y", "de", "texto")
stopifnot(
  proximidade(c("modelo", "de"), tk, w = 1) == 0,
  proximidade(c("modelo", "de"), tk, w = 3) == 1/2,
  proximidade(c("modelo", "de", "texto"), tk, w = 5) == 1/2 + 1/5 + 1,
  proximidade(c("de", "modelo"), tk, w = 3, ordenada = TRUE)  == 0,
  proximidade(c("de", "modelo"), tk, w = 3, ordenada = FALSE) == 1/2
)
cat("Conferência à mão: OK\n")

# ---- 3. Reordenar o top k (a mesma função da Parte D) ---------------------
reordenar <- function(rk, k, sc) {
  ids <- names(rk)
  k <- min(k, length(ids))
  if (k == 0) return(ids)
  top  <- ids[seq_len(k)]
  nova <- top[order(-sc[top], seq_along(top))]   # empate: fica a ordem do BM25
  cauda <- if (k < length(ids)) ids[(k + 1):length(ids)] else character(0)
  c(nova, cauda)
}

ranking_prox <- function(q, k, w, ordenada = TRUE) {
  bm25_rk <- ranking_bm25(consultas[[q]], ix, cfg)
  if (k == 0) return(names(bm25_rk))
  termos <- preparar(consultas[[q]], cfg)
  top <- names(bm25_rk)[seq_len(min(k, length(bm25_rk)))]
  sc <- sapply(top, function(d) proximidade(termos, ix$tokens[[d]], w, ordenada))
  reordenar(bm25_rk, k, sc)
}

ap_de <- function(q, k, w, ordenada = TRUE) {
  metricas(ranking_prox(q, k, w, ordenada), qrels[[q]], cfg$limiar)[["AP"]]
}

# ---- 4. Exemplo ao vivo: uma consulta, antes e depois ---------------------
q <- "q02"
antes  <- ranking_prox(q, 0, 0)
depois <- ranking_prox(q, 5, 3, TRUE)   # top 5 do BM25, janela w = 3, ordem da consulta
cat("\nConsulta", q, ":", consultas[[q]], "\n")
print(data.frame(posicao = 1:5, BM25 = antes[1:5], BM25_Proximidade = depois[1:5],
                 grau_BM25 = qrels[[q]][antes[1:5]], grau_Prox = qrels[[q]][depois[1:5]]),
      row.names = FALSE)

# ---- 5. A grade, só no desenvolvimento (q01, q02 e q03) -------------------
grade <- expand.grid(k = c(0, 5, 10, 20), w = c(1, 2, 3, 5, 10),
                     ordenada = c(TRUE, FALSE))
grade <- grade[!(grade$k == 0 & (grade$w != 1 | !grade$ordenada)), ]  # k = 0 é o BM25 puro
grade$MAP_dev <- sapply(seq_len(nrow(grade)), function(i)
  mean(sapply(dev, function(q) ap_de(q, grade$k[i], grade$w[i], grade$ordenada[i]))))
grade <- grade[order(-grade$MAP_dev, grade$k, grade$w), ]
cat("\nGrade no desenvolvimento (topo):\n")
print(head(grade, 10), row.names = FALSE, digits = 4)

base_dev <- grade$MAP_dev[grade$k == 0]
cat("\nBM25 puro (k = 0), MAP no desenvolvimento:", round(base_dev, 4), "\n")

# ---- 6. Escolha pelo desenvolvimento e teste UMA vez ----------------------
melhor <- max(grade$MAP_dev)
empatados <- grade[grade$MAP_dev >= melhor - 0.005, ]
escolha <- empatados[order(empatados$k, empatados$w, -empatados$ordenada), ][1, ]

if (escolha$MAP_dev <= base_dev + 1e-9) {
  cat("\nSem vencedora: nenhuma versão superou o BM25 no desenvolvimento. Fica o BM25.\n")
  escolha <- grade[grade$k == 0, ][1, ]
} else {
  cat("\nEscolha (menor k entre os empatados):",
      "k =", escolha$k, "| w =", escolha$w,
      "|", ifelse(escolha$ordenada, "ordenada", "livre"),
      "| MAP_dev =", round(escolha$MAP_dev, 4), "\n")
}

map_teste <- function(k, w, ordenada)
  mean(sapply(teste, function(q) ap_de(q, k, w, ordenada)))

res_teste <- data.frame(
  versao   = c("BM25 puro", "BM25 + proximidade"),
  MAP_teste = c(map_teste(0, 1, TRUE), map_teste(escolha$k, escolha$w, escolha$ordenada))
)
cat("\nTeste (q04 e q05), uma vez só:\n")
print(res_teste, row.names = FALSE, digits = 4)

# AP por consulta, para ver onde mudou
cat("\nAP por consulta no teste:\n")
print(data.frame(
  consulta = teste,
  BM25 = sapply(teste, function(q) ap_de(q, 0, 1)),
  Proximidade = sapply(teste, function(q) ap_de(q, escolha$k, escolha$w, escolha$ordenada))
), row.names = FALSE, digits = 4)

# ---- 7. Efeito da janela: w sozinho, com k e ordem fixos -----------------
if (escolha$k > 0) {
  efeito_w <- data.frame(
    w = c(1, 2, 3, 5, 10),
    MAP_dev = sapply(c(1, 2, 3, 5, 10), function(w)
      mean(sapply(dev, function(q) ap_de(q, escolha$k, w, escolha$ordenada)))))
  cat("\nEfeito da janela (k e ordem da escolha), MAP no desenvolvimento:\n")
  print(efeito_w, row.names = FALSE, digits = 4)
  if (length(unique(round(efeito_w$MAP_dev, 10))) == 1)
    cat("A janela w não muda o resultado: registrar como janela sem efeito.\n")
}

# ---- 8. O que a proximidade mexeu no ranking -----------------------------
# Quantos documentos do top k trocaram de posição em cada consulta.
if (escolha$k > 0) {
  mexeu <- sapply(c(dev, teste), function(q) {
    a <- ranking_prox(q, 0, 1)[seq_len(escolha$k)]
    b <- ranking_prox(q, escolha$k, escolha$w, escolha$ordenada)[seq_len(escolha$k)]
    sum(a != b)
  })
  cat("\nPosições trocadas no top", escolha$k, "por consulta:\n")
  print(mexeu)
}

# ---- 9. Resumo para a apresentação ----------------------------------------
cat("\n================ RESUMO ================\n")
cat("BM25 puro     MAP dev:", round(base_dev, 3),
    "| MAP teste:", round(res_teste$MAP_teste[1], 3), "\n")
cat("Proximidade   MAP dev:", round(escolha$MAP_dev, 3),
    "| MAP teste:", round(res_teste$MAP_teste[2], 3), "\n")
if (res_teste$MAP_teste[2] > res_teste$MAP_teste[1] + 1e-9) {
  cat("Leitura: a proximidade melhorou o BM25 no teste.\n")
} else if (res_teste$MAP_teste[2] < res_teste$MAP_teste[1] - 1e-9) {
  cat("Leitura: a proximidade piorou o BM25 no teste.\n")
} else {
  cat("Leitura: a proximidade não mudou o MAP do teste (sem vencedora).\n")
}
cat("Cuidado: são só", length(consultas), "consultas, então a diferença é frágil.\n")
