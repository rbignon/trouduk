unit infoserver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tserverinfo = class(TForm)
    GroupBox1: TGroupBox;
    version: TLabel;
    CONact: TLabel;
    CONtotal: TLabel;
    Label3: TLabel;
    uptime: TLabel;
    Button1: TButton;
    wait: TImage;
    GAMEtotal: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetInfos(buf: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  serverinfo: Tserverinfo;

implementation

uses
  newgame;

{$R *.dfm}

procedure Tserverinfo.GetInfos(buf: string);
var
  act, total, upt, nbgame: string;
  iact, itotal, igame: integer;
begin
  act := strchr(buf, ' ');
  iact := StrToInt(act);
  total := strchr(buf, ' ');
  itotal := StrToInt(total);
  nbgame := strchr(buf, ' ');
  igame := StrToInt(nbgame);
  strchr(buf, ':');
  upt := buf;
  Version.Caption := 'Version : ' + server_version;
  if(iact > 1) then
    CONact.Caption := 'Il y a actuellement ' + act + ' joueurs'
  else
    CONact.Caption := 'Il y a un actuellement un seul joueur';
  if(itotal > 1) then
    CONtotal.Caption := total + ' personnes se sont connectés à ce serveur'
  else
    CONtotal.Caption := 'Un abruti seulement s''est connecté à ce serveur';
  if(igame > 1) then
    GAMEtotal.Caption := 'Il y a eu ' + nbgame + ' parties jouées'
  else if (igame = 1) then
    GAMEtotal.Caption := 'Il y a eu qu''une seule partie jouée'
  else
    GAMEtotal.caption := 'Sacreubleu ! Aucune partie n''a été jouée !!';
  Label3.Visible := true;
  uptime.Caption := upt;
  wait.Visible := false;
end;

procedure Tserverinfo.Button1Click(Sender: TObject);
begin
Close;
end;

procedure Tserverinfo.FormShow(Sender: TObject);
begin
 wait.Visible := true;
 Label3.Visible := false;
 GroupBox1.Caption := 'Informations serveur ' + server_name;
end;

procedure Tserverinfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CONact.Caption := '';
CONtotal.Caption := '';
uptime.Caption := '';
Version.Caption := '';
gametotal.Caption := '';
end;

end.
