program prjTaif;

uses
  Vcl.Forms,
  FrmPrincipal in 'FrmPrincipal.pas' {FrmPrincipalTaif},
  uCliente in 'uCliente.pas',
  uCarro in 'uCarro.pas',
  uVenda in 'uVenda.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipalTaif, FrmPrincipalTaif);
  Application.Run;
end.
