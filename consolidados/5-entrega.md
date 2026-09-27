# Consolidado Entrega 5 - Julgamento de Relevância

# Projeto

**P.I 3 - Projeto Integrador III**

## Integrantes

- Arthur Davino
- Lorenzo Louzada
- Luís Felipe Ruas

  ## Notebook

 `5-entrega .ipynb`

# Relatório consolidado dos julgamentos de relevância

## 1. Visão geral

- Avaliadores: Lorenzo, Arthur Davino e Luís Felipe.
- Itens julgados na primeira passada por todos: **87**.
- Itens com unanimidade: **64**.
- Itens resolvidos por maioria (2 de 3): **22**.
- Itens sem maioria, com três notas diferentes: **1**.

## 2. Regra usada para o consolidado

- Quando os três avaliadores deram a mesma nota, foi mantida essa nota.
- Quando dois avaliadores concordaram e um discordou, foi usada a nota da maioria.
- Quando os três deram notas diferentes, o item foi marcado como **revisar** e ficou sem grau consolidado.

> Observação: essa regra é uma consolidação mecânica para organizar o trabalho. Os itens marcados como `revisar` ainda precisam de decisão humana do grupo.

## 3. Concordância entre avaliadores

| Comparação | Concordância observada | p_e | κ de Cohen | Leitura |
|---|---:|---:|---:|---|
| Lorenzo × Arthur Davino | 0.782 | 0.641 | **0.393** | fraca — o guia recomenda revisar os critérios e rejulgar |
| Lorenzo × Luís Felipe | 0.805 | 0.656 | **0.431** | moderada — aceitável, mas deve ser registrada como limitação |
| Arthur Davino × Luís Felipe | 0.874 | 0.651 | **0.638** | boa — pode seguir |

## 4. Consistência da segunda passada

Arthur Davino realizou uma segunda passada em **18 itens**.

- Concordância observada: **0.889**
- Concordância esperada ao acaso: **0.796**
- κ de Cohen: **0.455**
- Interpretação: moderada — aceitável, mas deve ser registrada como limitação.

## 5. Próximo passo

Existem **1 itens sem maioria**. Esses itens precisam ser revistos pelo grupo antes de fechar o qrels definitivo.

Também é recomendável revisar os casos que contribuíram para o κ abaixo de 0,4 entre Lorenzo e Arthur Davino, pois o passo a passo orienta revisar o guia de julgamento quando a concordância é fraca.

## 6. Arquivos gerados

- `qrels_consolidado.csv`: mostra as três notas, a nota consolidada e o status de cada item.
- `qrels_consolidado_resolvidos.csv`: contém apenas `consulta,documento,grau` para itens com unanimidade ou maioria.
- `relatorio_consolidado_julgamentos.md`: este relatório.
