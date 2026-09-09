@echo off
REM ============================================================
REM  Deploy v13 — Rebrand Racon + TAXA_PRE 0,3382% + seguro
REM               + fundo configuravel + mascara BRL
REM
REM  Roda add / commit / push da versao 13 pro GitHub.
REM  A Vercel faz auto-deploy sozinha em ~30 segundos apos o push.
REM ============================================================

cd /d "%~dp0"

echo.
echo === Removendo lockfile antigo (se existir) ===
if exist ".git\index.lock" (
  del /f /q ".git\index.lock"
  echo   Lockfile removido.
) else (
  echo   Sem lockfile — OK.
)

echo.
echo === Configurando identidade git ===
git config user.name "Alavanca Patrimonial"
git config user.email "alavancapatrimonial@gmail.com"

echo.
echo === Status antes ===
git status --short

echo.
echo === Adicionando todas as mudancas ===
git add -A

echo.
echo === Status apos add ===
git status --short

echo.
echo === Commit v13 ===
git commit -m "feat(v13): rebrand Racon + TAXA_PRE 0,3382%% + seguro opcional + fundo configuravel + mascara BRL" -m "- Identidade visual: Racon Consorcios (Marinho #002E5F + Ciano #00B3E7)" -m "- Removido nome Ademicon do site inteiro" -m "- Header: logo Racon como hero + chancelas Member Rands e Alavanca Patrimonial" -m "- Watermark do simbolo Racon + halos de cor no fundo" -m "- Modo dark unico (removido toggle de tema)" -m "- Fonte: Mulish (fallback aberto do FS Elliot)" -m "- Calculo: TAXA_PRE 0,3382%% (era 0,3720%%)" -m "- Novo: seguro opcional MIP/DFI 0,0496%%" -m "- Novo: taxa fundo administradora configuravel (default 0,9%% a.m.)" -m "- Mascara BRL no campo Parcela Inicial (R$ 0.000,00)" -m "- Payload lead ampliado com taxaFundo e seguro"

echo.
echo === Enviando para o GitHub ===
git push origin main
set PUSH_CODE=%ERRORLEVEL%

echo.
echo ============================================================
if %PUSH_CODE% NEQ 0 (
  echo  !!!!  FALHA no push. Codigo: %PUSH_CODE%
  echo  !!!!  Verifique credenciais do GitHub e tente denovo.
) else (
  echo  ✓ PUSH CONCLUIDO!
  echo.
  echo  Proximo passo AUTOMATICO:
  echo    Vercel detecta o commit em segundos e faz o deploy.
  echo    Acompanhe em: https://vercel.com/dashboard
  echo.
  echo  URL do site quando terminar:
  echo    https://dashboard-evolucao-imoveis.vercel.app
)
echo ============================================================
echo.
pause
