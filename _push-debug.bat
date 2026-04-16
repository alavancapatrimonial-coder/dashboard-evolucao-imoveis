@echo off
REM ============================================================
REM  Push COM LOG para diagnostico
REM  Gera o arquivo push-log.txt na mesma pasta
REM ============================================================

cd /d "%~dp0"

set LOG=%~dp0push-log.txt

echo ================================================ > "%LOG%"
echo Data/hora: %DATE% %TIME% >> "%LOG%"
echo Diretorio: %CD% >> "%LOG%"
echo ================================================ >> "%LOG%"

echo.
echo === Verificando git ===
git --version >> "%LOG%" 2>&1
git --version

echo.
echo === Arquivos na pasta ===
dir /b >> "%LOG%" 2>&1
dir /b

echo.
echo === git init ===
git init >> "%LOG%" 2>&1
git init

echo.
echo === branch main ===
git branch -M main >> "%LOG%" 2>&1
git branch -M main

echo.
echo === config identidade ===
git config user.name "Alavanca Patrimonial" >> "%LOG%" 2>&1
git config user.email "alavancapatrimonial@gmail.com" >> "%LOG%" 2>&1

echo.
echo === git add . ===
git add . >> "%LOG%" 2>&1

echo.
echo === status apos add ===
git status --short >> "%LOG%" 2>&1
git status --short

echo.
echo === git commit ===
git commit -m "chore: deploy inicial da v11 (cliente)" >> "%LOG%" 2>&1
git commit -m "chore: deploy inicial da v11 (cliente)"

echo.
echo === log dos commits locais ===
git log --oneline >> "%LOG%" 2>&1
git log --oneline

echo.
echo === remote ===
git remote remove origin >> "%LOG%" 2>&1
git remote add origin https://github.com/alavancapatrimonial-coder/dashboard-evolucao-imoveis.git >> "%LOG%" 2>&1
git remote -v >> "%LOG%" 2>&1
git remote -v

echo.
echo === PUSH (force) ===
git push -u origin main --force >> "%LOG%" 2>&1
set PUSH_CODE=%ERRORLEVEL%
git push -u origin main --force

echo.
echo ================================================
echo EXITCODE do push: %PUSH_CODE%
echo EXITCODE do push: %PUSH_CODE% >> "%LOG%"
echo ================================================

if %PUSH_CODE% NEQ 0 (
  echo.
  echo !!! FALHOU. Ver detalhes em push-log.txt
  echo FALHOU >> "%LOG%"
) else (
  echo OK
  echo OK >> "%LOG%"
)

echo.
echo Log completo salvo em: %LOG%
pause
