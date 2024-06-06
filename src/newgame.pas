unit newgame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Gauges, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, ExtCtrls, ShellApi, Sockets;

type
  TConnexion = class(TForm)
    ServerList: TComboBox;
    Gauge1: TGauge;
    ToConnect: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    login: TEdit;
    CheckBox1: TCheckBox;
    IdTCPClient1: TIdTCPClient;
    Bevel1: TBevel;
    Label2: TLabel;
    Timer1: TTimer;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure loginChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ToConnectClick(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerListChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Connexion: TConnexion;
  connecting: boolean = false;
  connected: boolean = false;
  SoyAdmin: boolean = false;
  AutoLogin: boolean = false;
  server_name, nickname, server_version: string;
  DIR: string;

procedure SendToServer(chaine: string);
function strchr(var chaine: string; chr: string) : string;
procedure logerrors(chaine: string);
procedure Error(genre: integer; chaine: string);
procedure AddInMemo(i: integer; s: string);
function DelDir(Dir: String): Boolean;

const
  {define test_version}
  ERROR_FILE: string = 'errors.log'; // FICHIER DE LOG D'ERREURS
  PROG_VERSION: string = 'TROUDUK v0.4-noel' // VERSION DU PROG
  {$ifdef test_version} + '-testing' {$endif} ;
  PROTO_VERSION = 7{$ifdef test_version} + 1{$endif}; // VERSION ENVOYEE AU SERVEUR
  WEBSITE: string = 'http://www.inter-system.net/game'; // site
  WEBMAIL: string = 'mailto:Progs@Inter-System.Net'; // mail de Progsounette
  ERROR_SITE: string = 'http://www.inter-system.net/game/?p=bugs'; // site des erreurs
  DEFAULT_SERVER: string =
  {$ifdef test_version}'game.inter-system.net:5321';{$else}'game.inter-system.net:5123';{$endif}

  PATCH_LEVEL: array[1..(PROTO_VERSION + 1)] of string = (
    '', '', '0.2', '0.2p1', '0.2p2', '0.3', '0.4', '' {$ifdef test_version}, ''{$endif}
  );

  PATCH_CHANGES: array[1..(PROTO_VERSION + 1)] of string = (
  { 1 } '',
  { 2 } '',
  { 3 } '',
  { 4 } '- Statistiques en fin de parties' + sLineBreak +
        '- L''owner est le joueur humain le mieu gradé: il a une étoile devant' +
        ' son pseudo et c''est à lui de distribuer. Il peut également éjecter des' +
        ' joueurs humains du jeu' + sLineBreak +
        '- Les IA ont des noms de vrai présidents (icone montrant que ce sont des IA)' + sLineBreak +
        '- Amélioration de l''IA' + sLineBreak +
        '- Le bouton "Je ne peux pas" est inactif lorsque le bouton "Ok" est actif.' +
        ' Ca evitera de se tromper de bouton et de ne pas jouer alors qu''on pouvait' + sLineBreak +
        '- Possibilité de configurer la couleur d''arrière plan et des polices' + sLineBreak +
        '- Sauvegarde la configuration (couleurs + pseudo + serveur)',
  { 5 } '- Les cartes sont intégrées à l''executable: dossier "cartes" obsolète' + sLineBreak +
        '- Amélioration du system de mise à jour' + sLineBreak +
        '- Correction de plusieurs bugs, dont à propos de l''owner' + sLineBreak +
        '- Affichage des cartes jouées en cours de parties, et des cartes reçues lors' +
        ' d''échanges en début de parties, dans le volet gauche en bas',
  { 6 } '- Possibilité de régler la vitesse du jeu' + sLineBreak +
        '- Lorsqu''il n''est pas du tout possibler de jouer (sur un as par exemple), laisser' +
        ' afficher la carte pendant un petit laps de temps avant de passer au joueur suivant' +
        ' (configurable)' + sLineBreak +
        '- Correction bug qui activait le bouton "Donner" dans certains cas (échanges de cartes)' +
        ' alors qu''aucune carte n''était sélectionnée' + sLineBreak +
    (*    '- Amélioration qui va surement faire plaisir à BugMaster, historique des messages envoyés' +
        ' (accessibles par la fleche du haut)' + sLineBreak + *)
        '- Correction de bugs divers et variés, dont celui qui permettait de cliquer sur une carte' +
        ' jouée (au milieu) et qui fesait lever une carte de son jeu (bug non dangereux mais drôle)' + sLineBreak +
        '- Affichage d''un message du jour' + sLineBreak +
        '- Affichage des joueurs en liste d''attente qui joignent, et anonce à ces joueurs de quand' +
        ' un joueur gagne' + sLineBreak +
        '- Changement du system de configuration des couleurs: choix plus large' + sLineBreak +
        '- Enregistrement de vos statistiques et scores au cours du temps, affichés en fin de parties',
  { 7 } '- Possibilité d''enregistrement d''un username sur le serveur' + sLineBreak +
        '- MAJEUR: Possibilité de créer une partie avec un jeu de 52 cartes !!' + sLineBreak +
        '- Couleurs des grades configurable' + sLineBreak +
        '- Images plus belles en jeu, première étape vers une interface plus agréable' + sLineBreak +
        '- Statistiques sauvegardées sur le serveur, visualisables et réinitialisables' + sLineBreak +
        '- Classement des cinq meilleurs joueurs' + sLineBreak +
        '- Possibilité d''utilisation du clavier pour jouer' + sLineBreak +
        '- Une fonction permet à l''owner de mettre le jeu en pause' + sLineBreak +
        '- Amélioration du système de sélection des serveurs, bien qu''actuellement ça n''a pas grande' +
        ' utilité du fait qu''il n''y a qu''un seul serveur, les sources n''étant pas [encore] libres' + sLineBreak +
        '- Il est maintenant possible de choisir le dos des cartes' + sLineBreak +
        '- Utilisation de TAB pour compléter les pseudos et affichage en rouge d''un message qui nous appelle' + sLineBreak +
        '- L''Intelligence Artificielle peut parler (activation de l''option dans la création d''une partie)' + sLineBreak +
        '- L''Intelligence Artificielle réagit plus intelligement, notament lorsqu''il ne reste que deux' +
        ' joueurs en jeu et que l''adversaire a deux cartes au maximum',
  { 8 } ''
  {$ifdef test_version}, ''{$endif} );

  (* types d'erreurs *)
  ERR_SERVER: integer = 1;
  ERR_PROTO: integer = 2;
  ERR_CLIENT: integer = 3;
  ERR_NO: integer = 0;

  (* types de message à envoyer au serveur *)
  MSG_NICK: string = 'NICK '; // + PROTO_VERSION + ' :' + login
  MSG_LIST: string = 'LIST';
  MSG_CREATE: string = 'CREATE '; // + jeu + reflexion [+ pass]
  MSG_JOIN: string = 'JOIN '; // + jeu [ + pass]
  MSG_MSG: string = 'MSG :'; // + :message
  MSG_DISTRIBUE: string = 'DISTRIBUE';
  MSG_QUIT: string = 'QUIT';
  MSG_PART: string = 'PART';

implementation

uses
  IdSocketHandle, main, choosegame, wait, passdlg, anerror, config, infoserver, update,
  changelog, regnick, listusers, apropos, statsshow;

{$R *.dfm}

function DelDir(Dir: String): Boolean;
var fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do begin
    wFunc := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom := PChar(Dir + #0);
  end;
  Result := (0=ShFileOperation(fos));
end;

procedure logerrors(chaine: string);
var
  f: TextFile;
begin
    if not FileExists(ERROR_FILE) then
      FileCreate(ERROR_FILE);
    AssignFile(f, ERROR_FILE);
    Append(f);
    Writeln(f, DateToStr(Date) + ' ' + TimeToStr(Time) + ' - ERREUR: ' + chaine);
    Flush(f);
    CloseFile(f);
end;

procedure Error(genre :integer; chaine: string);
begin
  if(genre = ERR_SERVER) then
    Erreur.msg.Lines.Add('Erreur venant du serveur:')
  else if(genre = ERR_PROTO) then
    Erreur.msg.Lines.Add('Erreur de protocole:')
  else if(genre = ERR_CLIENT) then
    Erreur.msg.Lines.Add('Erreur venant du client:');
  Erreur.msg.Lines.Add(chaine);
  Erreur.ShowModal;
  logerrors(chaine);
end;

procedure AddInMemo(i: integer; s: string);
begin
      Form1.Memo.SelAttributes.Color := i;
      Form1.Memo.Lines.Add(s);
      Form1.Memo.SelAttributes.Color := conf.fontcolor;
  //    SendMessage(Form1.Memo.Handle, EM_SETSEL, Length(Form1.Memo.Lines.Text)-2, Length(Form1.Memo.Lines.Text)-2);
      SendMessage(Form1.Memo.Handle, EM_SCROLLCARET, 0, 0);
end;

function strchr(var chaine: string; chr: string) : string;
begin
  if(Pos(chr, chaine) = 0) then
  begin
    Result := Trim(chaine);
    chaine := '';
  end
  else begin
    Result := Trim(Copy(chaine, 0, Pos(chr, chaine) - 1));
    chaine := Trim(Copy(chaine, Pos(chr, chaine) + 1, Length(chaine)));
  end;
end;

procedure SendToServer(chaine: string);
begin
  if (Connexion.IdTCPClient1.Connected = true) then
    Connexion.IdTCPClient1.writeln(chaine);
end;

procedure TConnexion.FormCreate(Sender: TObject);
begin
dir := extractfilepath(Application.ExeName);
chdir(dir);
if(FileExists(UPDATE_FILE) = false) then
begin
  MessageDlg('Impossible de trouver update.exe... Veuillez retélécharger le jeu.', mterror, [mbok], 0);
  halt;
end;
if(DirectoryExists('cartes') = true) then
begin
  if(DelDir('cartes')) then
    MessageDlg('Le répertoire "cartes" a été supprimé car il n''a plus d''utilité', mtinformation,
  [mbok], 0)
  else
    messagedlg('Le répertoire "cartes" n''a plus d''utilité mais n''a pas pu être supprimé', mterror,
  [mbok], 0);
end;
Height := 150;
{$ifdef test_version}
Checkbox1.Caption := 'Serveur de test';
Caption := 'Connexion - VERSION DE TEST';
{$endif}
load_config();

Timer1.Interval := conf.animation;
login.Text := conf.nick;

end;

procedure TConnexion.loginChange(Sender: TObject);
begin
if (login.Text = '') or (serverlist.Text = '') then ToConnect.Enabled := false
else ToConnect.Enabled := true;
conf.nick := login.text;
end;

procedure TConnexion.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure TConnexion.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    ServerList.Enabled := false;
    ServerList.ItemIndex := 0;
  end
  else
  begin
    ServerList.Enabled := true;
  end;
end;

procedure TConnexion.ToConnectClick(Sender: TObject);
var
  s: string;
begin
  if(connecting = false) and (connected = false) then
  begin
    Label2.Caption := '1. Connexion en cours...';
    Height := 220;
    Gauge1.Progress := 1;
    Label1.Enabled := false;
    Checkbox1.Enabled := false;
    serverlist.Enabled := false;
    ToConnect.Caption := 'Deconnecter';
    connecting := true;
    if CheckBox1.Checked then
      s := DEFAULT_SERVER
    else
      s := ServerList.text;
    IdTCPClient1.Host := strchr(s, ':');
    if(s = '') or (StrToInt(s) < 1) then
      IdTCPClient1.Port := 5123
    else
      IdTCPClient1.Port := StrToInt(s);
    IdTCPClient1.Connect;
    Timer1.Enabled := true;
  end
  else
  begin
    IdTCPClient1Disconnected(Sender);
  end;
end;

procedure TConnexion.IdTCPClient1Connected(Sender: TObject);
begin
  Label2.Caption := '2. Connecté';
  Gauge1.Progress := 2;
  Form1.Administration1.Visible := false;
  Form1.itemregister.Enabled := true;
  Form1.Stats1.enabled := false;
  Form1.bestscores.Enabled := false;
  nickname := login.Text;
  //if(Pos(' ', login.text) <> 0) then login.text := Copy(login.text, 0, Pos(' ', login.text) - 1);
end;

procedure TConnexion.IdTCPClient1Disconnected(Sender: TObject);
begin
    Form1.clear_window();
    Form1.MOTD.Visible := false;
    IsInClose := true;
    Form1.Close;
    gamelist.Close;
    userlist.Close;
    waitgame.Close;
    serverinfo.Close;
    register.Close;
    passworddlg.Close;
    about.close;
    cfg.Close;
    Show;
    Label1.Enabled := true;
    IdTCPClient1.Disconnect;
    Label2.Caption := 'Déconnecté';
    Height := 150;
    Gauge1.Progress := 0;
    login.Enabled := true;
    checkbox1.Enabled := true;
    if(Checkbox1.Checked) then
      serverlist.Enabled := false
    else
      serverlist.Enabled := true;
    connecting := false;
    connected := false;
    ToConnect.Caption := 'Connecter';
    Timer1.Enabled := false;
end;

procedure TConnexion.Timer1Timer(Sender: TObject);
var
  Buf, Prefix, Com, msg: string;
  tmp1: string;
  i, j: integer;
  b: boolean;
  MS: TMemoryStatus;
begin
  if ((connecting = false) and (connected = false)) or (IdTCPClient1.Connected = false) then exit;

  GlobalMemoryStatus(MS);
  Form1.StatusBar.Panels.Items[2].text := Format('Res: %d %%', [MS.dwMemoryLoad]);

  try
    buf := IdTCPClient1.ReadLn('', 5);
  except
    IdTCPClient1.Disconnect;
  end;
  if buf <> '' then
  begin
    if (buf[1] = ':') then
    begin
      Prefix := Trim(Copy(buf, Pos(':', buf) + 1, Pos(' ', buf) - 1));
      buf := Trim(Copy(buf, Pos(' ', buf) + 1, Length(buf)));
      Com := strchr(buf, ' ');
    end
    else if(Pos(' ', buf) > 0) then
      Com := UpperCase(strchr(buf, ' '))
    else Com := buf;
    msg := Trim(Copy(buf, Pos(':', buf) + 1, Length(buf)));

    if(Com = 'SERVER') and (connected = false) then
    begin
      sendtoserver(MSG_NICK + IntToStr(PROTO_VERSION) + ' :' + login.text);
      server_name := strchr(buf, ' ');
      server_version := msg;
      Gauge1.Progress := 4;
      Label2.Caption := '3. Identification en cours...';
    end
    else if(Com = 'CONNECTED') and (connected = false) then
    begin
      connected := true;
      connecting := false;
      Gauge1.Progress := 5;
      Label2.Caption := '4. Identifié !';
      nickname := msg;
      Form1.Caption := 'Trou du cul - Serveur ' + Server_name + ' - ' + nickname;
      Form1.Show;
      Hide;
    end
    else if(Com = 'PING') then
      sendtoserver('PONG')
    else if(Com = 'USERLIST') then
    begin
      tmp1 := strchr(buf, ' ');
      i := StrToInt(strchr(buf, ' '));
      j := StrToInt(strchr(buf, ' '));
      AddUserList(tmp1, i, j, buf);
    end
    else if(Com = 'ENDOFUL') then
    begin
      showuserlist := false;
      UserList.ListView1.Enabled := true;
      if waituserlist then
      begin
        waituserlist := false;
        UserList.ListView1.Clear;
      end;
    end
    else if(Com = 'LIST') then
    begin
      tmp1 := strchr(buf, ' ');
      j := StrToInt(strchr(buf, ' '));
      i := StrToInt(strchr(buf, ' '));
      if(strchr(buf, ' ') = '1') then b := true
      else b := false;
      AddGameList(tmp1, msg, i, b, j);
    end
    else if(Com = 'STATS') then
    begin
      tmp1 := strchr(buf, ' ');
      if(tmp1 = 'SHOW') then showstats.GetStats(buf)
      else if(tmp1 = 'RESETED') then showstats.StatsReseted
      else if(tmp1 = 'TOP5') then showstats.GetTop5(msg);
    end
    else if(Com = 'SERVERINFO') then
    begin
      serverinfo.GetInfos(buf);
    end
    else if(Com = 'LISTEND') then
    begin
      showgamelist := false;
      GameList.ListView1.Enabled := true;
      if waitgamelist then
      begin
        waitgamelist := false;
        GameList.ListView1.Clear;
      end;
    end
    else if(Com = 'STOP') then
    begin
      if(buf = '1') then
      begin
        Form1.Timer1.Enabled := false;
        Form1.Donner.Enabled := false;
        Form1.BitBtn1.Enabled := false;
        Form1.Timer2.Enabled := false;
        Form1.SpeedButton3.Down := true;
        Form1.Gauge1.ForeColor := clRed;
        with Form1.Player.no[myident[0]] do
        begin
          for i := 1 to 15 do
          begin
            if(ImgCartes[i] = nil) then continue;
            ImgCartes[i].Top := norcarte;
            ImgCartes[i].Cursor := crDefault;
          end;
        end;
        IsStop := true;
        if(game = 3) then
          waitgame.Memo1.Lines.Add('*** Partie en pause...');
        AddInMemo(conf.fontcolor, '*** Partie en pause...');
      end
      else begin
        Form1.Timer1.Enabled := true;
        Form1.BitBtn1.Enabled := true;
        Form1.SpeedButton3.Down := false;
        Form1.Gauge1.ForeColor := clBlack;
        if IsToMe then with Form1.Player.no[myident[0]] do
        begin
          for i := 1 to 15 do
          begin
            if(ImgCartes[i] = nil) then continue;
            ImgCartes[i].Cursor := crHandPoint;
          end;
        end;
        IsStop := false;
        if(game = 3) then
          waitgame.Memo1.Lines.Add('*** Reprise de la partie');
        AddInMemo(conf.fontcolor, '*** Reprise de la partie');
      end;
    end
    else if(Com = 'MSG') then
    begin
      if(game = 3) then
        waitgame.Memo1.Lines.Add('<' + Prefix + '> ' + msg);
        if (Pos(upperCase(' ' + nickname + ' '), UpperCase(' ' + msg + ' ')) > 0) or
           (Pos(upperCase(' ' + nickname + ': '), UpperCase(' ' + msg + ' ')) > 0) then
        begin
          j := clRed;
          Beep;
        end
        else
          j := conf.fontcolor;
      AddInMemo(j, '<' + Prefix + '> ' + msg);
    end
    else if(Com = 'ERREUR') then
    begin
      Error(ERR_SERVER, buf);
      if(creating = true) then creating := false;
    end
    else if(Com = 'LOGIN') then
    begin
      if IsLoginPass or AutoLogin then
      begin
        AutoLogin := false;
        WantPass := false;
        if IsLoginPass then passworddlg.Close;
        IsLoginPass := false;
        Form1.Label1.Visible := true;
        if(buf = '1') then
        begin
          Form1.Label1.caption := 'Vous êtes bien logué sur le pseudo ' + nickname + sLineBreak + ' en temps qu''administrateur !';
          Form1.Administration1.Visible := true;
          SoyAdmin := true;
        end
        else begin
          Form1.Label1.caption := 'Vous êtes bien logué sur le pseudo ' + nickname;
        end;
      end else if IsRegPass then
      begin
        IsRegPass := false;
        register.Close;
        if(buf = '1') then
        begin
          MessageDlg('Le pseudo ' + nickname + ' a bien été enregistré ! Et en tant que premier utilisateur vous êtes' +
                ' administrateur !', mtinformation, [mbok], 0);
          Form1.Administration1.Visible := true;
          SoyAdmin := true;
        end
        else begin
          MessageDlg('Votre pseudo ' + nickname + ' a bien été enregistré !', mtinformation, [mbok], 0);
        end;
      end;
      Form1.itemregister.enabled := false;
      Form1.Stats1.Enabled := true;
      Form1.bestscores.Enabled := true;
    end
    else if(Com = 'MUSTLOGIN') then
    begin
       if(conf.pass = '') then begin
         WantPass := true;
         IsLoginPass := true;
         Passworddlg.ShowModal;
       end else
       begin
         sendtoserver('AUTH ' + conf.pass);
         AutoLogin := true;
       end;
    end
    else if(Com = 'MOTD') then
    begin
       if IsMOTD then
       begin
         Form1.MOTD.Lines.Clear;
         Form1.MOTD.Visible := false;
         IsMOTD := false;
       end;
       Form1.MOTD.Lines.Add(msg);
    end
    else if(Com = 'ENDOFMOTD') then
    begin
       IsMOTD := true;
       Form1.MOTD.Visible := true;
    end
    else if(Com = 'JOINED') then
    begin
      if(WantPass = true) then
      begin
        WantPass := false;
        IsJoinPass := false;
        PassGame := '';
        passworddlg.Close;
      end;
      if(game = 3) then
      begin
        game := 1;
        waitgame.Close;
      end
      else gamelist.Close;
      Form1.join_game(buf);
    end
    else if(Com = 'WAIT') then
    begin
      if(WantPass = true) then
      begin
        WantPass := false;
        IsJoinPass := false;
        PassGame := '';
        passworddlg.Close;
      end;
      gamelist.Close;
      gamelist.Refresh;
      waitgame.wait_game(buf);
      waitgame.ShowModal;
    end
    else if(Com = 'WALL') then
     MessageDlg('Message global de la part de ' + Prefix + ' :' + sLineBreak + sLineBreak +
                msg, mtinformation, [mbok], 0)
    else if(Com = 'DIE') then
    begin
      IdTcpClient1.OnDisconnected(Sender);
      MessageDlg('Le serveur a été arrêté pour la raison suivante: ' + sLineBreak + sLineBreak +
                  msg, mtinformation, [mbok], 0);
    end
    else if(Com = 'QUIT') then
    begin
      IdTcpClient1.OnDisconnected(Sender);
    end
    else if(Com = 'KILL') then
    begin
      IdTcpClient1.OnDisconnected(Sender);
      MessageDlg('Vous vous êtes fait déconnecté du serveur par ' + prefix + ' pour la raison suivante:' + sLineBreak +
        sLineBreak + msg, mtinformation, [mbok], 0);
    end
    else if(Com = 'WIN') then
    begin
      if(game < 3) then Form1.someone_win(Prefix, buf)
      else begin
        if(buf = '1') then tmp1 := 'président'
        else if(buf = '2') then tmp1 := 'vice président'
        else if(buf = '3') then tmp1 := 'vice trou du cul'
        else tmp1 := 'trou du cul';
        waitgame.Memo1.Lines.Add('*** Un joueur a fini ' + tmp1);
      end;
    end
    else if(Com = 'ENDOFGAME') then
    begin
      tmp1 := strchr(buf, ' ');
      if(game = 2) then Form1.end_of_game(tmp1, msg)
      else begin
        if(tmp1 = GetIdent(myident)) then
        begin
          Form1.Player.no[myident[0]].owner.visible := true;
          Form1.BitBtn2.Visible := true;
        end
        else Form1.Player.no[GetPlace(tmp1)].owner.Visible := true;
      end;
    end
    else if(Com = 'RULES') then
    begin
      show_rules(buf);
    end
    else if(Com = 'JOIN') then
    begin
      if(game < 3) then Form1.player_join_game(prefix, buf);
    end
    else if(Com = 'WAITJOIN') then
    begin
      if(game = 3) then
        waitgame.Memo1.Lines.Add('*** ' + prefix + ' a rejoint le jeu et prendra la place de ' + buf);
      AddInMemo(conf.fontcolor, '*** ' + prefix + ' a rejoint le jeu et prendra la place de ' + buf);
    end
    else if(Com = 'TOYOU') then
    begin
      Form1.to_me();
    end
    else if(Com = 'BEGIN') then
    begin
      Form1.someone_begin(Prefix);
    end
    else if(Com = 'PLAY') then
    begin
      Form1.someone_play(Prefix, buf);
    end
    else if(Com = 'PERSONNEPEU') then
    begin
      Form1.personne_peut();
    end
    else if(Com = 'CANT') then
    begin
      Form1.someone_cant(Prefix);
    end
    else if(Com = 'PART') then
    begin
      if(game = 3) then
      begin
        if(Prefix = nickname) then waitgame.wait_part(buf)
        else waitgame.wait_user_part(Prefix);
      end
      else begin
        Form1.part_game(prefix, buf);
      end;   
    end
    else if(Com = 'KICK') then
    begin
      Form1.kick_user(Prefix, buf);
    end
    else if(Com = 'ADONNER') then
    begin
      Form1.cartes_a_donner(buf);
    end
    else if(Com = 'DONNE') then
    begin
      Form1.recv_cartes(Prefix, buf);
    end
    else if(Com = 'DONE') then
    begin
      Form1.show_cartes(buf);
    end

 { Erreurs }

    else if(Com = '001') then
    begin
      MessageDlg('Le pseudo ' + strchr(buf, ' ') + ' est déjà pris', mterror, [mbok], 0);
      ToConnectClick(Sender);
    end
    else if(Com = '002') then
    begin
      MessageDlg('Un jeu s''intitule déjà ' + strchr(buf, ' ') + '.', mterror, [mbok], 0);
      if(creating = true) then creating := false;
    end
    else if(Com = '003') then
    begin
      MessageDlg('Le jeu ' + strchr(buf, ' ') + ' n''existe pas', mterror, [mbok], 0);
      if(joining = true) then joining := false;
    end
    else if(Com = '004') then
    begin
      MessageDlg('Il n''y a plus de places dans le jeu ' + strchr(buf, ' ') + '.', mterror, [mbok], 0);
      if(joining = true) then joining := false;
    end
    else if(Com = '005') then
    begin
      MessageDlg('Le pseudo ' + strchr(buf, ' ') + ' est invalide. Il ne doit pas contenir de caractères spéciaux', mterror, [mbok], 0);
      ToConnectClick(Sender);
    end
    else if(Com = '006') then
      MessageDlg('Vous n''êtes pas owner, vous ne pouvez donc pas distribuer.', mterror, [mbok], 0)
    else if(Com = '007') then
      MessageDlg('Vous n''êtes pas en train de jouer !', mterror, [mbok], 0)
    else if(Com = '008') then
    begin
      MessageDlg('Vous jouer déjà !', mterror, [mbok], 0);
      if(joining = true) then joining := false;
      if(creating = true) then creating := false;
    end
    else if(Com = '009') then
        MessageDlg('Une partie est déjà en cours', mterror, [mbok], 0)
    else if(Com = '010') then
    begin
      tmp1 := strchr(buf, ' ');
      IdTcpClient1.OnDisconnected(Sender);
      if(tmp1 = '+') then
      begin
        MessageDlg('La version du serveur auquel vous souhaitez vous connecter est trop vieille et' +
                   ' ne supporte pas la version de votre client.', mterror, [mbok], 0);
      end else
      begin
        if(MessageDlg('Une nouvelle version est requise pour vous connecter au serveur.' +
                ' Voulez vous télécharger la mise à jour ?',
                mtconfirmation, [mbyes, mbno], 0) = mryes) then
        begin
           upgrade.ShowModal;
        end
        else
           MessageDlg('Vous ne pourrez plus vous connecter au serveur tant que vous n''aurrez pas ' +
                'mis à jour votre client.', mterror, [mbok], 0);
      end;
    end
    else if(Com = '011') then
    begin
      if AutoLogin then
      begin
         WantPass := true;
         IsLoginPass := true;
         AutoLogin := false;
         Passworddlg.ShowModal;
      end
      else if WantPass then
      begin
         MessageDlg('Mot de passe incorrect', mterror, [mbok], 0);
         Passworddlg.OKBtn.Enabled := true;
      end
      else
      begin
         WantPass := true;
         IsJoinPass := true;
         PassGame := strchr(buf, ' ');
         Passworddlg.ShowModal;
      end;
    end
    else if(Com = '012') then
    begin
      MessageDlg('User introuvable', mterror, [mbok], 0);
    end;
  end;
end;

procedure TConnexion.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 save_config();
end;

procedure TConnexion.ServerListChange(Sender: TObject);
begin
if (login.Text = '') or (serverlist.Text = '') then ToConnect.Enabled := false
else ToConnect.Enabled := true;
conf.lastserver := Serverlist.ItemIndex;
end;

procedure TConnexion.Button2Click(Sender: TObject);
var
 i: integer;
begin
  i := ServerList.ItemIndex;
  if(i = 0) then
    MessageDlg('Vous ne pouvez pas supprimer le serveur Inter System', mterror, [mbok], 0)
  else begin
    ServerList.Items.Delete(i);
    ServerList.ItemIndex := i-1;
  end;
end;

procedure TConnexion.Button1Click(Sender: TObject);
var
  s: string;
begin
  s := InputBox('Nouveau serveur', 'Veuillez entrer le nom du serveur (exemple ' + DEFAULT_SERVER + ')', '');
  if(s <> '') then
  begin
    ServerList.Items.Add(s);
    ServerList.Text := s;
  end;
end;

end.
