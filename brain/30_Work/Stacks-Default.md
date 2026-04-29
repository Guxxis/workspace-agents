---
tags: [stack, standards, development, technologies]
description: Padronização das stacks tecnológicas utilizadas no desenvolvimento de sistemas.
type: work
---

# Stacks Padrões de Desenvolvimento

Este documento padroniza quais são as principais stacks que os Devs e POs utilizam na construção de novos sistemas, utilizando ou não IA no processo.

## 1. Stack Principal (Padrão)
Utilizada na maioria dos sistemas monolíticos, aplicações estabelecidas e CMS.
- **Frontend:** Laravel + Blade (ou Bootstrap/Tailwind integrado)
- **Backend:** Laravel (PHP)
- **Banco de Dados:** MySQL ou PostgreSQL
- **Servidor Ideal:** HestiaCP / VestaCP (servido nativamente via Nginx/Apache)

## 2. Stack PoC & Sistemas com IA (Teste e Rápidos)
Utilizada para provas de conceito, sistemas rápidos construídos com auxílio de IA e aplicações de alta reatividade (SPA).
- **Frontend:** React + Vite (Typescript)
- **Backend:** Node.js + Express (Typescript)
- **Banco de Dados:** PostgreSQL (ou SQLite para ambiente local e validação relâmpago)
- **Servidor Ideal:** Digital Ocean ou Servidores HestiaCP com Node.js e PM2 ativados.