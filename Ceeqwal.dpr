program Ceeqwal;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmMain_u in 'Forms\frmMain_u.pas' {frmMain},
  frmOptions_u in 'Forms\frmOptions_u.pas' {frmOptions},
  dmDb_u in 'DataModules\dmDb_u.pas' {dmDb: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.CreateForm(TdmDb, dmDb);
  Application.Run;
end.
