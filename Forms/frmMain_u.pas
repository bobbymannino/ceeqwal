unit frmMain_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.RegularExpressions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit,
  FireDAC.Phys.MSSQL, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  frmOptions_u,
  dmDb_u;

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
    btnUpload: TButton;
    fileInpCredentials: TOpenDialog;
    chkboxOsAuth: TCheckBox;
    inpPort: TEdit;
    lblPort: TLabel;
    procedure btnTestConnectionClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function CheckConnection: boolean;
    function ParseCredentials(const aField, aTxt: string): string;
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

procedure TfrmMain.btnUploadClick(Sender: TObject);
var
  fileContent: TStringList;
  val: string;
begin
  fileInpCredentials.InitialDir := GetCurrentDir;

  if not fileInpCredentials.Execute then
    Exit;

  fileContent := TStringList.Create;
  try
    try
      fileContent.LoadFromFile(fileInpCredentials.FileName);

      val := ParseCredentials('Server', fileContent.Text);
      if val <> EmptyStr then
        inpServer.Text := val;

      val := ParseCredentials('Database', fileContent.Text);
      if val <> EmptyStr then
        inpDatabase.Text := val;

      val := ParseCredentials('User', fileContent.Text);
      if val <> EmptyStr then
        inpUser.Text := val;

      val := ParseCredentials('Password', fileContent.Text);
      if val <> EmptyStr then
        inpPwd.Text := val;

      val := ParseCredentials('Port', fileContent.Text);
      if val <> EmptyStr then
        inpPort.Text := val;

    except
      on e: Exception do
      begin
        ShowMessage('Failed');
      end;
    end;
  finally
    fileContent.Free;
  end;
end;

function TfrmMain.CheckConnection: boolean;
begin
  Result := False;

  with dmDb do
  begin
    try
      conn.Connected := False;
      conn.Params.Clear;
      conn.Params.DriverID := 'MSSQL';
      conn.Params.Values['Server'] := inpServer.Text;
      conn.Params.Values['Database'] := inpDatabase.Text;
      conn.Params.Values['User_Name'] := inpUser.Text;
      conn.Params.Values['Password'] := inpPwd.Text;
      conn.Params.Values['Port'] := inpPort.Text;
      if chkboxOsAuth.IsChecked then
        conn.Params.Values['OSAuthent'] := 'Yes';
      conn.Connected := True;

      if conn.Connected then
        Result := True
      else
        raise Exception.Create('Error Message');
    except
      on e : Exception do
      begin
        conn.Connected := False;
      end;
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
     inpServer.Text := GetEnvironmentVariable('DB_HOST');
     inpUser.Text := GetEnvironmentVariable('DB_USER');
     inpPwd.Text := GetEnvironmentVariable('DB_PWD');
     inpDatabase.Text := GetEnvironmentVariable('DB_DB');
     inpPort.Text := GetEnvironmentVariable('DB_PORT');
{$ENDIF}
end;

function TfrmMain.ParseCredentials(const aField, aTxt: string): string;
var
  ptn: string;
  mtch: TMatch;
begin
  Result := '';

  ptn := Format('^%s=(\w+)\r?\n?$', [aField]);

  mtch := TRegEx.Match(aTxt, ptn, [TRegExOption.roMultiLine]);

  if mtch.Success then
    Result := mtch.Groups[1].Value;
end;

end.
