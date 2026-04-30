---
tags: [diagnostic, mysql, cpu, performance, vestacp01, cookies]
description: Diagnóstico de sobrecarga de CPU no servidor VESTACP01 causado por queries lentas na tabela cookies.
type: diagnostic
status: resolved
date: 2026-04-29
---

# 🩺 Diagnóstico Técnico: Sobrecarga de CPU - DSW-VESTACP01-DOUTORES

## 📝 Visão Geral
**Servidor:** DSW-VESTACP01-DOUTORES (`192.168.3.20`)
**Data do Incidente:** 2026-04-29
**Sintoma:** CPU operando em 700%+ de carga, Load Average acima de 16, lentidão extrema nos serviços.
**Causa Raiz:** Ausência de índice composto na tabela `cookies`, resultando em Full Table Scans massivos.
**Resultado Pós-Intervenção:** CPU estabilizada em **10-12%** e queries respondendo em **milissegundos**.

---

## 🔍 Situação Inicial (Análise htop)
O servidor encontrava-se em um estado crítico de sobrecarga de processamento:

1.  **CPU no Limite:** Vários núcleos operando em quase 100%. O processo `mysqld` consumindo **737% de CPU**.
2.  **Load Average:** Índices em **11.79, 14.83, 16.14** (Sistema "afogando").
3.  **Memória:** Estável (~2.83GB de 27.5GB). Gargalo puramente de **CPU**.

---

## 🛠️ Diagnóstico Detalhado
A análise das queries travadas identificou um padrão recorrente:
```sql
SELECT * FROM cookies WHERE (ip = ? AND url = ? AND date = ?) LIMIT 1;
```

### O Problema
*   **Estado:** "Sending data" por longos períodos (31s, 29s, 27s).
*   **Comportamento:** Sem um índice adequado, o MySQL realiza um scan linha por linha na tabela para encontrar as correspondências. Como a tabela `cookies` é volumosa e recebe alta frequência de requisições, as consultas encavalaram, saturando o disco e a CPU.

---

## ✅ Solução Aplicada (O "Pulo do Gato")
Para resolver o problema instantaneamente e reduzir a carga de CPU para níveis nominais, foi recomendada a criação de um **índice composto**.

### Comando SQL:
```sql
ALTER TABLE `cookies` ADD INDEX `idx_ip_url_date` (`ip`, `url`, `date`);
```

### Por que isso resolve?
1.  **Acesso Direto:** Em vez de ler milhões de linhas, o MySQL agora utiliza o índice como um "sumário", indo direto ao endereço exato dos dados.
2.  **Performance:** A resposta de queries que levavam ~30 segundos passa a ser executada em milissegundos (~0.001s).

---

## 📈 Resultados Pós-Otimização
Após a criação do índice `idx_ip_url_date` (`ip`, `url`, `date`), os seguintes resultados foram validados:

### 1. Performance de Processamento
*   **Tempo de Resposta:** De 10-30 segundos para **milissegundos**.
*   **Uso de CPU:** De 700% para 90%**.

### 2. Volumetria de Dados (admin_cookies.cookies)
*   **Total de Registros:** 16.995.093 (~17 milhões de linhas).
*   **Tamanho em Disco:** 4.600 MB (4.6 GB).
*   **Análise de Retenção:**
    *   Registros > 180 dias: **13.846.743** (~81% da tabela).
    *   Registros > 1 ano: **10.813.521** (~63% da tabela).

---

## 💡 Recomendações (Próximos Passos)

### 1. Purga de Dados (Housekeeping)
A tabela possui um volume massivo de dados legados que podem ser removidos sem impacto operacional, liberando espaço em disco e otimizando ainda mais os backups:
*   **Sugestão:** Manter apenas os últimos 180 dias.
*   **Impacto:** Redução de ~80% no volume da tabela (remoção de 13.8M de linhas).

### 2. Estratégia de Deleção
Para evitar travar o banco durante a deleção de milhões de linhas, utilize deleções em lote (chunks):
```sql
-- Exemplo de deleção controlada
DELETE FROM `cookies` WHERE `date` < DATE_SUB(NOW(), INTERVAL 180 DAY) LIMIT 10000;
```

---
**Status:** ✅ Solucionado e Validado com Dados Reais.

