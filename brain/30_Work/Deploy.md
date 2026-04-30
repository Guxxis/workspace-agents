---
tags: [deploy, standards, infrastructure, automation]
description: Padronização de procedimentos de deploy para diferentes stacks e ambientes.
type: work
---

# Padrões de Deploy de Sistemas

Este arquivo padroniza como deve ser feito o deploy e a configuração inicial de sistemas com base em cada stack listada em [[30_Work/Stacks-Default|Stacks-Default]].

## 1. Deploy Stack Principal (Laravel / PHP)
**Fluxo Básico (Servidores M3 / HestiaCP / VestaCP):**
1. Clonar repositório dentro do diretório do domínio ou usar actions de FTP.
2. Ajustar `Custom Document Root` no painel do domínio para apontar para a pasta `public/` do Laravel.
3. Instalar as dependências via terminal: `composer install` e construir assets frontais caso aplicável (`npm install && npm run build`).
4. Configurar `.env` com dados de Banco (criados no painel) e rodar migrações: `php artisan migrate`.
5. Ajustar permissões do Linux para pastas críticas (`storage` e `bootstrap/cache`).

---

## 2. Deploy Stack PoC (Vite + Node.js/Express - Via Apache)
**Fluxo Básico em Servidor HestiaCP / Painéis Clássicos**
Este modelo utiliza o Apache como fallback e arquivos `.htaccess`. Para projetos de produção, prefira o modelo de **Templates Nginx** (Seção 3).

**Passo 1: Preparação do Repositório**
* Clonar o código dentro do diretório de Domínios do HestiaCP (ex: na raiz `public_html/`).

**Passo 2: Backend (Express.js)**
* Acessar a pasta do backend, atualizar `.env` e rodar `npm install`.
* Iniciar com PM2: `pm2 start index.js --name "app-name"`.

**Passo 3: Frontend (Vite) e Roteamento SPA do Apache**
* Na pasta `web/public`, crie um o arquivo `.htaccess`:
  ```apache
  <IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^index\.html$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_URI} !^/api/
    RewriteRule . /index.html [L]
  </IfModule>
  ```

---

## 3. Deploy Profissional HestiaCP (Node.js + SPA - Nginx Nativo)
**Recomendado para Produção: Bypassa o Apache e usa Templates para Persistência.**

### Passo 1: Configuração do Domínio (Hestia Painel)
1.  **Document Root:** Ative "Custom document root" e aponte diretamente para a pasta buildada: `public_html/frontend-folder/dist`.
2.  **Template:** Selecione o template `NodeJS-SPA` (ver detalhes em `Server-Family.md`).

### Passo 2: Gerenciamento com PM2
O backend deve rodar via PM2 em uma porta fixa (ex: 3333).
*   **Ecosystem:** Use um arquivo `ecosystem.config.cjs` na raiz para gerenciar múltiplos serviços.
*   **Comando de Início:** `pm2 start ecosystem.config.cjs`

### Passo 3: Manutenção e Monitoramento (Comandos Essenciais)
*   `pm2 list`: Status geral dos processos.
*   `pm2 monit`: Monitoramento em tempo real (CPU/RAM/Logs).
*   `pm2 logs [nome]`: Visualizar logs específicos.
*   `pm2 save`: **OBRIGATÓRIO** após qualquer mudança para persistir após reboot do servidor.
*   `pm2 restart [nome] --update-env`: Reinicia aplicando novas variáveis do `.env`.
*   `pm2 flush`: Limpa logs antigos para liberar espaço.

---

## 4. Dicas Técnicas e Gotchas

### Conexão de Banco de Dados (Node.js + PostgreSQL)
Se a senha do banco contiver caracteres especiais (`@`, `?`, `=`, `]`), a `DATABASE_URL` no formato de string falhará com `ERR_INVALID_URL`.
*   **Solução:** Codificar a senha (URL Encoding).
    *   `@` -> `%40`
    *   `?` -> `%3F`
    *   `=` -> `%3D`
    *   `]` -> `%5D`
*   **Exemplo:** `postgresql://user:p%40ssw%3Drd@localhost:5432/db`
