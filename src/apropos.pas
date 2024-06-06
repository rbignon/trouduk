unit apropos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi;

type
  Tabout = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    version: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PhysMem: TLabel;
    Label7: TLabel;
    FreeRes: TLabel;
    Bevel2: TBevel;
    Button1: TButton;
    Image2: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Image3: TImage;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Image2DblClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  about: Tabout;

implementation

uses
  newgame, main, config;

{$R *.dfm}

procedure Tabout.FormCreate(Sender: TObject);
var
  MS: TMemoryStatus;
begin
  GlobalMemoryStatus(MS);
  PhysMem.Caption := FormatFloat('#,###" KO"', MS.dwTotalPhys / 1024);
  FreeRes.Caption := Format('%d %%', [MS.dwMemoryLoad]);
  version.caption := PROG_VERSION;
  Label3.Caption := WEBSITE;
  Label9.Caption := server_version;
  Image1.Picture := GetCarte('CP').img.Picture;
  if(conf.backcarte = -1) then
    Image3.Picture := GetCarte('XX').img.Picture
  else
    Image3.Picture := GetCarte('X' + inttostr(conf.backcarte)).img.Picture;
end;

procedure Tabout.Button1Click(Sender: TObject);
begin
Close;
end;

procedure Tabout.Label3Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pchar(WEBSITE), nil, nil, SW_SHOWNORMAL);
end;

procedure Tabout.Image2DblClick(Sender: TObject);
begin
  Messagedlg('Et non ! Cet easter egg n''est plus valable !!', mterror, [mbok], 0);
end;

procedure Tabout.Image3Click(Sender: TObject);
begin
 Image1.Visible := true;
 Image3.Visible := false;
end;

procedure Tabout.Image1Click(Sender: TObject);
begin
  Image3.Visible := true;
  Image1.Visible := false;
end;

procedure Tabout.Label10Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pchar(WEBMAIL), nil, nil, SW_SHOWNORMAL);
end;

end.
