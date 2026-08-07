program prjSimuladorMinhoca;

uses
  Vcl.Forms,
  fPrincipal in 'src\view\fPrincipal.pas' {frmPricipal},
  uServiceMinhoca in 'src\services\uServiceMinhoca.pas',
  uMinhoca in 'src\domain\uMinhoca.pas',
  uEnums in 'src\common\types\uEnums.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPricipal, frmPricipal);
  Application.Run;
end.
