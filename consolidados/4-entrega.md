# Consolidado Entrega 4 - Modelo Probabilístico de Ranqueamento e BM25

# Projeto

**P.I 3 - Projeto Integrador III**

## Integrantes

- Arthur Davino
- Lorenzo Louzada
- Luís Felipe Ruas

  ## Notebook

 `4-entrega .ipynb`

## Descrição

Este notebook foca na implementação prática do algoritmo **Okapi BM25**, o modelo de ranqueamento probabilístico de texto mais amplamente utilizado em motores de busca clássicos. O exercício contrasta os resultados do BM25 com o Modelo de Espaço Vetorial (TF-IDF + Cosseno) implementado na Aula 02, explorando a influência dos hiperparâmetros $k_1$ e $b$.

## Principais etapas

- **Estruturação do Corpus:** Reutilização do corpus controlado de 8 documentos (`d1` a `d8`) e tokenização simples.
- **Métricas Globais e IDF Probabilístico:** Cálculo do comprimento dos documentos ($d_l$), comprimento médio do corpus ($\text{avgdl}$) e implementação da fórmula de IDF Probabilístico:
  $$IDF(t) = \log\left(\frac{N - df + 0.5}{df + 0.5}\right)$$
- **Implementação do BM25 (`bm25_doc`):** Algoritmo de cálculo de pontuação considerando saturação de frequência de termo e penalização por tamanho de documento:
  $$S(D, Q) = \sum_{t \in Q} IDF(t) \cdot \frac{f(t, D) \cdot (k_1 + 1)}{f(t, D) + k_1 \cdot \left(1 - b + b \cdot \frac{|D|}{\text{avgdl}}\right)}$$
- **Comparativo BM25 vs. TF-IDF:** Avaliação de 3 consultas distintas em ambas as abordagens para análise de ordenação e diferença de escala das pontuações.
- **Análise de Sensibilidade de Parâmetros (Hiperparâmetros $k_1$ e $b$):** Variação sistemática de $k_1 \in \{0, 1.2, 3.0\}$ e $b \in \{0, 0.75, 1.0\}$ na consulta *"modelo de recuperacao"*.

## O que foi aprendido

- **Saturação de Frequência ($k_1$):** Aprendeu-se que o parâmetro $k_1$ limita o impacto da repetição exaustiva de um termo no mesmo documento. Quando $k_1 = 0$, a frequência do termo é ignorada e apenas a presença/ausência da palavra conta.
- **Normalização pelo Tamanho do Documento ($b$):** O parâmetro $b$ controla o quanto o tamanho do documento pune a sua pontuação. Quando $b = 0$, a extensão do documento é ignorada; quando $b = 1$, a penalização por documentos longos é total.
- **BM25 vs. Espaço Vetorial:** Notou-se que o BM25 gera pontuações absolutas e acumulativas (não limitadas a 1.0 como a similaridade do cosseno), apresentando maior robustez e flexibilidade técnica para calibrar motores de busca reais em comparação ao TF-IDF simples.
