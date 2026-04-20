---
tags:
  - servers
  - documentation
  - infrastructure
  - family
last_updated: 2026-04-17
context: work
type: documentation
description: documentação do agrupamento de servidores separado por familia
---
## PADRONIZAÇÃO 
|Tipo de Uso|Ambiente:|
|---|---|
| Interno | Produção |
| Externo | Homologação |
| Misto | Infraestrutura |

### Nomenclatura nome de Famílias
> !provedor-!empresa-!objetivo-?quantidade

provedor = M3, DO (Digital Ocean), AWS, MS (Meu Servidor), etc. 
empresa = DW (Doutores da Web), BUSCA (Busca Clientes), etc.
objetivo = FERRAMENTAS, ESTATICOS, WP, SISTEMAS, etc. 
quantidade = numero de familias com o mesmo objetivo

! = obrigatório
? = opcional

## FAMILIAS

### Doutores da Web
- IBM-DW-SITES - Sites de cliente MPI antigo
- M3-DW-SITES - Site de clientes MPI novo
- M3-DW-SISTEMAS - Sistemas Operação
- DO-DW-AUTOMACAO - Automação de processos

### Busca Clientes
- IBM-BUSCA-SITES - Sites de cliente MPI antigo
- M3-BUSCA-SITES - Site de clientes MPI novo
- M3-BUSCA-COTANET - Sistema de cotação
- M3-BUSCA-PLATAFORMA - Plataforma de sites
- DO-BUSCA-AUTOMACAO - Automação de processos

### Soluções Industriais
- M3-SOIN-CRM - CRM
- M3-SOIN-SATELITES - Satélites de sites
- M3-SOIN-SISTEMAS - Sistemas Operação
- M3-SOIN-SITES - Sites de clientes

### Ideal Trends
- M3-IT-INFRA - Infraestrutura
- DO-IT-SITES
- DO-IT-SATELITES
- DO-IT-AUTOMACAO
- DO-IT-SISTEMAS
- M3-IT-SISTEMAS

### Ideal Sales
- M3-IS-SISTEMAS

### Clinica Ideal
- M3-CI-IDEALPAY - Sistema de pagamentos
- M3-CI-SISTEMAS - MPI

### Growth Content
- MS-GROWTH-WP - VPS com wordpress dos sistes da casa
- MS-GROWTH-AUTOMACAO - Automação de processos

### MPI Solutions
- M3-MPISOL-IDEALPLUS - Servidores ideal plus 
- M3-MPISOL-AUTOMACAO - Automação de processos
- M3-MPISOL-SITES - Sistemas Operação
- M3-MPISOL-SISTEMAS - Sistemas Operação

## Anne Caroline
- M3-AC-ECOMMERCE - E-commerce

## Ideal Marketing
- M3-IM-BLOGS
- M3-IM-SISTEMAS

