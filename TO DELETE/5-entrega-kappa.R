# kappa.R -- concordância dos julgamentos
# Arquivos esperados na mesma pasta:
# qrels-Lorenzo.csv, qrels-Davino.csv, qrels-Luis.csv

ler_primeira <- function(arquivo) {
  q <- read.csv(arquivo, stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")
  q[!grepl("_p2$", q$juiz), ]
}

calc_kappa <- function(a, b, nome_a, nome_b) {
  chave_a <- paste(a$consulta, a$documento)
  chave_b <- paste(b$consulta, b$documento)
  comuns <- intersect(chave_a, chave_b)

  ga <- a$grau[match(comuns, chave_a)]
  gb <- b$grau[match(comuns, chave_b)]

  m <- table(factor(ga, 0:2), factor(gb, 0:2))
  n <- sum(m)
  po <- sum(diag(m)) / n
  pe <- sum(rowSums(m) * colSums(m)) / n^2
  kappa <- (po - pe) / (1 - pe)

  cat("\n", nome_a, "x", nome_b, "\n")
  print(m)
  print(round(c(po = po, pe = pe, kappa = kappa), 3))
}

lorenzo <- ler_primeira("qrels-Lorenzo.csv")
davino  <- ler_primeira("qrels-Davino.csv")
luis    <- ler_primeira("qrels-Luis.csv")

calc_kappa(lorenzo, davino, "Lorenzo", "Arthur Davino")
calc_kappa(lorenzo, luis,   "Lorenzo", "Luís Felipe")
calc_kappa(davino,  luis,   "Arthur Davino", "Luís Felipe")

# Segunda passada de Arthur Davino
qd <- read.csv("qrels-Davino.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")
p1 <- qd[!grepl("_p2$", qd$juiz), ]
p2 <- qd[ grepl("_p2$", qd$juiz), ]

chave1 <- paste(p1$consulta, p1$documento)
chave2 <- paste(p2$consulta, p2$documento)
comuns <- intersect(chave1, chave2)

a <- p1$grau[match(comuns, chave1)]
b <- p2$grau[match(comuns, chave2)]

m <- table(factor(a, 0:2), factor(b, 0:2))
n <- sum(m)
po <- sum(diag(m)) / n
pe <- sum(rowSums(m) * colSums(m)) / n^2
kappa <- (po - pe) / (1 - pe)

cat("\nArthur Davino: primeira x segunda passada\n")
print(m)
print(round(c(po = po, pe = pe, kappa = kappa), 3))
