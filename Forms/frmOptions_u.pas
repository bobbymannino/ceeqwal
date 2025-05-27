unit frmOptions_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  dmDb_u, FMX.Grid.Style, FMX.Grid;

type
  TfrmOptions = class(TForm)
    inpQry: TMemo;
    btnRunQry: TButton;
    btnClose: TButton;
    BindingsList1: TBindingsList;
    LinkControlToPropertySQLText: TLinkControlToProperty;
    grd: TGrid;
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
var
  col: TStringColumn;
begin
  with dmDb do
  begin
    qry.SQL.Text := inpQry.Lines.Text;

    try
      qry.Open;

      grd.ClearColumns;

      for var i := 0 to qry.FieldCount - 1 do
      begin
        col := TStringColumn.Create(grd);
        col.Header := qry.Fields[i].FieldName;
        col.Width := Length(qry.Fields[i].FieldName) + 16;
        grd.AddObject(col);
      end;
    finally
      qry.Close;
    end;
  end;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
  inpQry.Lines.Add('select *');
  inpQry.Lines.Add('from Customer;');
{$ENDIF}
end;

end.
