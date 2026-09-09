@echo off
REM ============================================================
REM  Push do módulo Aposentadoria Imobiliária v5
REM  Execute este arquivo na pasta "deploy"
REM ============================================================

cd /d "%~dp0"

echo.
echo === Limpando lock residual (se existir) ===
del /f /q .git\index.lock 2>nul
echo    OK

echo.
echo === Status atual ===
git status --short

echo.
echo === Adicionando novos arquivos ===
git add aposentadoria-imobiliaria\

echo.
echo === Commit ===
git commit -m "feat: aposentadoria-imobiliaria v5 — dashboard com timeline PDF 5 paginas"

echo.
echo === Push para GitHub ===
git push origin main

echo.
echo ============================================================
echo  PUSH CONCLUIDO!
echo  Repo: https://github.com/alavancapatrimonial-coder/dashboard-evolucao-imoveis
echo.
echo  Proximo passo: criar projeto no Vercel apontando para
echo  a subpasta  aposentadoria-imobiliaria
echo  https://vercel.com/new
echo ============================================================
pause
