---
tags: [product, roadmap, evolution, saas]
description: Roadmap de evolução técnica e de produto, do MVP monolítico ao SaaS Multi-tenant.
type: freelance
---
# 🗺️ Roadmap de Evolução do Produto

## 🪵 Fase 1: MVP Monolítico (Validação)
*Foco: Validar a dor do cliente e fluxo de caixa inicial.*
- **Tecnologia**: Node.js + Express (Backend) + Angular (Frontend).
- **Modelo**: Monolito por cliente ou backend compartilhado simples.
- **Funcionalidades**: Site institucional + Blog administrativo simples.
- **Meta**: Entregar o projeto da [[Clinica-Psicologia-MVP]].

---

## 🚀 Fase 2: SaaS Centralizado (Escala)
*Foco: Centralização da manutenção e redução de custos de infra.*
- **Tecnologia**: **Java (Spring Boot)** + Angular + PostgreSQL.
- **Modelo**: **Headless CMS Multi-Tenant**.
- **Arquitetura**: Uma única API atende múltiplos fronts (sites) via `tenant_id`.
- **Painel Administrativo**: Área de login centralizada para clientes editarem seus próprios conteúdos.

---

## 📦 Módulos Planejados
1. **Core**: Gestão de textos, banners e SEO.
2. **Blog**: Sistema de postagens e categorias (SEO-driven).
3. **Catálogo**: Vitrine de produtos e integração com WhatsApp.
4. **Checkout**: Carrinho e pagamentos (Futuro).
