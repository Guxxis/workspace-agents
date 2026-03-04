# 🛡️ Guxxis DevOps Workspace

Este é o workspace central para automação de tarefas de Engenharia de Software, DevOps e SRE. 

## 📂 Estrutura de Pastas

- `repositorys/`: Pasta dedicada aos repositórios e projetos de estudos ou trabalho. Todos os agentes operam dentro deste contexto.
- `.agent/`: Configurações e regras específicas para o comportamento dos agentes neste workspace.
- `TODO.md`: Roadmap de ideias e tarefas para novos agentes e projetos.

## 🚀 Como Utilizar este Workspace

1. **Adicione Projetos:** Sempre que iniciar um novo trabalho ou estudo, clone ou crie o repositório dentro da pasta `repositorys/`.
2. **Interaja com Agentes:** Utilize agentes (como o Antigravity) para automatizar tarefas repetitivas, realizar code reviews ou analisar incidentes.
3. **Mantenha o README:** Documente novos fluxos e padrões de automação aqui para garantir que o workspace evolua de forma organizada.

## 🛠️ Tecnologias Frequentes
- Terraform / Ansible (IaC)
- Kubernetes (Orquestração)
- Grafana / Prometheus / Datadog (Observabilidade)
- CI/CD Pipelines (Github Actions, Jenkins, etc)
- Cloud Providers (AWS, Azure, GCP)

---
*Foco na cultura SRE: Automação, Monitoramento e Resiliência.*


```bash
# Criar um novo repositório
$ mkdir -p repositorys/novo-projeto
$ cd repositorys/novo-projeto
$ git init
$ git remote add origin git@bitbucket-it:idealtrends/novo-projeto.git
$ git push -u origin main
```
### comandos:
open <repo>
open dw <repo>
open it <repo>
open dw <repo> <destino>
open it <repo> <destino>

```bash
# Criar um novo repositório por alias no bashrc
alias open='
function open() {

    # 🎨 Cores
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    RED="\033[0;31m"
    NC="\033[0m"

    ORG=""
    REPO=""
    DEST=""

    # Detecta argumentos
    if [ "$1" = "dw" ] || [ "$1" = "it" ]; then
        ORG=$1
        REPO=$2
        DEST=$3
    else
        REPO=$1
        DEST=$2
    fi

    if [ -z "$REPO" ]; then
        echo -e "${RED}Uso: open [dw|it] repo [destino opcional]${NC}"
        return 1
    fi

    # Função de clone
    clone_repo() {
        HOST=$1
        WORKSPACE=$2

        echo -e "${YELLOW}Clonando de $WORKSPACE...${NC}"
        git clone git@$HOST:$WORKSPACE/$REPO.git "$TARGET_DIR" 2>/dev/null
        return $?
    }

    # Define destino
    if [ -z "$DEST" ] || [ "$DEST" = "." ]; then
        TARGET_DIR="$REPO"
    else
        mkdir -p "$DEST"
        TARGET_DIR="$DEST/$REPO"
    fi

    # Confirma exclusão
    if [ -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}Projeto já existe em $TARGET_DIR${NC}"
        read -p "Deseja apagar? (s/n): " CONFIRM
        if [ "$CONFIRM" != "s" ]; then
            echo -e "${RED}Cancelado.${NC}"
            return 1
        fi
        rm -rf "$TARGET_DIR"
    fi

    SUCCESS=1

    # Se organização foi informada
    if [ -n "$ORG" ]; then
        case "$ORG" in
            dw)
                clone_repo "bitbucket-dw" "drdaweb"
                SUCCESS=$?
                ;;
            it)
                clone_repo "bitbucket-it" "idealtrends"
                SUCCESS=$?
                ;;
        esac
    else
        # 🔥 Auto-detecta organização
        clone_repo "bitbucket-dw" "drdaweb"
        SUCCESS=$?

        if [ $SUCCESS -ne 0 ]; then
            clone_repo "bitbucket-it" "idealtrends"
            SUCCESS=$?
        fi
    fi

    if [ $SUCCESS -ne 0 ]; then
        echo -e "${RED}Repositório não encontrado ou sem permissão.${NC}"
        return 1
    fi

    echo -e "${GREEN}Clone realizado com sucesso 🚀${NC}"

    code "$TARGET_DIR" || return 1
}
open'
```
