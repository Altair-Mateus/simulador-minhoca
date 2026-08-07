unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.NumberBox;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPricipal: TfrmPricipal;

implementation

{$R *.dfm}

end.
