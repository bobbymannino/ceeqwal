unit frmMain_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit,
  FireDAC.Phys.MSSQL, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  frmOptions_u;

type
  TfrmMain = class(TForm)
    inpServer: TEdit;
    btnTestConnection: TButton;
    btnConnect: TButton;
    btnClose: TButton;
    inpUser: TEdit;
    inpPwd: TEdit;
    lblServer: TLabel;
    lblUser: TLabel;
    lblPwd: TLabel;
    inpDatabase: TEdit;
    lblDatabase: TLabel;
    procedure btnTestConnectionClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function CheckConnection: boolean;
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
var
  frm: TForm;
begin
  if not CheckConnection then
  begin
    ShowMessage('Failed to connect');

    Exit;
  end;

  frm := TfrmOptions.Create(nil);
  Application.MainForm := frm;
  close;
  frm.Show;
end;

procedure TfrmMain.btnTestConnectionClick(Sender: TObject);
var
  conn: TFDConnection;
begin
  if CheckConnection then
    ShowMessage('Succeeded')
  else
    ShowMessage('Failed to connect');
end;

function TfrmMain.CheckConnection: boolean;
var
  conn: TFDConnection;
begin
  Result := False;

  conn := TFDConnection.Create(nil);
  try
    conn.Params.Clear;
    conn.Params.DriverID := 'MSSQL';
    conn.Params.Values['Server'] := inpServer.Text;
    conn.Params.Values['Database'] := inpDatabase.Text;
    conn.Params.Values['User_Name'] := inpUser.Text;
    conn.Params.Values['Password'] := inpPwd.Text;

{$IFDEF DEBUG}
    conn.Params.Values['OSAuthent'] := 'Yes';
{$ENDIF}
    conn.Connected := True;

  finally
    conn.Free;

    Result := True;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
  inpServer.Text := 'DESKTOP-5EFKG00\SQLEXPRESS';
{$ENDIF}
end;

end.
