---
tags: [meta, refresh, maintenance, optimization]
description: Protocolo de manutenção e otimização do conhecimento (Brain) para o assistente.
type: meta
---

# 🔄 Brain Refresh Protocol

Este documento define o procedimento operacional padrão para a validação, limpeza e otimização de todo o diretório `brain/`. Este protocolo deve ser executado sempre que solicitado ou quando houver uma mudança significativa na estrutura de trabalho.

## 🎯 Objetivos do Refresh
1.  **Consistência Metadata**: Garantir que 100% dos arquivos possuam o header YAML padronizado.
2.  **Performance de Contexto**: Reduzir ruído em arquivos grandes e garantir descrições precisas para facilitar a busca semântica.
3.  **Integridade do Grafo**: Validar links internos (`[[Link]]`) e organizar tags para um Grafo do Obsidian limpo.
4.  **Evolução Contínua**: Identificar lacunas de documentação e sugerir novos templates ou melhorias.

## 🛠️ Checklist de Execução (Passo a Passo)

### 1. Auditoria de Estrutura
- [ ] Listar recursivamente todos os diretórios do `brain/`.
- [ ] Identificar arquivos fora do padrão de nomenclatura (kebab-case ou PascalCase).
- [ ] Verificar se há arquivos perdidos fora das subpastas principais.

### 2. Validação de Metadata (Headers)
Para cada arquivo encontrado:
- [ ] **Tags**: Agrupar tags similares (ex: unificar `server` e `servers` em `servers`).
- [ ] **Description**: Refinar a descrição para que ela resuma o conteúdo em uma única frase poderosa.
- [ ] **Type**: Validar se o tipo (`meta`, `work`, `daily`, etc.) está correto conforme o diretório.

### 3. Otimização de Conteúdo
- [ ] **Links Quebrados**: Identificar e corrigir referências `[[ ]]` que apontam para arquivos inexistentes.
- [ ] **Arquivos Obsoletos**: Marcar ou mover para uma pasta de arquivo (se houver) documentos com informações defasadas.
- [ ] **Refatoração**: Sugerir a divisão de arquivos muito extensos em documentos menores e mais focados.

### 4. Sugestões de Melhoria
- [ ] Analisar se faltam templates em `90_Templates/` para atividades recorrentes observadas nos logs.
*Exemplo: "Notei que você faz muitos deploys de front-end manuais, sugiro criarmos um template de 'Post-Mortem-Deploy'."*

## 🚀 Como acionar este protocolo
Sempre que o usuário disser **"Refresh Brain"**, o assistente deve:
1.  Ler este arquivo.
2.  Executar a varredura conforme o checklist.
3.  Apresentar um resumo das alterações feitas e uma lista de sugestões de melhoria.

---
> [!IMPORTANT]
> A prioridade do Refresh é manter o conhecimento **acionável**. Menos é mais: se uma informação não ajuda a tomar uma decisão ou executar uma tarefa, ela deve ser arquivada ou resumida.
