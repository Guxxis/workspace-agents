---
description: Fluxo de trabalho para criar uma nova documentação de processo, garantindo o uso dos modelos e instruções corretos.
---

1. Ler contexto estático (para consistência de nomenclatura): @[.agent/context/ferramentas.md], @[.agent/context/fluxos.md]
2. Ler o arquivo de instruções do agente: @[.agent/prompts/agt-documentacao.md]
2. Ler o modelo de input: @[.agent/templates/input-modelo-documentacao.md]
3. Ler o modelo de output: @[.agent/templates/output-modelo-documentacao.md]
4. Seguir rigorosamente as instruções em `agt-documentacao.md` para:
    a. Solicitar os dados de entrada do usuário conforme `input-modelo-documentacao.md`.
    b. Validar a entrada.
    c. Gerar a documentação final conforme `output-modelo-documentacao.md`.
