---
tags: [architecture, tech-stack, java, angular, postgresql]
description: Definições arquiteturais para garantir escalabilidade e foco nos estudos de Java.
type: technical
---
# 🏗️ Decisões de Arquitetura

## 🖥️ Frontend: Angular
- **Uso**: Sites institucionais (Fase 1) e Painel SaaS (Fase 2).
- **Padrão**: Componentização extrema para reaproveitamento entre projetos.
- **SEO**: Implementação de Angular Universal (SSR) para garantir indexação no Google.

---

## ⚙️ Backend: Java Spring Boot
- **Motivação**: Robustez, segurança e foco no aprimoramento profissional do desenvolvedor.
- **Padrão Multi-Tenant**: 
    - Identificação do cliente via Hostname ou Header API-Key.
    - Filtro de dados por `tenant_id` em todas as queries.

---

## 🗄️ Banco de Dados: PostgreSQL
- **Escolha**: PostgreSQL (Dockerizado).
- **Vantagem**: Suporte a JSONB para campos flexíveis no CMS e integridade referencial sólida para o modelo SaaS.

---

## 🔗 Estrutura de Conectividade
- **Headless CMS**: O Front-end não possui lógica de banco de dados; ele consome a API central de forma agnóstica.
- **Segurança**: JWT para o Painel Administrativo e API-Keys de leitura para os sites públicos.
