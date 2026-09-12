# Aula 02 - Modelo de Espaço Vetorial e Similaridade do Cosseno

## Descrição

Este notebook contempla a implementação prática do Modelo de Espaço Vetorial (VSM) e a ponderação TF-IDF em linguagem R, utilizando o corpus controlado criado nas aulas iniciais de Recuperação de Informação. O objetivo principal foi transformar textos não estruturados em vetores numéricos e realizar consultas por similaridade de cosseno.

## Principais etapas

- **Recriação do Corpus:** Definição de um conjunto sintético de 8 documentos (`d1` a `d8`) cobrindo temas de Ciência de Dados, Recuperação de Informação e Aprendizado Estatístico.
- **Tokenização Padrão:** Construção de função customizada em R para conversão em minúsculas (`tolower`) e divisão por expressões regulares (`\s+`).
- **Construção do Vocabulário:** Mapeamento alfabético dos termos únicos extraídos (resultado: 45 termos únicos).
- **Matriz Termo-Documento (TDM):** Criação manual da matriz TDM de dimensão $45 \times 8$ com contagens absolutas de frequência de termos.
- **Cálculo da Frequência Inversa do Documento (IDF):** Aplicação da fórmula clássica de IDF: $IDF(t) = \log(N / df_t)$.
- **Ponderação TF-IDF:** Multiplicação matricial dos valores de TF da TDM pelo vetor IDF, gerando pesos ajustados por relevância e raridade do termo.
- **Métrica de Similaridade por Cosseno:** Implementação da função de cosseno entre dois vetores: 
  $$\text{cosseno}(a, b) = \frac{a \cdot b}{\|a\| \|b\|}$$
- **Engine de Busca:** Criação da função `buscar()`, que converte uma consulta textual em vetor TF-IDF e calcula o score de cosseno contra todos os documentos da base, retornando o ranqueamento ordenado.

## O que foi aprendido

- **Representação Vetorial:** Compreensão prática de como os documentos podem ser projetados em um espaço multidimensional onde a dimensão é dada pelo tamanho do vocabulário ($|V| = 45$).
- **Impacto do IDF:** Constatação de que palavras hiperfrequentes/genéricas (como a preposição "de") têm peso reduzido via IDF, enquanto palavras específicas (como "modelo" ou "documentos") aumentam significativamente a pontuação do documento.
- **Geometria da Similaridade:** O cálculo do ângulo entre os vetores (cosseno) normaliza o comprimento do texto, permitindo comparar a relevância do conteúdo independentemente do tamanho do documento.
- **Ranqueamento de Consultas:** Observou-se a eficácia do modelo em priorizar documentos que contêm palavras-chave centrais da busca (ex: para *"estatistica e ciencia de dados"*, o documento `d8` obteve o maior score: `0.788`).