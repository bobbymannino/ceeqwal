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
var
  frm: TForm;
begin
  frm := TfrmOptions.Create(nil);
  Application.MainForm := frm;
  close;
  frm.Show;
end;

procedure TfrmMain.btnTestConnectionClick(Sender: TObject);
var
  conn: TFDConnection;
begin
  conn := TFDConnection.Create(nil);
  try
    conn.Params.Clear;
    conn.Params.DriverID := 'MSSQL';
    conn.Params.Values['Server'] := inpServer.Text;
    conn.Params.Values['Database'] := inpDatabase.Text;
    conn.Params.Values['User_Name'] := inpUser.Text;
    conn.Params.Values['Password'] := inpPwd.Text;

    try
      conn.Connected := True;
      ShowMessage('1'); // Success
    except
      on E: Exception do
      begin
        ShowMessage(E.Message); // Failure
      end;
    end;
  finally
    conn.Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
  inpServer.Text := 'DESKTOP-5EFKG00\SQLEXPRESS';
{$ENDIF}
end;

end.
