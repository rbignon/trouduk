unit config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ColorGrd;

type
  TConfig = record
    nick: string;
    maincolor: integer;
    fontcolor: integer;
    progversion: integer;
    animation: integer;
    nowaitcant: boolean;
    lastserver: integer;
    pass: string;
    fontpresident: integer;
    fontvpresident: integer;
    fontvtrouduk: integer;
    fonttrouduk: integer;
    backcarte: integer;
    backcartefile: string;
    def_52C: boolean;
  end;
  Tcfg = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Button1: TButton;
    TabSheet2: TTabSheet;
    RadioGroup1: TRadioGroup;
    alente: TRadioButton;
    anormale: TRadioButton;
    arapide: TRadioButton;
    nowaitcant: TCheckBox;
    ColorDialog1: TColorDialog;
    backcolor: TPanel;
    frontcolor: TLabel;
    Label2: TLabel;
    fontpresident: TLabel;
    fontvpresident: TLabel;
    fontvtrouduk: TLabel;
    fonttrouduk: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    Image23: TImage;
    Image33: TImage;
    Image4: TImage;
    Image5: TImage;
    Image2: TImage;
    Image6: TImage;
    Image3: TImage;
    procedure TabSheet1Show(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure alenteClick(Sender: TObject);
    procedure nowaitcantClick(Sender: TObject);
    procedure backcolorClick(Sender: TObject);
    procedure frontcolorClick(Sender: TObject);
    procedure fontpresidentClick(Sender: TObject);
    procedure fontvpresidentClick(Sender: TObject);
    procedure fontvtroudukClick(Sender: TObject);
    procedure fonttroudukClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  cfg: Tcfg;
  Conf: TConfig;

procedure load_config();
procedure save_config();
procedure create_config();

const
  CONFIG_FILE: string = 'config.dat';
  CONFIG_VERSION: integer = 8; // A incrémenter lors de changements dans la conf
  ANIMATION_LENTE: integer = 300;
  ANIMATION_NORMALE: integer = 100;
  ANIMATION_RAPIDE: integer = 50;

implementation

uses
  newgame, main, choosebackcarte;

{$R *.dfm}

procedure create_config();
begin
  conf.nick := '';
  conf.maincolor := 32768;
  conf.fontcolor := 0;
  conf.lastserver := 0;
  conf.progversion := PROTO_VERSION;
  conf.animation := ANIMATION_NORMALE;
  conf.nowaitcant := true;
  conf.pass := '';
  conf.fontpresident := clAqua;
  conf.fontvpresident := clBlue;
  conf.fontvtrouduk := clRed;
  conf.fonttrouduk := clMaroon;
  conf.backcarte := 0;
  conf.backcartefile := '';
  conf.def_52C := false;
end;

procedure load_config();
var
  F: TextFile;
  s, vname: string;
  version: integer;
begin
  version := 0;
  Connexion.ServerList.Items.Add(DEFAULT_SERVER);
  if(FileExists(DIR + CONFIG_FILE) = false) then
    create_config()
  else
  begin
    AssignFile(F, DIR + CONFIG_FILE);
    Reset(F);
    Readln(f, s);
    while s <> '' do
    begin
      vname := strchr(s, '=');
      if(Pos('#', vname) = 1) then
      begin
        Readln(f, s);
        continue;
      end;
      if(vname = 'VERSION') then version := StrToInt(s)
      else if(vname = 'nick') then conf.nick := s
      else if(vname = 'servername') then
        Connexion.ServerList.Items.Add(s)
      else if(version >= 2) and (vname = 'maincolor') then conf.maincolor := StrToInt(s)
      else if(version >= 2) and (vname = 'fontcolor') then conf.fontcolor := StrToInt(s)
      else if(version >= 2) and (vname = 'progversion') then conf.progversion := StrToInt(s)
      else if(version >= 4) and (vname = 'animation') then conf.animation := strToInt(s)
      else if(version >= 5) and (vname = 'lastserver') then conf.lastserver := strToInt(s)
      else if(version >= 6) and (vname = 'pass') then conf.pass := s
      else if(version >= 7) and (vname = 'fontpresident') then conf.fontpresident := strtoint(s)
      else if(version >= 7) and (vname = 'fontvpresident') then conf.fontvpresident := strtoint(s)
      else if(version >= 7) and (vname = 'fontvtrouduk') then conf.fontvtrouduk := strtoint(s)
      else if(version >= 7) and (vname = 'fonttrouduk') then conf.fonttrouduk := strtoint(s)
      else if(version >= 7) and (vname = 'backcarte') then conf.backcarte := strtoint(s)
      else if(version >= 7) and (vname = 'backcartefile') then conf.backcartefile := s
      else if(version >= 8) and (vname = 'def52c') then
      begin
        if(StrToInt(s) = 0) then conf.def_52C := false
        else conf.def_52C := true;
      end
      else if(version >= 4) and (vname = 'nowaitcant') then
        if(StrToInt(s) = 0) then conf.nowaitcant := false
        else conf.nowaitcant := true;
      if(version < 2) then
      begin
        MessageDlg('Impossible de charger la configuration...', mterror, [mbok], 0);
        create_config();
        break;
      end;
      Readln(f, s);
    end;
    CloseFile(f);
    if (version < 8) then
      conf.def_52C := false;
    if (version < 7) then begin
      conf.fontpresident := clAqua;
      conf.fontvpresident := clBlue;
      conf.fontvtrouduk := clRed;
      conf.fonttrouduk := clMaroon;
      conf.backcarte := 0;
      conf.backcartefile := '';
    end;
    if (version < 6) then
      conf.pass := '';
    if(version < 4) then begin
      conf.animation := ANIMATION_NORMALE;
      conf.nowaitcant := true;
    end;
  end;
  if(conf.lastserver > 0) then
  begin
    Connexion.Checkbox1.checked := false;
    Connexion.ServerList.Enabled := true;
    Connexion.ServerList.ItemIndex := conf.lastserver;
  end
  else begin
    Connexion.checkbox1.checked := true;
    Connexion.ServerList.ItemIndex := 0;
  end;
end;

procedure save_config();
var
  F: TextFile;
  i: integer;
begin
  AssignFile(F, DIR + CONFIG_FILE);
  Rewrite(f);
  Writeln(f, '# Surtout ne pas modifier la configuration !');
  Writeln(f, '# Ne vous plaignez pas de disfonctionnements dans le cas contraire');
  Writeln(f, '# En cas de non fonctionnement du programme après modification, supprimez la configuration');
  Writeln(f, 'VERSION=', IntToStr(CONFIG_VERSION));
  Writeln(f, 'nick=', conf.nick);
  if(Connexion.CheckBox1.Checked) then
    writeln(f, 'lastserver=0')
  else
    writeln(f, 'lastserver=', Connexion.ServerList.ItemIndex);
  for i := 1 to Connexion.ServerList.Items.Count - 1 do
    WriteLn(f, 'servername=', Connexion.ServerList.Items[i]);
  writeln(f, 'maincolor=', IntToStr(conf.maincolor));
  writeln(f, 'fontcolor=', IntToStr(conf.fontcolor));
  writeln(f, 'progversion=', conf.progversion);
  writeln(f, 'animation=', conf.animation);
  writeln(f, 'pass=', conf.pass);
  writeln(f, 'fontpresident=', conf.fontpresident);
  writeln(f, 'fontvpresident=', conf.fontvpresident);
  writeln(f, 'fontvtrouduk=', conf.fontvtrouduk);
  writeln(f, 'fonttrouduk=', conf.fonttrouduk);
  writeln(f, 'backcarte=', conf.backcarte);
  writeln(f, 'backcartefile=', conf.backcartefile);
  if conf.nowaitcant then
    writeln(f, 'nowaitcant=1')
  else
    writeln(f, 'nowaitcant=0');
  if conf.def_52C then
    writeln(f, 'def52c=1')
  else
    writeln(f, 'def52c=0');
  CloseFile(f);
end;

procedure Tcfg.TabSheet1Show(Sender: TObject);
var
  c: TCarte;
begin
  backcolor.Color := conf.maincolor;
  Panel2.Color := conf.maincolor;
  frontcolor.font.Color := conf.fontcolor;
  fontpresident.Font.color := conf.fontpresident;
  fontvpresident.Font.color := conf.fontvpresident;
  fontvtrouduk.Font.color := conf.fontvtrouduk;
  fonttrouduk.Font.color := conf.fonttrouduk;
  if(conf.backcarte = -1) then
    c := GetCarte('XX')
  else
    c := GetCarte('X' + inttostr(conf.backcarte));

  Image1.Picture := c.img.picture;
  Image2.Picture := c.img.picture;
  Image3.Picture := c.img.picture;
  Image4.Picture := c.img.picture;
  Image5.Picture := c.img.picture;
  Image6.Picture := c.img.picture;
  Image23.Picture := GetCarte('4C').img.Picture;
  Image33.Picture := GetCarte('8P').img.Picture;
end;

procedure Tcfg.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure Tcfg.TabSheet2Show(Sender: TObject);
begin
  if(conf.animation = ANIMATION_RAPIDE) then
    arapide.Checked := true
  else if(conf.animation = ANIMATION_LENTE) then
    alente.Checked := true
  else
    anormale.Checked := true;

  if conf.nowaitcant then
    nowaitcant.Checked := true
  else nowaitcant.Checked := false;
end;

procedure Tcfg.alenteClick(Sender: TObject);
begin
  if(alente.Checked) then
    conf.animation := ANIMATION_LENTE
  else if(arapide.Checked) then
    conf.animation := ANIMATION_RAPIDE
  else
    conf.animation := ANIMATION_NORMALE;
  Connexion.Timer1.Interval := conf.animation;
  Form1.Timer2.Interval := conf.animation * 10;
end;

procedure Tcfg.nowaitcantClick(Sender: TObject);
begin
  if(nowaitcant.Checked) then
    conf.nowaitcant := true
  else
    conf.nowaitcant := false;
end;

procedure Tcfg.backcolorClick(Sender: TObject);
begin
  ColorDialog1.Color := conf.maincolor;
  if ColorDialog1.Execute then
  begin
    conf.maincolor := ColorDialog1.color;
    Form1.Color := ColorDialog1.color;
    Form1.Memo.Color := ColorDialog1.color;
    Form1.Msg.Color := ColorDialog1.color;
    Form1.ListStats.Color := ColorDialog1.color;
    Form1.MOTD.Color := ColorDialog1.color;
    backcolor.Color := ColorDialog1.color;
    Panel2.Color := ColorDialog1.Color;
  end;
end;

procedure Tcfg.frontcolorClick(Sender: TObject);
begin
  ColorDialog1.Color := conf.fontcolor;
  if ColorDialog1.Execute then
  begin
    conf.fontcolor := ColorDialog1.color;
    frontcolor.font.Color := ColorDialog1.color;
    Form1.change_fontcolor();
  end;
end;

procedure Tcfg.fontpresidentClick(Sender: TObject);
begin
  ColorDialog1.Color := conf.fontpresident;
  if ColorDialog1.Execute then
  begin
    conf.fontpresident := ColorDialog1.color;
    fontpresident.font.Color := ColorDialog1.color;
  end;
end;

procedure Tcfg.fontvpresidentClick(Sender: TObject);
begin
  ColorDialog1.Color := conf.fontvpresident;
  if ColorDialog1.Execute then
  begin
    conf.fontvpresident := ColorDialog1.color;
    fontvpresident.font.Color := ColorDialog1.color;
  end;
end;

procedure Tcfg.fontvtroudukClick(Sender: TObject);
begin
  ColorDialog1.Color := conf.fontvtrouduk;
  if ColorDialog1.Execute then
  begin
    conf.fontvtrouduk := ColorDialog1.color;
    fontvtrouduk.font.Color := ColorDialog1.color;
  end;
end;

procedure Tcfg.fonttroudukClick(Sender: TObject);
begin
  ColorDialog1.Color := conf.fonttrouduk;
  if ColorDialog1.Execute then
  begin
    conf.fonttrouduk := ColorDialog1.color;
    fonttrouduk.font.Color := ColorDialog1.color;
  end;
end;

procedure Tcfg.Image3Click(Sender: TObject);
var
 c: TCarte;
begin
  takebackcarte.ShowModal;
  if(conf.backcarte = -1) then
  begin
    c := GetCarte('XX');
    c.img.Picture.LoadFromFile(conf.backcartefile);
  end
  else
    c := GetCarte('X' + inttostr(conf.backcarte));

  Image1.Picture := c.img.picture;
  Image2.Picture := c.img.picture;
  Image3.Picture := c.img.picture;
  Image4.Picture := c.img.picture;
  Image5.Picture := c.img.picture;
  Image6.Picture := c.img.picture;
end;

procedure Tcfg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
takebackcarte.Close;
end;

end.
