# Script de Sincronização Automática do Workspace
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "Iniciando sincronização em $Timestamp..." -ForegroundColor Cyan

# Navegar para o diretório do workspace (garantir que estamos na raiz)
Set-Location "C:\Workspace"

# 1. Adicionar mudanças
git add .

# 2. Verificar se há mudanças para commit
$status = git status --porcelain
if ($status) {
    Write-Host "Mudanças detectadas. Criando commit..." -ForegroundColor Yellow
    git commit -m "Auto-sync: $Timestamp"
} else {
    Write-Host "Nenhuma mudança local detectada." -ForegroundColor Green
}

# 3. Pull com rebase para manter o histórico limpo
Write-Host "Puxando mudanças remotas..." -ForegroundColor Cyan
git pull --rebase origin main

# 4. Push
Write-Host "Enviando para o GitHub..." -ForegroundColor Cyan
git push origin main

Write-Host "Sincronização concluída!" -ForegroundColor Green
