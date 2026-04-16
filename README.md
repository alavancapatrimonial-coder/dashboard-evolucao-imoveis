# Dashboard Evolução Imóveis — Simulador de Consórcio

Simulador interativo de evolução patrimonial via cota de consórcio imobiliário Ademicon, desenvolvido pela **Alavanca Patrimonial**.

🌐 **Produção:** https://dashboard-evolucao-imoveis.vercel.app (após deploy Vercel)

---

## Sobre

Dashboard em HTML puro (vanilla JS + Chart.js 4.4.3) — single-file, sem backend, sem build step.

- Simulação de evolução da cota mês a mês
- 3 cenários pós-contemplação: venda com ágio, renda de aluguel e fundo Ademicon
- Tema dark/light (persistido em localStorage)
- Gráfico interativo com linha de contemplação
- Captação de leads integrada ao Google Sheets via Apps Script

## Estrutura

```
/
├── index.html      → versão cliente (pública) servida na raiz
├── vercel.json     → configuração de deploy estático
├── .gitignore
└── README.md
```

## Deploy

Deploy automático na Vercel a cada `git push` para `main`.

## Captação de leads

Form no final da página envia para Google Apps Script Web App (`SHEETS_URL` no HTML). Payload inclui dados do lead + snapshot completo da simulação (parâmetros + resultados dos 3 cenários).

---

© Alavanca Patrimonial
