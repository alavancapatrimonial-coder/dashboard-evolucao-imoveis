// =============================================================
//  ALAVANCA PATRIMONIAL — Captação de Leads
//  Dashboard Evolução Imóveis (v11 cliente)
//
//  COMO USAR:
//  1. Abra sua planilha do Google Sheets que recebe os leads
//  2. Copie o ID da planilha do URL:
//     https://docs.google.com/spreadsheets/d/AQUI_ESTA_O_ID/edit
//  3. Cole o ID na constante SHEET_ID abaixo
//  4. Clique em Salvar (disquete) → Implantar → Gerenciar implantações
//  5. No deploy existente, clique no lápis (editar) → "Nova versão" → Implantar
//     (NÃO criar nova URL — mantém a mesma URL que já está no site)
//
// =============================================================

// >>> EDITE AQUI <<<
const SHEET_ID   = 'COLE_AQUI_O_ID_DA_PLANILHA';
const SHEET_NAME = 'Leads';   // nome da aba dentro da planilha (cria automaticamente se não existir)

// Cabeçalhos das colunas — gerados automaticamente na primeira linha
const HEADERS = [
  'Timestamp', 'Nome', 'E-mail', 'Telefone',
  'Parcela', 'Prazo', 'INCC', 'Aluguel %', 'Mês Contempl.',
  'Crédito Inicial', 'Parcela Pós', 'Desembolso Total',
  'C1 Crédito Contempl.', 'C1 Ágio Bruto', 'C1 Retorno Líq.', 'C1 ROI Total', 'C1 ROI/mês',
  'C2 Valor Imóvel', 'C2 Renda Bruta Mensal', 'C2 ROI/mês',
  'C3 Capital Inicial', 'C3 Valor Final', 'C3 Ganho Líq.'
];

// =============================================================
//  ENDPOINT PRINCIPAL — chamado pelo form do site
// =============================================================
function doPost(e) {
  try {
    // 1. Parse do payload JSON vindo do form
    const data = JSON.parse(e.postData.contents);

    // 2. Abre a planilha e a aba (cria aba se não existir)
    const ss = SpreadsheetApp.openById(SHEET_ID);
    let sheet = ss.getSheetByName(SHEET_NAME);
    if (!sheet) sheet = ss.insertSheet(SHEET_NAME);

    // 3. Se a planilha está vazia, adiciona cabeçalho
    if (sheet.getLastRow() === 0) {
      sheet.appendRow(HEADERS);
      const hdr = sheet.getRange(1, 1, 1, HEADERS.length);
      hdr.setFontWeight('bold');
      hdr.setBackground('#2563eb');
      hdr.setFontColor('#ffffff');
      sheet.setFrozenRows(1);
    }

    // 4. Monta a linha na ordem do cabeçalho
    const row = [
      data.timestamp || new Date().toLocaleString('pt-BR'),
      data.nome || '',
      data.email || '',
      data.telefone || '',
      data.parcela || '',
      data.prazo || '',
      data.incc || '',
      data.aluguel || '',
      data.mesContemplacao || '',
      data.creditoInicial || '',
      data.parcelaPos || '',
      data.desembolsoTotal || '',
      data.c1CreditoContempl || '',
      data.c1AgioBruto || '',
      data.c1RetornoLiquido || '',
      data.c1ROITotal || '',
      data.c1ROIMensal || '',
      data.c2ValorImovel || '',
      data.c2RendaBrutaMensal || '',
      data.c2ROIMensal || '',
      data.c3CapitalInicial || '',
      data.c3ValorFinal || '',
      data.c3GanhoLiquido || ''
    ];

    // 5. Anexa a linha
    sheet.appendRow(row);

    // 6. Retorna sucesso (útil para debug; o front usa no-cors e ignora)
    return ContentService
      .createTextOutput(JSON.stringify({ ok: true, rows: sheet.getLastRow() }))
      .setMimeType(ContentService.MimeType.JSON);

  } catch (err) {
    // Em caso de erro, grava no Logs para você ver no "Execuções"
    console.error('Erro ao salvar lead:', err, 'payload:', e && e.postData && e.postData.contents);
    return ContentService
      .createTextOutput(JSON.stringify({ ok: false, error: String(err) }))
      .setMimeType(ContentService.MimeType.JSON);
  }
}

// =============================================================
//  doGet — para testar se o endpoint está ativo via navegador
//  Abra a URL /exec no navegador e deve mostrar esta mensagem
// =============================================================
function doGet() {
  return ContentService
    .createTextOutput('Endpoint Alavanca ativo — use POST com JSON para registrar lead.')
    .setMimeType(ContentService.MimeType.TEXT);
}

// =============================================================
//  FUNÇÃO DE TESTE — rode manualmente no editor para validar
//  sem precisar do form. Abre a planilha e insere uma linha de teste.
// =============================================================
function testeManual() {
  const fakePayload = {
    timestamp: new Date().toLocaleString('pt-BR'),
    nome: 'TESTE MANUAL DO EDITOR',
    email: 'teste@alavanca.com',
    telefone: '11 99999-0000',
    parcela: 'R$ 1.500',
    prazo: '220 meses',
    incc: '6% a.a.',
    aluguel: '0.7% a.m.',
    mesContemplacao: 'Mês 60',
    creditoInicial: 'R$ 444.180',
    parcelaPos: 'R$ 4.590',
    desembolsoTotal: 'R$ 550.783',
    c1CreditoContempl: 'R$ 630.000',
    c1AgioBruto: 'R$ 252.000',
    c1RetornoLiquido: 'R$ 201.217',
    c1ROITotal: '224.13%',
    c1ROIMensal: '2.07% a.m.',
    c2ValorImovel: 'R$ 630.000',
    c2RendaBrutaMensal: 'R$ 4.410',
    c2ROIMensal: '4.91% a.m.',
    c3CapitalInicial: 'R$ 630.000',
    c3ValorFinal: 'R$ 1.100.000',
    c3GanhoLiquido: 'R$ 470.000'
  };

  const fakeEvent = { postData: { contents: JSON.stringify(fakePayload) } };
  const result = doPost(fakeEvent);
  console.log('Resultado:', result.getContent());
}
