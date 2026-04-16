# Wrapper Script para AIChat + Antigravity Context
param(
    [Parameter(Mandatory=$false)]
    [string]$Prompt,
    [Parameter(Mandatory=$false)]
    [ValidateSet("work", "personal")]
    [string]$Scope = "personal"
)

$AIChatPath = "C:\Users\gusta\AppData\Local\Microsoft\WinGet\Packages\sigoden.AIChat_Microsoft.Winget.Source_8wekyb3d8bbwe\aichat.exe"
$ContextPath = "C:\Workspace\.agent\context"

# 1. Carregar Regras Gerais
$SystemPrompt = Get-Content "$ContextPath\rules.md" -Raw

# 2. Carregar Standards
$Standards = Get-ChildItem "$ContextPath\standards\*.md"
foreach ($file in $Standards) {
    $SystemPrompt += "`n`n### Standard: $($file.Name)`n"
    $SystemPrompt += Get-Content $file.FullName -Raw
}

# 3. Carregar Contexto de Escopo (Work ou Personal)
if ($Scope -eq "work") {
    $SystemPrompt += "`n`n### Work Context`n"
    $SystemPrompt += Get-Content "$ContextPath\work-notion-context.md" -Raw
    $SystemPrompt += Get-Content "$ContextPath\memory\work-notion-context-bd.md" -Raw
} else {
    $SystemPrompt += "`n`n### Personal Context`n"
    $SystemPrompt += Get-Content "$ContextPath\personal-notion-context.md" -Raw
    $SystemPrompt += Get-Content "$ContextPath\memory\personal-notion-context-bd.md" -Raw
}

# Executar AIChat com o contexto
if ($Prompt) {
    & $AIChatPath -S "$SystemPrompt" "$Prompt"
} else {
    # Entrar em modo interativo com o sistema carregado
    & $AIChatPath -S "$SystemPrompt"
}
