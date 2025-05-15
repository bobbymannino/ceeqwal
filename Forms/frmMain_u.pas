unit frmMain_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TfrmMain = class(TForm)
    inpConnectionString: TEdit;
    btnTestConnection: TButton;
    btnConnect: TButton;
    btnClose: TButton;
    procedure btnTestConnectionClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  //
end;

procedure TfrmMain.btnTestConnectionClick(Sender: TObject);
var
  connStr: string;
  connValid: boolean;
begin
  connStr := inpConnectionString.Text.Trim;

  connValid := connStr <> EmptyStr;
  if not connValid then
  begin
    ShowMessage('Connection string is empty');
    Exit;
  end;

  { TODO : Test string valid via regex first }

  ShowMessage('Connection string valid');
end;

end.
