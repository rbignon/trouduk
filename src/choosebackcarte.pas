unit choosebackcarte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ExtDlgs;

type
  Ttakebackcarte = class(TForm)
    back0: TImage;
    back1: TImage;
    Bevel1: TBevel;
    Backm1: TImage;
    Button1: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure back0Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  takebackcarte: Ttakebackcarte;

implementation

uses
  main, config;

{$R *.dfm}

procedure Ttakebackcarte.back0Click(Sender: TObject);
begin
  conf.backcarte := TImage(Sender).Tag;
  if(conf.backcarte = -1) then
    conf.backcartefile := Edit1.text;
  Close;
end;

procedure Ttakebackcarte.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Edit1.Text := OpenPictureDialog1.FileName;
    Backm1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    backm1.Visible := true;
  end;
end;

procedure Ttakebackcarte.FormShow(Sender: TObject);
begin
  if(conf.backcartefile <> '') and (conf.backcarte = -1) then
  begin
    Backm1.picture.LoadFromFile(conf.backcartefile);
    Edit1.text := conf.backcartefile;
    Backm1.Visible := true;
  end;
end;

procedure Ttakebackcarte.FormCreate(Sender: TObject);
begin
  Back0.Picture := GetCarte('X0').img.Picture;
  Back1.Picture := GetCarte('X1').img.picture;
end;

end.
