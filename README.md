# EV Smart Load Controller (RISC-V Assembly + Python Comparison)

## Integrantes

| Nome                       | RM     |
| -------------------------- | ------ |
| Luca Almeida Lucareli      | 569061 |
| Leonardo Scotti Tobias     | 573305 |
| Henrique Almeida Lucareli  | 569183 |
| Natan Silva da Costa       | 573100 |
| Enzo Seiji Delgado Tabuchi | 573156 |

---

## Problema

Eletropostos frequentemente utilizam software de alto nível e hardware genérico para tarefas simples, como:

* Autenticação de usuários
* Controle de carga de veículos
* Monitoramento de energia

Isso gera:

* Consumo desnecessário de energia computacional
* Maior número de ciclos de CPU
* Baixa eficiência energética

---

## Justificativa

Cada instrução executada por um processador consome energia.

Sistemas escritos em linguagens de alto nível:

* Executam mais instruções
* Possuem overhead de abstração
* Consomem mais energia

A solução é utilizar **Assembly**, aproximando o software do hardware.

---

## Proposta de Solução

Desenvolver um módulo de gerenciamento de carga em:

* **Assembly (RISC-V)** → versão otimizada
* **Python** → versão de comparação (alto nível)

Objetivo:

* Comparar eficiência computacional
* Demonstrar redução de consumo energético
* Aplicar conceitos de arquitetura de computadores

---

## Arquitetura Utilizada

* **ISA:** RISC-V (RV32I)
* **Modelo:** RISC (Reduced Instruction Set Computer)

### Vantagens:

* Instruções simples
* Execução previsível
* Menor consumo por instrução
* Ideal para sistemas embarcados

---

## Funcionamento do Sistema

### 1. Cálculo da Demanda

```text
demanda_individual = 100 - SoC
demanda_total = soma das demandas
```

---

### 2. Distribuição de Energia

Prioridade:

1. Energia Solar
2. Bateria
3. Rede Elétrica

---

## Implementação em Assembly (RISC-V)

* Uso direto de registradores
* Controle manual de memória
* Loop explícito para cálculo
* Uso de instruções otimizadas

---

## Comparação: Python vs Assembly

| Critério             | Python    | Assembly   |
| -------------------- | ------------ | ------------- |
| Nível                | Alto         | Baixo         |
| Controle de hardware | Nenhum       | Total         |
| Execução             | Interpretada | Direta na CPU |
| Nº de instruções     | Alto         | Baixo         |
| Ciclos de CPU        | Muitos       | Poucos        |
| Consumo energético   | Maior        | Menor         |
| Eficiência           | Média        | Alta          |

---

## Análise de Ciclos de CPU

### Python:

* Código interpretado
* Cada operação gera múltiplas instruções internas
* Pode consumir **centenas de ciclos**

### Assembly (RISC-V):

* ~1 ciclo por instrução (pipeline ideal)
* Execução direta no hardware

Resultado:

**Menos instruções → menos ciclos → menor consumo de energia**

---

## Otimizações no Assembly

### Uso de Registradores

* Evita acessos repetidos à memória

### Minimização de Branches

* Reduz penalidade no pipeline

### Código Enxuto

* Menor número de instruções

### Pipeline Otimizado

* Fluxo previsível

### Modo de Baixo Consumo

```asm
wfi
```

* CPU entra em estado de economia de energia
* Ideal para sistemas embarcados

---

## Sustentabilidade

Este projeto contribui para:

* Redução do consumo energético dos eletropostos
* Uso prioritário de energia solar
* Melhor eficiência computacional
* Menor necessidade de hardware potente

---

## Impactos Esperados

* Redução de consumo de energia computacional
* Melhor aproveitamento de energia renovável
* Maior eficiência em recarga de veículos elétricos
* Redução do impacto ambiental

---

## Possíveis Extensões

* Integração com sensores IoT
* Monitoramento em tempo real
* Implementação em hardware real
* Integração com smart grid

---

## Conclusão

A comparação entre Python e Assembly demonstra que:

* Linguagens de alto nível são mais fáceis de usar, porém menos eficientes
* Assembly oferece controle total do hardware e maior eficiência energética

Este projeto mostra como decisões de arquitetura impactam diretamente:

-> desempenho
-> consumo energético
-> sustentabilidade

---
