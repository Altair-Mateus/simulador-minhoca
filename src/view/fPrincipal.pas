unit fPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.NumberBox,
  uServiceMinhoca;

type
  TfrmPricipal = class(TForm)
    pnlPrincipal: TPanel;
    pnlFundoDados: TPanel;
    pnlDados: TPanel;
    lblProfundidade: TLabel;
    lblAvanco: TLabel;
    lblQueda: TLabel;
    edtProfundidade: TNumberBox;
    edtAvanco: TNumberBox;
    edtQueda: TNumberBox;
    btnIniciar: TButton;
    pnlFundoInfoMovimento: TPanel;
    pnlInfoMovimento: TPanel;
    pnlMinhoca: TPanel;
    shpMinhoca: TShape;
    pnlstatus: TPanel;
    lblPosicao: TLabel;
    lblSubidas: TLabel;
    Shape1: TShape;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
  private

    FTimer: TTimer;
    FServiceMinhoca: TServiceMinhoca;

    procedure CriarObjetos;
    procedure DestruirObjetos;
    procedure InicializaTela;

    procedure ExecutarSimulacao(Sender: TObject);

    procedure PosicaoMinhocaAlterada(
      const pPosicao: Double);

    procedure MinhocaChegouNaMetade;
    procedure MinhocaSaiuDoBuraco;

    procedure PosicionarMinhoca;

    function ConverterPosicaoParaPixel(
      const pPosicao: Double): Integer;

    procedure Iniciar;

  public
    { Public declarations }
  end;

var
  frmPricipal: TfrmPricipal;

implementation

{$R *.dfm}


procedure TfrmPricipal.btnIniciarClick(Sender: TObject);
begin
  Iniciar;
end;

function TfrmPricipal.ConverterPosicaoParaPixel(
  const pPosicao: Double): Integer;
var
  lProfundidade: Double;
  lPercurso: Integer;
begin
  lProfundidade := StrToFloat(edtProfundidade.Text);

  lPercurso := (pnlMinhoca.ClientHeight - shpMinhoca.Height);

  Result := (lPercurso - Round((pPosicao / lProfundidade) * lPercurso));
end;

procedure TfrmPricipal.CriarObjetos;
begin
  FTimer := TTimer.Create(Self);
  FTimer.Interval := 50;
  FTimer.OnTimer := ExecutarSimulacao;
  FTimer.Enabled := False;

  FServiceMinhoca := nil;
end;

procedure TfrmPricipal.DestruirObjetos;
begin
  FTimer.Enabled := False;
  FTimer.Free;
  FServiceMinhoca.Free;
end;

procedure TfrmPricipal.ExecutarSimulacao(Sender: TObject);
begin
  if Assigned(FServiceMinhoca) then
    FServiceMinhoca.Executar;
end;

procedure TfrmPricipal.FormCreate(Sender: TObject);
begin
  CriarObjetos;
end;

procedure TfrmPricipal.FormDestroy(Sender: TObject);
begin
  DestruirObjetos;
end;

procedure TfrmPricipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmPricipal.FormShow(Sender: TObject);
begin
  InicializaTela;
end;

procedure TfrmPricipal.InicializaTela;
begin
  edtProfundidade.Text := '20';
  edtAvanco.Text := '5';
  edtQueda.Text := '3';

  FTimer.Enabled := False;

  lblPosicao.Caption := 'Posição: 0 cm';
  lblSubidas.Caption := 'Subidas: 0';

  pnlstatus.Color := clWhite;
  pnlstatus.Caption := 'Aguardando início...';

  PosicionarMinhoca;
end;

procedure TfrmPricipal.Iniciar;
var
  lProfundidade: Double;
  lAvanco: Double;
  lQueda: Double;
begin
  if not TryStrToFloat(edtProfundidade.Text, lProfundidade) then
  begin
    Application.MessageBox(
      'Informe uma profundidade válida.',
      'Validação',
      MB_OK or MB_ICONWARNING
      );

    edtProfundidade.SetFocus;
    Exit;
  end;

  if not TryStrToFloat(edtAvanco.Text, lAvanco) then
  begin
    Application.MessageBox(
      'Informe um avanço válido.',
      'Validação',
      MB_OK or MB_ICONWARNING
      );

    edtAvanco.SetFocus;
    Exit;
  end;

  if not TryStrToFloat(edtQueda.Text, lQueda) then
  begin
    Application.MessageBox(
      'Informe uma queda válida.',
      'Validação',
      MB_OK or MB_ICONWARNING
      );

    edtQueda.SetFocus;
    Exit;
  end;

  if (lProfundidade <= 0) or (lAvanco <= 0) or (lQueda <= 0) then
  begin
    Application.MessageBox(
      'Os valores devem ser maiores que zero.',
      'Validação',
      MB_OK or MB_ICONWARNING
      );

    Exit;
  end;

  if (lQueda >= lAvanco) then
  begin
    Application.MessageBox(
      'A quantidade de queda deve ser menor que a quantidade de avanço.',
      'Validação',
      MB_OK or MB_ICONWARNING
      );

    edtQueda.SetFocus;
    Exit;
  end;

  FTimer.Enabled := False;

  FreeAndNil(FServiceMinhoca);

  FServiceMinhoca := TServiceMinhoca.Create(
    lProfundidade,
    lAvanco,
    lQueda,
    PosicaoMinhocaAlterada,
    MinhocaChegouNaMetade,
    MinhocaSaiuDoBuraco
    );

  PosicionarMinhoca;

  pnlstatus.Color := clWhite;
  pnlstatus.Caption := 'A minhoca está em movimento...';

  lblPosicao.Caption := 'Posição: 0 cm';
  lblSubidas.Caption := 'Subidas: 0';

  FTimer.Enabled := True;
end;

procedure TfrmPricipal.MinhocaChegouNaMetade;
begin
  pnlstatus.Color := clYellow;
  pnlstatus.Caption :=
    'A minhoca chegou à metade e continua...';
end;

procedure TfrmPricipal.MinhocaSaiuDoBuraco;
begin
  pnlstatus.Color := clGreen;
  pnlstatus.Caption := 'A minhoca saiu do buraco!';

  FTimer.Enabled := False;
end;

procedure TfrmPricipal.PosicaoMinhocaAlterada(const pPosicao: Double);
begin
  shpMinhoca.Top :=
    ConverterPosicaoParaPixel(pPosicao);

  lblPosicao.Caption :=
    Format(
    'Posição: %.1f cm',
    [pPosicao]
    );

  lblSubidas.Caption :=
    Format(
    'Subidas: %d',
    [FServiceMinhoca.QtdSubida]
    );

  if pPosicao < (StrToFloat(edtProfundidade.Text) / 2) then
  begin
    pnlstatus.Color := clWhite;
    pnlstatus.Caption := 'A minhoca está em movimento...';
  end;
end;

procedure TfrmPricipal.PosicionarMinhoca;
begin
  shpMinhoca.Left := ((pnlMinhoca.ClientWidth - shpMinhoca.Width) div 2);

  shpMinhoca.Top := (pnlMinhoca.ClientHeight - shpMinhoca.Height);
end;

end.
