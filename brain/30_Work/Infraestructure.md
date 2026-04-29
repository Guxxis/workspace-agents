---
tags: [infrastructure, architecture, cloud, networking, vpn]
description: Visão geral da infraestrutura, provedores (M3, DO), redes e configurações SSH/VPN.
type: work
---
# Infraestrutura

## HUB de Repositórios

- Fornecedor: Bitbucket
- Modelo: Gitflow
- Repositorios: 
- Conventional Commits: 
- Tags: 

## M3

> Principal fornecedor de maquinas para hospedagem de sitemas

- Administrador: Marcio (M3)
- Principal Stack: PHP, MySQL, Apache, Wordpress
- Maquinas ubuntu com painel de controle Vesta CP ou Hestia CP
- Maquinas de Produção, Homologação e Staging

### Pacotes e Configurações Hestia / Vesta
O HestiaCP atua servindo os arquivos externamente via **Nginx** (Proxy Cache estático) e internamente com processamento por trás de um **Apache**.
- **Serviços Nativos:** Nginx, Apache2, MySQL/MariaDB, Postgre (Hestia), Exim/Dovecot.
- **Packs Extras Injetados para Sistemas Modernos:**
  - **Node.js** e **NPM** (via apt ou asdf/nvm).
  - **PM2**: Gerenciador de processos instalado globalmente (`npm install -g pm2`) utilizado para sustentar os backends em Node mantendo-os imunes a quedas ou crashes.
  - **Nginx Wildcard Includes**: Mecanismo de criação massiva de proxies reversos. Inclusão de blocos personalizados utilizando curingas do painel (`nginx.ssl.conf_*`) nas pastas `conf/web/seudominio/` para repassar conexões API ao PM2 rodando no localhost sem conflitar com configurações originais.

## Digital Ocean

> Teste de ferramentas e prova de conceito

- Administrador: TI GIT (Gustavo)
- maquinas 100% administradas pelo TI GIT
- pode ter qualquer tipo de infraestrutura


## SSH Config

```bash
Host [IP_ADDRESS]
    HostName [IP_ADDRESS]
    User root
    IdentityFile ~/.ssh/id_ansible
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
```

## VPN

### VPN’s

- IBM-UDP4-1194 - gustavo_goncalves
- 192.168.3.x - DSWGERAL-CLOUD-UDP4-1194
- 192.168.4.x - DSWPRODUCTION-CLOUD-UDP4-1194
- 192.168.6.x - DSWSOLUCOESINDUSTRIAIS-CLOUD-UDP4-1194
- 192.168.252.x - BUSCASITES-CLOUD-UDP4-1194
- 192.168.252.x - DSWSOLUC-CLOUD-UDP4-1194
- 192.168.253.x - DOUTORESSITES-CLOUD-UDP4-1194
- 192.168.254.x - DSWBUSCACLIENTE-CLOUD-UDP4-1194