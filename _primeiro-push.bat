@echo off
REM ============================================================
REM  Primeiro push do Dashboard Evolução Imóveis para o GitHub
REM  Rode este arquivo APÓS criar o repositório em:
REM  https://github.com/new  (nome: dashboard-evolucao-imoveis)
REM ============================================================

cd /d "%~dp0"

echo.
echo === Inicializando git ===
git init
git branch -M main

echo.
echo === Configurando identidade (se ainda nao configurada) ===
git config user.name "Alavanca Patrimonial"
git config user.email "alavancapatrimonial@gmail.com"

echo.
echo === Commit inicial ===
git add .
git commit -m "chore: deploy inicial da v11 (cliente)"

echo.
echo === Conectando ao GitHub e fazendo push ===
git remote remove origin 2>nul
git remote add origin https://github.com/alavancapatrimonial-coder/dashboard-evolucao-imoveis.git
REM force-push porque o repo remoto ja possui .gitignore, README.md e vercel.json
REM criados via web UI durante a configuracao inicial (local tem versoes identicas)
git push -u origin main --force

echo.
echo ============================================================
echo  PUSH CONCLUIDO!
echo  Proximo passo: https://vercel.com/new
echo  Import: alavancapatrimonial-coder/dashboard-evolucao-imoveis
echo ============================================================
pause
