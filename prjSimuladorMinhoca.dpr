program prjSimuladorMinhoca;

uses
  Vcl.Forms,
  fPrincipal in 'src\view\fPrincipal.pas' {frmPricipal} ,
  uServiceMinhoca in 'src\services\uServiceMinhoca.pas',
  uMinhoca in 'src\domain\uMinhoca.pas',
  uEnums in 'src\common\types\uEnums.pas';

{$R *.res}


begin

  // ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := true;
  Application.CreateForm(TfrmPricipal, frmPricipal);
  Application.Run;

end.
