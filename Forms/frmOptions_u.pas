unit frmOptions_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TfrmOptions = class(TForm)
    inpQry: TMemo;
    btnRunQry: TButton;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnRunQryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.fmx}

procedure TfrmOptions.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmOptions.btnRunQryClick(Sender: TObject);
begin
  //
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
  inpQry.Lines.Add('select *');
  inpQry.Lines.Add('from Customer;');
{$ENDIF}
end;

end.
