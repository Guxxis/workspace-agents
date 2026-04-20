---
context: work
status: active
tags:
  - infrastructure
  - architecture
  - documentation
  - servers
  - gitflow
  - cloud
type: documentation
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