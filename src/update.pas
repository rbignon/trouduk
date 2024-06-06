unit update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gauges, Psock, NMHttp, ExtCtrls, ShellApi;

type
  Tupgrade = class(TForm)
    NMHTTP1: TNMHTTP;
    Gauge: TGauge;
    etat: TLabel;
    Label1: TLabel;
    filename: TLabel;
    Timer1: TTimer;
    Gauge1: TGauge;
    procedure FormCreate(Sender: TObject);
    procedure NMHTTP1ConnectionFailed(Sender: TObject);
    procedure NMHTTP1Connect(Sender: TObject);
    procedure NMHTTP1Disconnect(Sender: TObject);
    procedure NMHTTP1PacketRecvd(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  upgrade: Tupgrade;
  downloaded: boolean = false;

const
 PATCH_NAME: string = 'trouduk.patch';
 UPDATE_FILE: string = 'update.exe';
 CHANGELOG_FILE: string = 'ChangeLog.txt';
 TODO_FILE: string = 'TODO.txt';
 PARAMS: string = 'launch trouduk.exe trouduk.patch';
 URL: string = 'http://www.kouak.org/~progs/game/download/';

implementation

uses newgame;

{$R *.dfm}

(* ATTENTION: est en réalité OnShow *)
procedure Tupgrade.FormCreate(Sender: TObject);
begin
 Timer1.Enabled := true;
end;

procedure Tupgrade.NMHTTP1ConnectionFailed(Sender: TObject);
begin
  Messagedlg('Impossible de se connecter au serveur', mterror, [mbok], 0);
  close;
end;

procedure Tupgrade.NMHTTP1Connect(Sender: TObject);
begin
  etat.Caption := 'Connecté';
end;

procedure Tupgrade.NMHTTP1Disconnect(Sender: TObject);
begin
 etat.Caption := 'Déconnecté';
 Close;
end;

procedure Tupgrade.NMHTTP1PacketRecvd(Sender: TObject);
begin
  etat.Caption := 'Téléchargement...';
  if(NMHTTP1.BytesTotal > 0) then downloaded := true
  else begin
    Messagedlg('Erreur lors du téléchargement...', mterror, [mbok], 0);
    close;
  end;
  Gauge.MaxValue := NMHTTP1.BytesTotal;
  Gauge.Progress := NMHTTP1.BytesRecvd;
end;

procedure Tupgrade.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  Gauge.Visible := true;
  filename.visible := true;
  Gauge1.visible := true;
  Label1.Visible := true;
  NMHTTP1.Body := DIR + PATCH_NAME;
  filename.Caption := PATCH_NAME;
  etat.Caption := 'Connection...';
  Gauge1.Progress := 1;
  NMHTTP1.Get(URL + PATCH_NAME);
  NMHTTP1.Body := DIR + CHANGELOG_FILE;
  filename.Caption := CHANGELOG_FILE;
  Gauge1.Progress := 2;
  NMHTTP1.Get(URL + CHANGELOG_FILE);
  NMHTTP1.Body := DIR + TODO_FILE;
  filename.Caption := TODO_FILE;
  Gauge1.Progress := 3;
  NMHTTP1.Get(URL + TODO_FILE);
  Gauge1.Progress := 4;
end;

procedure Tupgrade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Gauge1.Visible := false;
Gauge.Visible := false;
filename.Visible := false;
label1.Visible := false;
 if(downloaded) then
 begin
   Messagedlg('Le jeu a bien été mis à jour',
        mtinformation, [mbok], 0);
   ShellExecute(Handle, 'open', pchar(DIR + UPDATE_FILE), pchar(PARAMS), nil, SW_SHOWNORMAL);
//   Winexec(pchar(UPDATE_FILE), 0);
   Connexion.Close;
   halt;
 end
 else
    Messagedlg('Erreur lors du téléchargement de la mise à jour... Vérifiez que le jeu n''est ' +
   'pas lancé et que vous êtes connecté à Internet.', mterror, [mbok], 0);
end;

end.
