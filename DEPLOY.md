# Deploy — GitHub + Vercel

Guia passo a passo para publicar a v11 em produção.

## Pré-requisitos
- GitHub com usuário `alavancapatrimonial-coder` ✅
- Vercel conectada ao GitHub ✅
- Git instalado no Windows ([git-scm.com](https://git-scm.com/download/win))
- URL Apps Script já embutida no `index.html` ✅

---

## Passo 1 — Criar o repositório no GitHub

1. Acesse https://github.com/new
2. **Repository name:** `dashboard-evolucao-imoveis`
3. **Owner:** `alavancapatrimonial-coder`
4. **Visibility:** Private (recomendado) ou Public
5. **NÃO** marque nenhuma opção de "Initialize this repository" (sem README, sem .gitignore — já temos)
6. Clique **Create repository**

---

## Passo 2 — Push do código (PowerShell do Windows)

Abra o **PowerShell** e cole o bloco inteiro:

```powershell
cd "C:\Users\NIKOLLAS\Dashboard Evolução Imoveis\deploy"

git init
git branch -M main
git add .
git commit -m "chore: deploy inicial da v11 (cliente)"
git remote add origin https://github.com/alavancapatrimonial-coder/dashboard-evolucao-imoveis.git
git push -u origin main
```

Se pedir login, o GitHub vai abrir a janela do navegador para autenticar via GitHub Desktop/browser.

> Se o comando `git config --global user.name` ainda não estiver setado, rode antes:
> ```powershell
> git config --global user.name "Alavanca Patrimonial"
> git config --global user.email "alavancapatrimonial@gmail.com"
> ```

---

## Passo 3 — Deploy na Vercel

1. Acesse https://vercel.com/new
2. Selecione **Import Git Repository**
3. Encontre `alavancapatrimonial-coder/dashboard-evolucao-imoveis` → **Import**
4. Tela de configuração:
   - **Project Name:** `dashboard-evolucao-imoveis` (gera URL `dashboard-evolucao-imoveis.vercel.app`)
   - **Framework Preset:** `Other` (HTML puro)
   - **Root Directory:** `.` (raiz)
   - **Build Command:** deixe vazio
   - **Output Directory:** deixe vazio
5. Clique **Deploy**

Em ~30s o projeto está no ar em:
```
https://dashboard-evolucao-imoveis.vercel.app
```

A Vercel passa a fazer **deploy automático** a cada `git push` para `main`.

---

## Passo 4 — Teste ponta a ponta em produção

1. Abra `https://dashboard-evolucao-imoveis.vercel.app`
2. Simule (parcela 1500, prazo 220 → algo assim)
3. Preencha o form de captação com dados seus
4. Verifique na planilha Google Sheets se a linha apareceu

---

## Atualizações futuras (workflow)

Sempre que criar uma nova versão cliente (ex: `simulador-consorcio-v12.html`):

```powershell
cd "C:\Users\NIKOLLAS\Dashboard Evolução Imoveis\deploy"
Copy-Item "..\simulador-consorcio-v12.html" "index.html" -Force
# substituir a SHEETS_URL dentro do index.html se for versão nova do zero
git add index.html
git commit -m "feat: atualiza simulador para v12"
git push
```

Em ~30s a Vercel faz o deploy automático.

---

## Domínio customizado (opcional)

Para usar um domínio próprio tipo `simulador.alavancapatrimonial.com.br`:
1. Vercel → projeto → **Settings → Domains**
2. **Add** → digita `simulador.alavancapatrimonial.com.br`
3. Vercel mostra registro CNAME (ex: `cname.vercel-dns.com`)
4. Adiciona o CNAME no seu registrador de domínio (Registro.br, GoDaddy, etc.)
5. Aguarde propagação (5min–24h)
