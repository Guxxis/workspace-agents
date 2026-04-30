---
tags: [snippets, postgres, wordpress, commands, operations]
description: Coleção de comandos operacionais úteis para banco de dados, WordPress e utilitários de sistema.
type: note
---

# 🛠️ Operational Snippets

Esta é uma coleção de comandos rápidos e recorrentes para administração de sistemas, bancos de dados e aplicações.

## 🐘 PostgreSQL
**Exportar banco de dados (Dump):**
```bash
pg_dump -U idealtrends_lab -h localhost -O -x idealtrends_lab > file.sql
```
*   `-O`: Ignora a propriedade (Ownership) original.
*   `-x`: Previne o dump de privilégios (GRANT/REVOKE).

## 📝 WordPress (WP-CLI)
**Criar usuário administrador via terminal:**
```bash
wp user create douglas.avila douglas.avila@idealtrends.com.br --role=administrator --user_pass=rDlcZGGf67 --allow-root
```

## 🔒 Segurança e Web
**Gerar arquivo htpasswd para autenticação básica:**
```bash
htpasspwd -c .htpasspwd USER
```

**Baixar e renomear logo institucional (Exemplo):**
```bash
curl -O "https://idealtrendsgroup.com/wp-content/uploads/2020/12/logo-itg-normal-300x193.png"
mv logo-itg-normal-300x193.png logo.png
```
