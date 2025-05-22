program Ceeqwal;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmMain_u in 'Forms\frmMain_u.pas' {frmMain},
  frmOptions_u in 'Forms\frmOptions_u.pas' {frmOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
