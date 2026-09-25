# Consolidado Entrega 0 - Introdução ao R

# Projeto Integrador III

Projeto desenvolvido para a disciplina de Projeto Integrador III da FATEC Rubens Lara.

## Integrantes

- Arthur Davino
- Lorenzo Louzada
- Luís Felipe Ruas

## Resumo do Notebook e Objetivos
Este notebook foi desenvolvido em **R** para servir como um laboratório prático de **Fundamentos da Linguagem R aplicados ao Processamento de Texto e Recuperação de Informação (RI)**. O foco principal foi dominar as estruturas de dados essenciais (vetores, listas, matrizes e fatores), além de explorar funções nativas para manipulação de strings, expressões regulares (regex) e operações matriciais.

---

## Atividades Realizadas e Aprendizados

**1. Manipulação de Vetores e Nomeação**
* **Operações Básicas:** Criação de vetores numéricos (`c()`) e aplicação de funções de agregação como `sum()`.
* **Vetores Nomeados:** Atribuição de rótulos/nomes a elementos (ex: `notas <- c(adriane = 9, luis = 10, arthur = 2)`) e acesso rápido por chave de texto (`notas["arthur"]`).

**2. Processamento de Texto e Tokenização**
* **Transformações e Divisão:** Uso de `toupper()` para padronização em maiúsculas e `strsplit()` para tokenização por espaços em branco.
* **Aplatamento de Listas:** Uso da função `unlist()` para converter a estrutura hierárquica retornada por `strsplit()` em um vetor simples de tokens.

**3. Programação Funcional e Mapeamento (`lapply` vs `sapply`)**
* **`lapply`:** Aplica uma função a cada elemento de uma lista e preserva o retorno no formato de **lista**.
* **`sapply`:** Aplica uma função e simplifica o resultado para um **vetor nomeado** sempre que possível.

**4. Contagem de Termos e Construção do Vocabulário**
* **`table(tokens)`:** Conta apenas os termos presentes na amostra.
* **`table(factor(tokens, levels = vocab))`:** Técnica fundamental em RI para mapear frequências em relação a um vocabulário fixo, garantindo que termos ausentes sejam representados com contagem `0`.

**5. Operações Matriciais e Reciclagem em R**
* **Matrizes:** Criação e nomeação de linhas/colunas (`rownames`, `colnames`).
* **Multiplicação Elemento a Elemento:** Demonstração da reciclagem de vetores ao multiplicar matrizes por vetores numéricos (`m * peso`).
* **Comportamento do Interpretador:** Identificação do aviso (*Warning*) emitido quando o tamanho de um vetor reciclado não é múltiplo exato do tamanho da matriz.

**6. Expressões Regulares (Regex) e Limpeza de Dados**
* **Verificação e Busca:**
  * `%in%`: Verificação booleana de pertinência a um vocabulário.
  * `grep()` / `grepl()`: Busca por padrões com suporte a *case insensitivity* (`ignore.case = TRUE`) e captura de metacaracteres/padrões quantificadores (ex: `[0-9]{4}`, `guaruja|cubatao`).
* **Substituição de Texto:**
  * `sub()`: Substitui apenas a primeira ocorrência do padrão.
  * `gsub()`: Substituição global de todas as ocorrências na string (útil para limpeza de sufixos de manchetes e remoção de espaços extras `\s{2,}`).

---

## Relevância para o Projeto de Recuperação de Informação
As técnicas exercitadas neste notebook constituem a base em R necessária para a construção de um motor de busca:
1. **Pré-processamento:** Limpeza de ruídos e padronização de textos via regex.
2. **Tokenização:** Quebra do documento em termos de busca.
3. **Representação Vetorial:** Alinhamento de frequências de termos com base em um vocabulário fixo para posterior cálculo de matrizes Termo-Documento e pontuações de relevância.
