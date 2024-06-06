unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Menus, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, Gauges, ShellApi, ActnList, StrUtils,
  jpeg;

const
  MAX_CARTES = 55;

type
  TIdCarte = string[2];
  TCarte = record
     img: TImage;
     Id: TIdCarte;
     Nom: string;
  end;
  TCartes = array[1..MAX_CARTES] of TCarte;
  TPlayers = record
       Cartes: array[1..15] of TIdCarte;
       ImgCartes: array[1..15] of TImage;
       PlCartes: array[1..4] of TImage;
       ident: string;
       LPlPos: integer; (* position horizontale initiale des cartes jouées *)
       TPlPos: integer; (* position verticale initiale des cartes jouées *)
       position: integer; (* 0 -> 3 *)
       name: TLabel;
       maitre: TImage;
       IA: TImage;
       cant: TImage;
       Wait: TImage;
       owner: TImage;
       kick: TSpeedButton;
       fini: boolean;
       kicked: boolean;
  end;
  TPlayer = class(TObject)
    no: array[0..3] of TPlayers;
  end;
  TForm1 = class(TForm)
    StatusBar: TStatusBar;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    newgame: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    e1m: TImage;
    pm: TImage;
    e2m: TImage;
    e3m: TImage;
    lastmemo: TMemo;
    msg: TComboBox;
    SendMessage: TSpeedButton;
    Gauge1: TGauge;
    e3name: TLabel;
    e1name: TLabel;
    e2name: TLabel;
    mynick: TLabel;
    e3wait: TImage;
    e1wait: TImage;
    e2wait: TImage;
    pwait: TImage;
    e3cant: TImage;
    e1cant: TImage;
    e2cant: TImage;
    pcant: TImage;
    partgame: TMenuItem;
    Aide1: TMenuItem;
    Apropos1: TMenuItem;
    N2: TMenuItem;
    Rglesdujeu1: TMenuItem;
    BitBtn1: TSpeedButton;
    Donner: TSpeedButton;
    BitBtn2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    e1ia: TImage;
    e3ia: TImage;
    e2ia: TImage;
    pia: TImage;
    ListStats: TListView;
    Statistiques: TPanel;
    Informationsserveur1: TMenuItem;
    e3owner: TImage;
    e1owner: TImage;
    e2owner: TImage;
    powner: TImage;
    e3kick: TSpeedButton;
    e1kick: TSpeedButton;
    e2kick: TSpeedButton;
    pkick: TSpeedButton;
    Configurer1: TMenuItem;
    N3: TMenuItem;
    Timer1: TTimer;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Timer2: TTimer;
    newmsg: TMemo;
    MOTD: TMemo;
    Compte1: TMenuItem;
    itemregister: TMenuItem;
    Administration1: TMenuItem;
    Envoyerunmessageglobal1: TMenuItem;
    N4: TMenuItem;
    Fermerleserveur1: TMenuItem;
    Listedesusers1: TMenuItem;
    Label1: TLabel;
    Image34: TImage;
    Image35: TImage;
    SpeedButton3: TSpeedButton;
    N5: TMenuItem;
    Stats1: TMenuItem;
    bestscores: TMenuItem;
    ActionList1: TActionList;
    envoyer: TAction;
    SelCarte1: TAction;
    SelCarte2: TAction;
    SelCarte3: TAction;
    SelCarte4: TAction;
    SelCarte5: TAction;
    SelCarte6: TAction;
    SelCarte7: TAction;
    SelCarte8: TAction;
    SelCarte9: TAction;
    SelCarte10: TAction;
    PeutpasyDistribuer: TAction;
    CreateGame: TAction;
    JoinGame: TAction;
    Listedesprincipauxraccourcis1: TMenuItem;
    Pause: TAction;
    memo: TRichEdit;
    Action1: TAction;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Image45: TImage;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    Image49: TImage;
    Image50: TImage;
    Image51: TImage;
    Image52: TImage;
    Image53: TImage;
    Image54: TImage;
    Image55: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Quitter1Click(Sender: TObject);
    procedure newgameClick(Sender: TObject);
    procedure SendMessageClick(Sender: TObject);
    procedure msgKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure show_cartes(buf: string);
    procedure FormCreate(Sender: TObject);
    procedure partgameClick(Sender: TObject);
    procedure part_game(prefix: string; buf: string);
    procedure join_game(buf: string);
    procedure player_join_game(nick: string; buf: string);
    procedure Apropos1Click(Sender: TObject);
    procedure play_carte(Sender: TObject);
    procedure someone_play(Prefix, buf: string);
    procedure to_me();
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure personne_peut();
    procedure DonnerClick(Sender: TObject);
    procedure someone_cant(Prefix: string);
    procedure someone_begin(Prefix: string);
    procedure end_of_game(own: string; buf: string);
    procedure someone_win(Prefix, buf: string);
    procedure recv_cartes(Prefix, buf: string);
    procedure affiche_cartes(Cards: TStringList);
    procedure cartes_a_donner(buf: string);
    procedure Rglesdujeu1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure clear_window();
    procedure Informationsserveur1Click(Sender: TObject);
    procedure kick_user(prefix: string; buf: string);
    procedure kickClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Configurer1Click(Sender: TObject);
    procedure change_fontcolor();
    procedure mer2Timer(Sender: TObject);
    procedure itemregisterClick(Sender: TObject);
    procedure Envoyerunmessageglobal1Click(Sender: TObject);
    procedure Fermerleserveur1Click(Sender: TObject);
    procedure Listedesusers1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Stats1Click(Sender: TObject);
    procedure bestscoresClick(Sender: TObject);
    procedure envoyerExecute(Sender: TObject);
    procedure to_play_carte(i: integer);
    procedure ClavSelCarte(Sender: TObject);
    procedure PeutpasyDistribuerExecute(Sender: TObject);
    procedure CreateGameExecute(Sender: TObject);
    procedure JoinGameExecute(Sender: TObject);
    procedure Listedesprincipauxraccourcis1Click(Sender: TObject);
    procedure PauseExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Déclarations privées }
  public
    Player: TPlayer;
    Cartes: TCartes;
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  game_name: string;
  IsInChange: boolean = false;
  ChangeMax: boolean = false;
  IsToMe: boolean = false;
  TopCartes: integer = 0;
  IBegin: boolean = false;
  CartesToPlay: integer = 4;
  MinCarte: integer = 0;
  selcarte: integer = 440;
  norcarte: integer = 454;
  EspaceCartes: integer = 12;
  IsInClose: boolean = false;
  IsStop: boolean = false;
  IsMOTD: boolean = false;
  Is52C: boolean = false;
  game: integer; (* 0=hors jeu, 1=stop, 2=en jeu, 3=wait *)
  myident: array [0..1] of integer;  (* 0= place, 1= grade *)

procedure show_rules(buf: string);
function GetPlace(ident: string): integer;
function GetGrade(ident: string): integer;
function GetIdent(ident: array of integer): string;
function GetValeur(carte: string): integer;
function NextPlayer(i: integer): integer;
function GetCarte(Id: string): TCarte;
function Power(a: Integer; n: Integer): Integer;

implementation

uses
  newgame, choosegame, apropos, infoserver, config, regnick, listusers,
  statsshow;

{$R *.dfm}

function GetCarte(Id: string): TCarte;
var
  i: integer;
begin
  for i := 1 to MAX_CARTES do
  begin
    if(Id = Form1.Cartes[i].Id) then
    begin
      Result := Form1.Cartes[i];
      exit;
    end;
  end;
  Error(ERR_CLIENT, 'Carte introuvable !!!' + sLineBreak +
         'Êtes vous sur de ne pas avoir touché à la configuration ?');
end;

function Power(a: Integer; n: Integer): Integer;
var
  i: Integer;
begin
  Result := a;
  for i := 1 to n - 1 do
    Result := Result * a;
  Power := Result;
end;

function NextPlayer(i: integer): integer;
var
  j: integer;
  fin: boolean;
begin
  fin := false;
  j := 0;
  while fin = false do
  begin
    if(i = 3) then i := 0
    else i := i + 1;
    if(j >= 4) then break;
    if(Form1.Player.no[i].fini = false) and (Form1.player.no[i].cant.visible = false) then
      fin := true;
    j := j + 1;
  end;
  if not fin then
    i := -1;
  Result := i;
end;

procedure TForm1.change_fontcolor();
begin
   if(game = 0) or (game > 2) then
   begin
     mynick.font.Color := conf.fontcolor;
     e1name.font.Color := conf.fontcolor;
     e2name.font.Color := conf.fontcolor;
     e3name.font.Color := conf.fontcolor;
   end;
   Memo.font.color := conf.fontcolor;
   Msg.font.color := conf.fontcolor;
   SpeedButton1.font.color := conf.fontcolor;
   SpeedButton2.Font.color := conf.fontcolor;
   MOTD.Font.Color := conf.fontcolor;
   Donner.Font.color := conf.fontcolor;
   BitBtn1.font.color := conf.fontcolor;
   BitBtn2.font.color := conf.fontcolor;
   liststats.Font.color := conf.fontcolor;
   Label1.Font.Color := conf.fontcolor;
end;

procedure TForm1.cartes_a_donner(buf: string);
var
  h, i, j: integer;
  s: string;
begin
  CartesToPlay := GetPlace(buf); // appel de GetPlace mais c'est pour recupérer le premier char
  s := Copy(buf, 2, 1);
  if(s = '+') then ChangeMax := true
  else ChangeMax := false;

  Donner.Visible := true;
  Timer1.Enabled := true;
  Gauge1.Visible := true;
  IsToMe := false;
  TopCartes := 0;
  IsInChange := true;
  if(ChangeMax = true) then
  begin
    Donner.Enabled := true;
    for h := 1 to CartesToPlay do
    begin
      j := 0;
      for i := 1 to 15 do
      begin
        if(Player.no[myident[0]].Cartes[i] = '') then break;
        if(j = 0) then j := i
        else if (GetValeur(Player.no[myident[0]].Cartes[i]) > GetValeur(Player.no[myident[0]].Cartes[j])) and
                (Player.no[myident[0]].ImgCartes[i].Top = norcarte) then
          j := i;
      end;
      Player.no[myident[0]].ImgCartes[j].Top := selcarte;
      TopCartes := TopCartes + 1;
    end;
    if(CartesToPlay = 1) then
      Statusbar.Panels[1].Text := 'Veuillez donner votre meilleur carte.'
    else
      StatusBar.Panels[1].text := 'Veuillez donner vos ' + IntToStr(CartesToPlay) + ' meilleurs cartes.';
    CartesToPlay := 0;
  end
  else
  begin
    Donner.Enabled := false;
    for i := 1 to 15 do
    begin
      if(Player.no[myident[0]].imgcartes[i] = nil) then break;
      Player.no[myident[0]].ImgCartes[i].Cursor := crHandPoint;
    end;
    if(CartesToPlay = 1) then
      StatusBar.Panels[1].Text := 'Veuillez donner une carte.'
    else
      Statusbar.panels[1].text := 'Veuillez donner ' + IntToStr(CartesToPlay) + ' cartes.';
  end;
end;

procedure TForm1.affiche_cartes(Cards: TStringList);
var
  i: integer;
  Cursor: TCursor;
begin
  Cursor := crDefault;
  for i := 1 to 15 do
  begin
    with Player.no[myident[0]] do
    begin
      if(Cartes[i] = '') then break;
      Cartes[i] := '';
      if (i = 1) then Cursor := ImgCartes[i].Cursor;
      ImgCartes[i].visible := false;
      ImgCartes[i] := nil;
    end;
  end;
  for i := 1 to 15 do
  begin
     with Player.no[myident[0]] do
     begin
       if(Cards[i - 1] <> '') then
       begin
         ImgCartes[i] := GetCarte(Cards[i - 1]).img;
         ImgCartes[i].Visible := true;
         ImgCartes[i].BringToFront;
         ImgCartes[i].Cursor := Cursor;
         ImgCartes[i].Top := 454;
         ImgCartes[i].Tag := i;
         Cartes[i] := Cards[i - 1];
         ImgCartes[i].OnClick := play_carte;
         ImgCartes[i].Left := 298 + ((i-1)* EspaceCartes);
       end
       else break;
     end;
  end;
end;

procedure TForm1.recv_cartes(Prefix, buf: string);
var
  i, h, j, k: integer;
  carte: string;
  Cards: TStringList;
  s: string;
  aCarte: TCarte;
begin
  Cards:= TStringList.Create;
  s := 'Vous avez reçu un(e) ';
  for i := 1 to 15 do
  begin
    if(Player.no[myident[0]].Cartes[i] <> '') then
        Cards.Add(Player.no[myident[0]].Cartes[i])
    else break;
  end;
  for i := 1 to 2 do
  begin
    carte := strchr(buf, ',');
    if(carte = '') then break;
    Cards.Add(carte);
    aCarte := GetCarte(carte);
    if(i = 2) then s := s + ' et un(e) ';
    s := s + aCarte.Nom;
  end;
  Cards.Sort;
  Cards.Add('');
  affiche_cartes(Cards);
  Cards.free;
  Donner.Enabled := false;

  if(ChangeMax = true) then
  begin
    Donner.Enabled := true;
    for h := 1 to TopCartes do
    begin
      j := 0;
      for i := 1 to 15 do
      begin
        if(Player.no[myident[0]].Cartes[i] = '') then break;
        k := GetValeur(Player.no[myident[0]].Cartes[i]);
        if(j = 0) then j := i
        else if (k > GetValeur(Player.no[myident[0]].Cartes[j])) and
                (Player.no[myident[0]].ImgCartes[i].Top = norcarte) then
          j := i;
      end;
      Player.no[myident[0]].ImgCartes[j].Top := selcarte;
    end;
  end
  else TopCartes := 0;
  Statusbar.Panels[0].text := s;
end;

procedure TForm1.someone_win(Prefix, buf: string);
var
  place, i: integer;
  tmp1: string;
begin
  place := StrToInt(buf);
  i := GetPlace(Prefix);
  if(i = myident[0]) then
  begin
    myident[1] := place;
    SpeedButton3.Visible := false;
  end;
  Player.no[i].ident := IntToStr(i) + IntToStr(place);
  if(place = 1) then
  begin
    tmp1 := 'Président';
    Player.no[i].name.Font.Color := conf.fontpresident;
    (*    if(i = myident[0]) then iowner := true
    else iowner := false;  *)
  end
  else if(place = 2) then
  begin
    tmp1 := 'Vice Président';
    Player.no[i].name.Font.Color := conf.fontvpresident;
  end
  else if(place = 3) then
  begin
    tmp1 := 'Vice Trou du cul';
    Player.no[i].name.Font.Color := conf.fontvtrouduk;
  end
  else if(place = 4) then
  begin
    tmp1 := 'Trou du cul';
    Player.no[i].name.Font.Color := conf.fonttrouduk;
  end;
  AddInMemo(conf.fontcolor, '*** ' + Player.no[i].name.Caption + ' a fini ' + tmp1 + '.');
  Player.no[i].Wait.visible := false;
  Player.no[i].cant.visible := false;
  Player.no[i].fini := true;
  if(i = myident[0]) then Statusbar.Panels[1].Text := 'Vous avez fini ' + tmp1;
end;

procedure TForm1.end_of_game(own: string; buf: string);
var
  i, j: integer;
  s, tmp: string;
  ListItem: TListItem;
begin
  Statistiques.Visible := true;
  SpeedButton3.Visible := false;
  SpeedButton3.down := false;
  ListStats.Visible := true;
  s := strchr(buf, ' ');
  while s <> '' do
  begin
    ListItem := ListStats.Items.Add;
    i := GetPlace(strchr(s, ':'));
    ListItem.Caption := Player.no[i].name.Caption;
    tmp := strchr(s, ':');
    ListItem.SubItems.Add(strchr(s, ':') + '/' + tmp);
    ListItem.SubItems.Add(strchr(s, ':') + '/' + tmp);
    ListItem.SubItems.Add(strchr(s, ':') + '/' + tmp);
    ListItem.SubItems.Add(strchr(s, ':') + '/' + tmp);
    ListItem.SubItems.Add(strchr(s, ':'));
    s := strchr(buf, ' ');
  end;
    for i := 0 to 3 do
    begin
      with Player.no[i] do
      begin
        for j := 1 to 15 do
        begin
          if(i <> myident[0]) and (ImgCartes[j] <> nil) then ImgCartes[j].free
          else if(ImgCartes[j] <> nil) then
          begin
            ImgCartes[j].visible := false;
            ImgCartes[j] := nil;
          end;
          if(j <= 4) and (PlCartes[j] <> nil) then
          begin
            PlCartes[j].visible := false;
            PlCartes[j] := nil;
          end;
          Cartes[j] := '';
        end;
        maitre.visible := false;
        wait.visible := false;
        cant.visible := false;
        if(GetPlace(own) = myident[0]) and (i <> myident[0]) and (ia.Visible = false) then
          kick.Visible := true
        else kick.Visible := false;
        if(GetPlace(own) = i) then
        begin
          owner.Visible := true;
          if(i = myident[0]) then
            BitBtn2.Visible := true;
        end
        else owner.Visible := false;
      end;
    end;

    game := 1;
    MinCarte := 0;
    CartesToPlay := 4;
    Gauge1.Visible := false;
    Gauge1.Progress := 0;
    Timer1.Enabled := false;
    Timer2.Enabled := false;
    IsInChange := false;
    ChangeMax := false;
    IsToMe := false;
    TopCartes := 0;
    IBegin := false;
    IsStop := false;
    AddInMemo(conf.fontcolor, '*** Partie terminée');
    StatusBar.Panels[1].Text := 'Partie terminée';
    StatusBar.Panels[0].Text := '';
    Form1.Caption := 'Trou du cul - Serveur ' + Server_name + ' - ' + nickname + ' - Jeu en cours: ' + game_name + ' - Stop';

end;

procedure TForm1.someone_begin(Prefix: string);
var
  i: integer;
begin
  i := GetPlace(Prefix);
  Player.no[i].Wait.Visible := true;
  if(Player.no[myident[0]].fini = true) then Statusbar.Panels[1].Text := 'C''est à ' + Player.no[i].name.Caption + ' de jouer';
end;

procedure TForm1.someone_cant(Prefix: string);
var
  i, k: integer;
begin
  i := GetPlace(Prefix);
  k := NextPlayer(i);
  if(k >= 0) then begin
    StatusBar.Panels[1].Text := 'C''est à ' + Player.no[k].name.caption + ' de jouer';
    Player.no[k].Wait.Visible := true;
  end;
  Player.no[i].Wait.Visible := false;
  Player.no[i].maitre.visible := false;
  Player.no[i].cant.visible := true;
  for k := 1 to 4 do
  begin
    if(Player.no[i].Plcartes[k] <> nil) then Player.no[i].PlCartes[k].visible := false;
  end;
end;

procedure TForm1.personne_peut();
var
  i, k: integer;
begin
  IBegin := true;
  StatusBar.Panels[0].text := '';
  StatusBar.panels[1].text := 'Personne peut !';
  for i := 0 to 3 do
  begin
    with Player.no[i] do
    begin
      maitre.Visible := false;
      cant.Visible := false;
      wait.Visible := false;
      CartesToPlay := 4;
      MinCarte := 0;
      for k := 1 to 4 do
      begin
        if(PlCartes[k] <> nil) then
          PlCartes[k].Visible := false;
      end;
    end;
  end;
end;

procedure TForm1.someone_play(Prefix, buf: string);
var
  i, j, k, nbcartes, value: integer;
  carte, s: string;
  C: TCarte;
begin
  IBegin := false;
  i := GetPlace(Prefix);
  nbcartes := 0;

  for j := 0 to 3 do
  begin
    if(Player.no[j].maitre.Visible = true) then
       Player.no[j].maitre.Visible := false;
  end;

  for j := 1 to 4 do
  begin
    carte := strchr(buf, ',');
    if(carte = '') then break;
    nbcartes := nbcartes + 1;
    value := GetValeur(carte);
    with Player.no[i] do
    begin
      if(PlCartes[j] <> nil) then PlCartes[j].Visible := false;
      C := GetCarte(carte);
      PlCartes[j] := C.img;
      PlCartes[j].Visible := true;
      PlCartes[j].Cursor := crDefault;
      PlCartes[j].Top := TPlPos;
      PlCartes[j].BringToFront;
      PlCartes[j].Left := LPlPos + ((j-1)*EspaceCartes);
      if(j = 1) then MinCarte := value;
    end;
    if(Prefix = GetIdent(myident)) then
        for k := 1 to 15 do
          if(Player.no[i].ImgCartes[k] <> nil) then
          begin
            Player.no[i].ImgCartes[k].Cursor := crDefault;
            if(Player.no[i].Cartes[k] = carte) then
            begin
              Player.no[i].ImgCartes[k].OnClick := nil;
              Player.no[i].ImgCartes[k] := nil;
            end;
          end;
  end;
  CartesToPlay := nbcartes;
  if(Prefix <> GetIdent(myident)) then
    for j := 1 to 15 do
    begin
      if(nbcartes = 0) then break;
      if(Player.no[i].ImgCartes[j].Visible = true) then
      begin
        Player.no[i].ImgCartes[j].Visible := false;
        nbcartes := nbcartes - 1;
//        Player.no[i].Cartes[j] := '';
      end;
    end;
  Player.no[i].maitre.Visible := true;
  Player.no[i].Wait.Visible := false;
  k := NextPlayer(i);
  if(CartesToPlay = 1) then s := 'simple'
  else if(CartesToPlay = 2) then s := 'double'
  else if(CartesToPlay = 3) then s := 'triple'
  else if(CartesToPlay = 4) then s := 'quadruple';
  StatusBar.Panels[0].Text := Player.no[i].name.Caption + ' a joué un(e) ' + s + ' ' + C.Nom;
  if(k >= 0) then
  begin
    StatusBar.Panels[1].Text := 'C''est à ' + Player.no[k].name.caption + ' de jouer';
    Player.no[k].Wait.Visible := true;
  end;
  if(Prefix = GetIdent(myident)) then
  begin
    Gauge1.Progress := 0;
    Timer1.Enabled := false;
  end;
end;

procedure TForm1.to_me();
var
  i: integer;
  possible: boolean;
begin
  if conf.nowaitcant then possible := false
  else possible := true;
  for i := 1 to 15 do
  begin
    if(Player.no[myident[0]].ImgCartes[i] <> nil) then
    begin
      Player.no[myident[0]].ImgCartes[i].Cursor := crHandPoint;
      if conf.nowaitcant and (GetValeur(Player.no[myident[0]].Cartes[i]) > MinCarte) then
        possible := true;
    end;
  end;
  if not possible then
    Timer2.Enabled := true
  else begin
    Timer1.Enabled := true;
    Gauge1.Visible := true;
    if not Form1.Active then Beep();
  end;
  if IBegin then
    BitBtn1.enabled := false
  else
    BitBtn1.Enabled := true;
  BitBtn1.Visible := true;
  Donner.Visible := true;
  Donner.Enabled := false;
  IsToMe := true;
  TopCartes := 0;
  
  Statusbar.Panels[1].Text := 'C''est à vous de jouer';
end;

procedure TForm1.to_play_carte(i: integer);
var
  j, k: integer;
begin
  if(Player.no[myident[0]].ImgCartes[i] = nil) or IsStop then exit;
  
  if IsInChange and (CartesToPlay > 0) then
  begin
     if(Player.no[myident[0]].ImgCartes[i].Top = norcarte) and (TopCartes < CartesToPlay) then
     begin
        Player.no[myident[0]].ImgCartes[i].Top := selcarte;
        TopCartes := TopCartes + 1;
        if(TopCartes = CartesToPlay) then
          Donner.Enabled := true;
     end
     else if(Player.no[myident[0]].ImgCartes[i].Top = selcarte) then
     begin
        Player.no[myident[0]].ImgCartes[i].Top := norcarte;
        TopCartes := TopCartes - 1;
        if(TopCartes < CartesToPlay) then
          Donner.Enabled := false;
     end;
  end
  else if(IsToMe = true) then
  begin
      k := 0;
      for j := 1 to 15 do
      begin
        if(Player.no[myident[0]].Cartes[j] = '') then break;
        if(Player.no[myident[0]].ImgCartes[j] <> nil) and (Player.no[myident[0]].ImgCartes[j].Top = selcarte) then
        begin
          k := 1;
          break;
        end;
      end;
      if(Player.no[myident[0]].ImgCartes[i].Top = norcarte) and (TopCartes < CartesToPlay) and
        (GetValeur(Player.no[myident[0]].Cartes[i]) > MinCarte) and
        ((k = 0) or (GetValeur(Player.no[myident[0]].Cartes[j]) = GetValeur(Player.no[myident[0]].Cartes[i]))) then
      begin
         Player.no[myident[0]].ImgCartes[i].Top := selcarte;
         TopCartes := TopCartes + 1;
         if(TopCartes = CartesToPlay) or ((MinCarte = 0) and (TopCartes > 0)) then
        begin
          Donner.Enabled := true;
          BitBtn1.Enabled := false;
        end;
      end
      else if(Player.no[myident[0]].ImgCartes[i].Top = selcarte) then
      begin
         Player.no[myident[0]].ImgCartes[i].Top := norcarte;
         TopCartes := TopCartes - 1;
         if((MinCarte > 0) and (TopCartes < CartesToPlay)) or ((MinCarte = 0) and (TopCartes = 0)) then
         begin
          Donner.Enabled := false;
          if(IBegin = false) then BitBtn1.Enabled := true;
         end;
      end;
  end;
end;

procedure TForm1.play_carte(Sender: TObject);
var
  i: integer;
begin
  i := TImage(Sender).Tag;

  to_play_carte(i);
end;

procedure TForm1.player_join_game(nick: string; buf: string);
var
  place, grade, IsIA: integer;
  ident: string;
begin
  ident := strchr(buf, ' ');
  IsIA := StrToInt(strchr(buf, ' '));
  place := GetPlace(ident);
  Player.no[place].ident := ident;
  with Player.no[place] do
  begin
     position := ((place - myident[0])+4) mod 4;
     if(position = 1) then
     begin
       maitre := e1m;
       wait := e1wait;
       cant := e1cant;
       name := e1name;
       ia := e1ia;
       owner := e1owner;
       kick := e1kick;
     end
     else if(position = 2) then
     begin
       maitre := e3m;
       wait := e3wait;
       cant := e3cant;
       name := e3name;
       ia := e3ia;
       owner := e3owner;
       kick := e3kick;
     end
     else if(position = 3) then
     begin
       maitre := e2m;
       wait := e2wait;
       cant := e2cant;
       name := e2name;
       ia := e2ia;
       owner := e2owner;
       kick := e2kick;
     end;
     kick.Tag := place;
     kicked := false;
     grade := GetGrade(ident);
     if(IsIA = 1) then
     begin
       ia.Visible := true;
       kick.Visible := false;
     end
     else begin
       ia.Visible := false;
       AddInMemo(conf.fontcolor, '*** ' + nick + ' a rejoint le jeu');
       if(Player.no[myident[0]].owner.visible = true) then
         kick.Visible := true;
     end;
     if(grade = 1) then
       name.Font.Color := clAqua
     else if(grade = 2) then
       name.Font.Color := clBlue
     else if(grade = 3) then
       name.Font.Color := clRed
     else if(grade = 4) then
       name.Font.Color := clMaroon;
     name.Caption := nick;
     name.Visible := true;
  end;
end;

procedure TForm1.clear_window();
var
  i, j: integer;
begin
  if(game = 0) then exit;
    for i := 1 to MAX_CARTES do
      Cartes[i].img.Visible := false;
    for i := 0 to 3 do
    begin
      with Player.no[i] do
      begin
        for j := 1 to 15 do
        begin
          if(Cartes[j] = '') or (i = myident[0]) then break;
          ImgCartes[j].free;
          Cartes[j] := '';
        end;
        maitre.visible := false;
        wait.visible := false;
        cant.visible := false;
        name.Visible := false;
        ia.Visible := false;
        kick.Visible := false;
        owner.Visible := false;
        name.Font.Color := clWindowText;
      end;
    end;
    game := 0;
    newgame.Enabled := true;
    partgame.Enabled := false;
    Memo.Visible := false;
    Memo.Clear;
    SendMessage.Visible := false;
    Msg.visible := false;
    Msg.Text := '';
    BitBtn2.Visible := false;
    statistiques.Visible := false;
    ListStats.Visible := false;
    SpeedButton1.visible := true;
    SpeedButton2.Visible := true;
    Label1.Visible := false;
    if(IsMOTD) then MOTD.Visible := true;
    Timer1.Enabled := false;
    Gauge1.Visible := false;
    BitBtn1.Visible := false;
    Donner.Visible := false;
    game_name := '';
    Form1.Caption := 'Trou du cul - Serveur ' + Server_name + ' - ' + nickname;
end;

procedure TForm1.part_game(prefix: string; buf: string);
var
  i: integer;
begin
  if(prefix = GetIdent(myident)) then
  begin
    (* Dans le cas d'un part personnel *)
    clear_window();
  end
  else begin
    (* Dans le cas où c'est un autre connard qui part *)
    i := GetPlace(prefix);
    if(Player.no[i].IA.Visible = false) and (Player.no[i].kicked = false) then
      AddInMemo(conf.fontcolor, '*** ' + Player.no[i].name.Caption + ' a quitté le jeu')
    else Player.no[i].kicked := false;
    if(Player.no[i].owner.Visible) then Player.no[i].owner.Visible := false;
  end;
end;

procedure TForm1.kick_user(prefix: string; buf: string);
var
  i: integer;
begin
  if(buf = GetIdent(myident)) then
  begin
    MessageDlg('Vous avez été éjecté du jeu ' + game_name, MtInformation, [mbok], 0);
  end
  else begin
    i := GetPlace(buf);
    Player.no[i].kicked := true;
    AddInMemo(conf.fontcolor, '*** ' + Player.no[i].name.Caption + ' a été éjecté du jeu');
  end;
end;

function GetIdent(ident: array of integer): string;
begin
  Result := IntToStr(ident[0]) + IntToStr(ident[1]);
end;

function GetPlace(ident: string): integer;
begin
  Result := StrToInt(Copy(ident, 0, 1));
end;

function GetGrade(ident: string): integer;
begin
  Result := StrToInt(Copy(ident, 2, 1));
end;

function GetValeur(carte: string): integer;
var
  s: string;
begin
  s := Copy(carte, 0, 1);
  if(s = '1') then Result := 1
  else if(s = '2') then Result := 2
  else if(s = '3') then Result := 3
  else if(s = '4') then Result := 4
  else if(s = '5') then Result := 5
  else if(s = '6') then Result := 6
  else if(s = '7') then Result := 7
  else if(s = '8') then Result := 8
  else if(s = '9') then Result := 9
  else if(s = 'A') then Result := 10
  else if(s = 'B') then Result := 11
  else if(s = 'C') then Result := 12
  else if(s = 'D') then Result := 13
  else begin
    Error(ERR_CLIENT, 'Valeur de la carte ' + carte + ' introuvable !!');
    Result := 0;
  end;
end;

procedure TForm1.show_cartes(buf: string);
var
  i, j, NbC: integer;
  carte: string;
  CardList: TStringList;
begin
  if Is52C then NbC := 13
  else NbC := 8;
  BitBtn2.Visible := false;
  IBegin := true;
  CardList := TStringList.Create;
  for i := 1 to NbC do
  begin
    carte := strchr(buf, ',');
    CardList.Add(carte);
  end;
  CardList.Sort;
  for i := 1 to NbC do
  begin
     with Player.no[myident[0]] do
     begin
       if(i = 1) then
         fini := false;
       ImgCartes[i] := GetCarte(CardList[i-1]).img;
       ImgCartes[i].Top := 454;
       ImgCartes[i].Visible := true;
       ImgCartes[i].BringToFront;
       ImgCartes[i].Tag := i;
       ImgCartes[i].OnClick := play_carte;
       ImgCartes[i].Left := 298 + ((i-1)*EspaceCartes);
       Cartes[i] := CardList[i - 1];
       TPlPos := 314;
       LPlPos := 322;
     end;
     for j := 0 to 3 do
     begin
       if(j = myident[0]) then continue;
       with Player.no[j] do
       begin
         Cartes[i] := '??';
         fini := false;
         ImgCartes[i] := TImage.Create(Self);
         ImgCartes[i].Parent := Self;
         ImgCartes[i].AutoSize := false;
         ImgCartes[i].Stretch := true;
         ImgCartes[i].Proportional := true;
         ImgCartes[i].Tag := i;
         ImgCartes[i].Height := 97;
         ImgCartes[i].Width := 69;
         if(conf.backcarte = -1) then
           ImgCartes[i].Picture := GetCarte('XX').img.Picture
         else
           ImgCartes[i].Picture := GetCarte('X' + inttostr(conf.backcarte)).img.Picture;
         if(i <= 4) then
         begin
           if(position = 1) then
           begin
             TPlPos := 234;
             LPlPos := 242;
           end
           else if(position = 2) then
           begin
             TPlPos := 154;
             LPlPos := 322;
           end
           else if(position = 3) then
           begin
             TPlPos := 238;
             LPlPos := 406;
           end;
         end;
         if(position = 1) then
         begin
           ImgCartes[i].Top := 140 + ((i-1)*EspaceCartes);
           ImgCartes[i].Left := 40;
         end
         else if(position = 2) then
         begin
           ImgCartes[i].Top := 35;
           ImgCartes[i].Left := 320 + ((i-1)*EspaceCartes);
         end
         else if(position = 3) then
         begin
           ImgCartes[i].Top := 140 + ((i-1)*EspaceCartes);
           ImgCartes[i].Left := 660;
         end
       end;
     end;
  end;
  game := 2;
  CardList.Free;
  AddInMemo(conf.fontcolor, '*** La partie vient de commencer !');
  Form1.Caption := 'Trou du cul - Serveur ' + Server_name + ' - ' + nickname + ' - Jeu en cours: ' + game_name;
  Statistiques.Visible := false;
  ListStats.visible := false;
  ListStats.Items.Clear;

  if Player.no[myident[0]].owner.visible then
    SpeedButton3.Visible := true;
end;

procedure show_rules(buf: string);
var
  val: integer;
begin
  val := StrToInt(strchr(buf, ' '));
  Form1.Gauge1.MaxValue := val;
  if(buf = '1') then Is52C := true
  else Is52C := false;
end;

procedure TForm1.join_game(buf: string);
var
  gamename, ident: string;
  grade: integer;
begin
  gamename := strchr(buf, ' ');
  ident := strchr(buf, ' ');

  myident[0] := GetPlace(ident);
  myident[1] := GetGrade(ident);

  SpeedButton1.Visible := false;
  SpeedButton2.Visible := false;
  MOTD.Visible := false;
  Label1.Visible := false;
  Memo.Visible := true;
  SendMessage.Visible := true;
  Msg.visible := true;
  newgame.Enabled := false;
  partgame.Enabled := true;
  Player.no[myident[0]].ident := ident;
  with Player.no[myident[0]] do
  begin
    position := 0;
    kicked := false;
    kick := pkick;
    maitre := pm;
    wait := pwait;
    cant := pcant;
    ia := pia; (* ne sert pas *)
    owner := powner;
    name := mynick;
    grade := GetGrade(ident);
    if(grade = 1) then
       name.Font.Color := clAqua
    else if(grade = 2) then
       name.Font.Color := clBlue
    else if(grade = 3) then
       name.Font.Color := clRed
    else if(grade = 4) then
       name.Font.Color := clMaroon;
    name.Caption := nickname;
    name.Visible := true;
    if(creating = true) then begin
      BitBtn2.Visible := true;
      owner.Visible := true;
    end;
  end;
  AddInMemo(conf.fontcolor, '*** Vous avez rejoint la partie ' + gamename);
  IsInChange := false;
  ChangeMax := false;
  IsToMe := false;
  TopCartes := 0;
  IBegin := false;
  CartesToPlay := 4;
  MinCarte := 0;
  IsStop := false;
  game_name := gamename;
  joining := false;
  creating := false;
  gamelist.BitBtn3.Enabled := true;
  Form1.Caption := 'Trou du cul - Serveur ' + Server_name + ' - ' + nickname + ' - Jeu en cours: ' + gamename + ' - Stop';
  game := 1;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{  if(game = 0) or (Messagedlg('Êtes-vous sur de vouloir quitter ? Une partie est en cours',
                        mtconfirmation, [mbyes, mbno], 0) = mryes) then
  begin
    sendtoserver(MSG_QUIT);
    Connexion.IdTCPClient1Disconnected(Sender);
  end
  else
    Action := caNone; }
end;

procedure TForm1.Quitter1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.newgameClick(Sender: TObject);
begin
  gamelist.ShowModal;
end;

procedure TForm1.SendMessageClick(Sender: TObject);
begin
if(Msg.Text <> '') then
begin
 (* Nouveau system (TODO: à activer et corriger surtout)
    sendtoserver(MSG_MSG + Msg.Lines.Strings[Msg.CaretPos.Y]);
    AddInMemo('<' + nickname + '> ' + Msg.Lines.Strings[Msg.CaretPos.Y]);
    // Msg. := Msg.Lines.Count - 1;
    //  Msg.Items.Insert(0, Msg.text);
 *)
 (* Ancien (TODO: à supprimer) *)
  sendtoserver(MSG_MSG + Msg.text);
  AddInMemo(conf.fontcolor, '<' + nickname + '> ' + Msg.Text);
  Msg.text := '';
end;
end;

procedure TForm1.msgKeyPress(Sender: TObject; var Key: Char);
begin
if (key = #13) then
  SendMessageClick(Sender)
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  BitBtn2.Visible := false;
  sendtoserver(MSG_DISTRIBUE);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Player := TPlayer.Create;
//  fillchar(Player, sizeof(Player), #0);
  Form1.Color := conf.maincolor;
  Memo.Color := conf.maincolor;
  MOTD.Color := conf.maincolor;
  Msg.Color := conf.maincolor;
  SoyAdmin := false;
  itemregister.Enabled := true;
  Administration1.Visible := false;
  ListStats.Color := conf.maincolor;
  change_fontcolor();
  Timer2.Interval := conf.animation * 10;
  (* Initialisation des cartes.. Bourin mais bon *)
  Cartes[1].Id := '5A';
  Cartes[1].Nom := 'Sept';
  Cartes[2].Id := '5C';
  Cartes[2].nom := 'Sept';
  Cartes[3].Id := '5P';
  Cartes[3].nom := 'Sept';
  Cartes[4].Id := '5T';
  Cartes[4].nom := 'Sept';
  Cartes[5].Id := '6A';
  Cartes[5].Nom := 'Huit';
  Cartes[6].Id := '6C';
  Cartes[6].Nom := 'Huit';
  Cartes[7].Id := '6P';
  Cartes[7].nom := 'Huit';
  Cartes[8].Id := '6T';
  Cartes[8].nom := 'Huit';
  Cartes[9].Id := '7A';
  Cartes[9].nom := 'Neuf';
  Cartes[10].Id := '7C';
  Cartes[10].nom := 'Neuf';
  Cartes[11].Id := '7P';
  Cartes[11].nom := 'Neuf';
  Cartes[12].Id := '7T';
  Cartes[12].nom := 'Neuf';
  Cartes[13].Id := '8A';
  Cartes[13].nom := 'Dix';
  Cartes[14].Id := '8C';
  Cartes[14].nom := 'Dix';
  Cartes[15].Id := '8P';
  Cartes[15].nom := 'Dix';
  Cartes[16].Id := '8T';
  Cartes[16].nom := 'Dix';
  Cartes[17].Id := '9A';
  Cartes[17].Nom := 'Valet';
  Cartes[18].Id := '9C';
  Cartes[18].nom := 'Valet';
  Cartes[19].Id := '9P';
  Cartes[19].nom := 'Valet';
  Cartes[20].Id := '9T';
  Cartes[20].nom := 'Valet';
  Cartes[21].Id := 'AA';
  Cartes[21].nom := 'Dame';
  Cartes[22].Id := 'AC';
  Cartes[22].nom := 'Dame';
  Cartes[23].Id := 'AP';
  Cartes[23].nom := 'Dame';
  Cartes[24].Id := 'AT';
  Cartes[24].nom := 'Dame';
  Cartes[25].Id := 'BA';
  Cartes[25].nom := 'Roi';
  Cartes[26].Id := 'BC';
  Cartes[26].nom := 'Roi';
  Cartes[27].Id := 'BP';
  Cartes[27].nom := 'Roi';
  Cartes[28].Id := 'BT';
  Cartes[28].nom := 'Roi';
  Cartes[29].Id := 'CA';
  Cartes[29].nom := 'As';
  Cartes[30].Id := 'CC';
  Cartes[30].nom := 'As';
  Cartes[31].Id := 'CP';
  Cartes[31].nom := 'As';
  Cartes[32].Id := 'CT';
  Cartes[32].nom := 'As';
  Cartes[33].Id := 'XX';
  Cartes[33].nom := 'XX';
  Cartes[34].Id := 'X0';
  Cartes[34].nom := 'X0';
  Cartes[35].Id := 'X1';
  Cartes[35].nom := 'X1';

  { Cartes d'un jeu de 52 cartes }
  Cartes[36].Id := '1A';
  Cartes[36].Nom := 'Trois';
  Cartes[37].Id := '1C';
  Cartes[37].nom := 'Trois';
  Cartes[38].Id := '1P';
  Cartes[38].nom := 'Trois';
  Cartes[39].Id := '1T';
  Cartes[39].nom := 'Trois';
  Cartes[40].Id := '2A';
  Cartes[40].Nom := 'Quatre';
  Cartes[41].Id := '2C';
  Cartes[41].nom := 'Quatre';
  Cartes[42].Id := '2P';
  Cartes[42].nom := 'Quatre';
  Cartes[43].Id := '2T';
  Cartes[43].nom := 'Quatre';
  Cartes[44].Id := '3A';
  Cartes[44].Nom := 'Cinq';
  Cartes[45].Id := '3C';
  Cartes[45].nom := 'Cinq';
  Cartes[46].Id := '3P';
  Cartes[46].nom := 'Cinq';
  Cartes[47].Id := '3T';
  Cartes[47].nom := 'Cinq';
  Cartes[48].Id := '4A';
  Cartes[48].Nom := 'Six';
  Cartes[49].Id := '4C';
  Cartes[49].nom := 'Six';
  Cartes[50].Id := '4P';
  Cartes[50].nom := 'Six';
  Cartes[51].Id := '4T';
  Cartes[51].nom := 'Six';
  Cartes[52].Id := 'DA';
  Cartes[52].Nom := 'Deux';
  Cartes[53].Id := 'DC';
  Cartes[53].nom := 'Deux';
  Cartes[54].Id := 'DP';
  Cartes[54].nom := 'Deux';
  Cartes[55].Id := 'DT';
  Cartes[55].nom := 'Deux';

  Cartes[1].img := Image1;
  Cartes[2].img := Image2;
  Cartes[3].img := Image3;
  Cartes[4].img := Image4;
  Cartes[5].img := Image5;
  Cartes[6].img := Image6;
  Cartes[7].img := Image7;
  Cartes[8].img := Image8;
  Cartes[9].img := Image9;
  Cartes[10].img := Image10;
  Cartes[11].img := Image11;
  Cartes[12].img := Image12;
  Cartes[13].img := Image13;
  Cartes[14].img := Image14;
  Cartes[15].img := Image15;
  Cartes[16].img := Image16;
  Cartes[17].img := Image17;
  Cartes[18].img := Image18;
  Cartes[19].img := Image19;
  Cartes[20].img := Image20;
  Cartes[21].img := Image21;
  Cartes[22].img := Image22;
  Cartes[23].img := Image23;
  Cartes[24].img := Image24;
  Cartes[25].img := Image25;
  Cartes[26].img := Image26;
  Cartes[27].img := Image27;
  Cartes[28].img := Image28;
  Cartes[29].img := Image29;
  Cartes[30].img := Image30;
  Cartes[31].img := Image31;
  Cartes[32].img := Image32;
  Cartes[33].img := Image35;
  Cartes[34].img := Image33;
  Cartes[35].img := Image34;

  { Jeu de 52 cartes }
  Cartes[36].img := Image36;
  Cartes[37].img := Image37;
  Cartes[38].img := Image38;
  Cartes[39].img := Image39;
  Cartes[40].img := Image40;
  Cartes[41].img := Image41;
  Cartes[42].img := Image42;
  Cartes[43].img := Image43;
  Cartes[44].img := Image44;
  Cartes[45].img := Image45;
  Cartes[46].img := Image46;
  Cartes[47].img := Image47;
  Cartes[48].img := Image48;
  Cartes[49].img := Image49;
  Cartes[50].img := Image50;
  Cartes[51].img := Image51;
  Cartes[52].img := Image52;
  Cartes[53].img := Image53;
  Cartes[54].img := Image54;
  Cartes[55].img := Image55;

  if(conf.backcarte = -1) then
  begin
    if not FileExists(conf.backcartefile) then
    begin
      MessageDlg('Le fichier image de derrière de carte ' + conf.backcartefile + ' est introuvable. Mise en place du derrière par default',
        mterror, [mbok], 0);
      conf.backcarte := 0;
    end
    else
      GetCarte('XX').img.Picture.LoadFromFile(conf.backcartefile);
  end;
end;

procedure TForm1.partgameClick(Sender: TObject);
begin
  if(game = 2) then
    MessageDlg('Vous ne pouvez pas partir en pleine partie', mterror, [mbok], 0)
  else if(MessageDlg('Etes vous sur de vouloir quitter la partie ?', mtconfirmation,
         [mbyes, mbno], 0) = mryes) then
  begin
     sendtoserver(MSG_PART);
  end;
end;

procedure TForm1.Apropos1Click(Sender: TObject);
begin
  about.ShowModal;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  i: integer;
begin
  if(game <> 2) or not IsToMe then exit;
  Timer1.Enabled := false;
  Timer2.Enabled := false;
  sendtoserver('PEUTPAS');
  IsToMe := false;
  for i := 1 to 15 do
  begin
    if(Player.no[myident[0]].ImgCartes[i] = nil) then continue;
    Player.no[myident[0]].ImgCartes[i].Top := norcarte;
    Player.no[myident[0]].ImgCartes[i].Cursor := crDefault;
  end;
  TopCartes := 0;
  BitBtn1.Visible := false;
  Donner.Visible := false;
  Gauge1.Progress := 0;
  Gauge1.visible := false;
  someone_cant(GetIdent(myident));
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  h, j, i: integer;
begin
  if(Gauge1.Progress >= Gauge1.MaxValue) then
  begin
    Timer1.enabled := false;
    Gauge1.Progress := 0;
    if(IsInChange = true) then
    begin
      if(CartesToPlay > 0) and (TopCartes < CartesToPlay) then
      begin
        for h := TopCartes to CartesToPlay-1 do
        begin
          j := 0;
          for i := 1 to 15 do
          begin
            if(Player.no[myident[0]].Cartes[i] = '') then break;
            if(j = 0) then begin
              if(Player.no[myident[0]].ImgCartes[i].Top = norcarte) then
                j := i;
            end
            else if (GetValeur(Player.no[myident[0]].Cartes[i]) < GetValeur(Player.no[myident[0]].Cartes[j])) and
                    (Player.no[myident[0]].ImgCartes[i].Top = norcarte) then
              j := i;
          end;
          Player.no[myident[0]].ImgCartes[j].Top := selcarte;
          TopCartes := TopCartes + 1;
        end;
      end;
      Donner.OnClick(Sender);
    end
    else
      BitBtn1Click(Sender);
  end
  else
    Gauge1.Progress := Gauge1.Progress + 1;
end;

procedure TForm1.DonnerClick(Sender: TObject);
var
  cards: string;
  i: integer;
  ok: boolean;
  CardList: TStringList;
begin
  if(game <> 2) then exit;
    ok := false;
    CardList := TStringList.Create;
    with Player.no[myident[0]] do
    begin
       for i := 1 to 15 do
       begin
          if(Cartes[i] = '') then break;
          if(ImgCartes[i] = nil) then continue;
          if(ImgCartes[i].Top = selcarte) then
          begin
             if(cards = '') then cards := Cartes[i]
             else cards := cards + ',' + Cartes[i];
             ImgCartes[i].Top := norcarte;
             if(ok = false) then ok := true;
             if IsInChange then ImgCartes[i].OnClick := nil;
          end
          else if IsInChange then
          begin
            CardList.Add(Cartes[i]);
            ImgCartes[i].Cursor := crDefault;
          end;
       end;
       if not ok then
       begin
         Error(ERR_CLIENT, 'DonnerClick(); - Bouton actif et cliqué alors qu''aucune carte' +
                ' n''a été sélectionnée');
         exit;
       end;
       TopCartes := 0;
       IsToMe := false;
       BitBtn1.Visible := false;
       Donner.Visible := false;
       Donner.enabled := false;
       Timer1.Enabled := false;
       Timer2.enabled := false; (* ne devrait pas arriver *)
       Gauge1.Progress := 0;
       Gauge1.visible := false;
       if(IsInChange = true) then
       begin
         sendtoserver('DONNER ' + cards);
         IsInChange := false;
         ChangeMax := false;
         MinCarte := 0;
         CartesToPlay := 4;
         CardList.Sort;
         CardList.Add('');
         affiche_cartes(CardList);
         Statusbar.panels[1].text := 'Vous avez bien donné vos cartes';
       end
       else
         sendtoserver('PLAY ' + cards);
    end;
    CardList.Free;
end;

procedure TForm1.Rglesdujeu1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pchar(WEBSITE + '?p=regles'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  gamelist.Newgame.Checked := true;
  gamelist.ShowModal;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  gamelist.Listgame.Checked := true;
  gamelist.ShowModal;
end;

procedure TForm1.Informationsserveur1Click(Sender: TObject);
begin
  sendtoserver('SERVERINFO');
  serverinfo.showmodal;
end;

procedure TForm1.kickClick(Sender: TObject);
var
  i: integer;
begin
  i := TImage(Sender).Tag;
  if(MessageDlg('Êtes vous sur de vouloir éjecter ' + player.no[i].name.Caption + ' ?',
     mtconfirmation, [mbyes, mbno], 0) = mryes) then
       sendtoserver('KICK ' + Player.no[i].ident)
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if(IsInClose) then begin
    CanClose := true;
    IsInClose := false;
    save_config();
    exit;
  end;
  if(game = 0) or (Messagedlg('Êtes-vous sur de vouloir quitter ? Une partie est en cours',
                        mtconfirmation, [mbyes, mbno], 0) = mryes) then
  begin
   // sendtoserver(MSG_QUIT);
    Connexion.IdTCPClient1Disconnected(Sender);
  end
  else
    CanClose := false;
end;

procedure TForm1.Configurer1Click(Sender: TObject);
begin
  cfg.showmodal;
end;

procedure TForm1.mer2Timer(Sender: TObject);
begin
 BitBtn1Click(Sender);
end;

procedure TForm1.itemregisterClick(Sender: TObject);
begin
  register.showmodal;
end;

procedure TForm1.Envoyerunmessageglobal1Click(Sender: TObject);
var
  s: string;
begin
  s := InputBox('Message global', 'Message à envoyer à tous les joueurs du serveur', '');
  if(s <> '') then  sendtoserver('WALL :' + s);
end;

procedure TForm1.Fermerleserveur1Click(Sender: TObject);
var
  s: string;
begin
  if(Messagedlg('Êtes vous certain de vouloir fermer le serveur ?', mtconfirmation, [mbyes, mbno], 0) = mryes) then
  begin
    s := InputBox('Message de fermeture', 'Message envoyé aux users', '');
    if(s <> '') then  sendtoserver('DIE :' + s);
  end;
end;

procedure TForm1.Listedesusers1Click(Sender: TObject);
begin
  UserList.ShowModal;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  sendtoserver('STOP');
end;

procedure TForm1.Stats1Click(Sender: TObject);
begin
  sendtoserver('STATS SHOW');
  stats_show := true;
  showstats.showmodal;
end;

procedure TForm1.bestscoresClick(Sender: TObject);
begin
  sendtoserver('STATS TOP5');
  stats_top5 := true;
  showstats.ShowModal;
end;

procedure TForm1.envoyerExecute(Sender: TObject);
begin
  if Donner.Enabled and (game = 2) then
    Donner.Click;
end;

procedure TForm1.ClavSelCarte(Sender: TObject);
var
  i, j, k: integer;
begin
  if (game = 2) then
  begin
    i := TAction(Sender).Tag;
    k := 0;
    for j := 1 to 15 do
    begin
      if (Player.no[myident[0]].ImgCartes[j] <> nil) then
        k := k + 1;
      if(k = i) then break;
    end;
    to_play_carte(j);
  end;
end;

procedure TForm1.PeutpasyDistribuerExecute(Sender: TObject);
begin
  if BitBtn1.Enabled and (game = 2) then
    BitBtn1.Click
  else if BitBtn2.Enabled and BitBtn2.Visible and (game = 1) then
    BitBtn2.Click;
end;

procedure TForm1.CreateGameExecute(Sender: TObject);
begin
  if game < 1 then
    SpeedButton1.Click;
end;

procedure TForm1.JoinGameExecute(Sender: TObject);
begin
  if game < 1 then
    SpeedButton2.Click;
end;

procedure TForm1.Listedesprincipauxraccourcis1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pchar(WEBSITE + '?p=trouduk#4'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.PauseExecute(Sender: TObject);
begin
  if speedbutton3.visible and speedbutton3.enabled then
    speedbutton3.click;
end;

procedure TForm1.Action1Execute(Sender: TObject);
var
  s, si, nick: string;
  i, j, k: integer;
begin
  if Msg.Focused and (Msg.Text <> '') then
  begin
    if (Msg.text[Length(Msg.Text)] = ' ') then exit;
    s := Msg.Text;
    si := Msg.text;
    while Pos(' ', s) > 0 do
      strchr(s, ' ');
    j := 0;
    for i := 0 to 3 do
    begin
      if (i = myident[0]) then continue;
      k := Pos(upperCase(s), upperCase(Player.no[i].name.Caption));
      if(k = 1) then
      begin
        nick := Player.no[i].name.caption;
        j := j + 1;
      end;
    end;
    if not (j = 1) then begin Beep; exit; end;
    if(Pos(' ', Msg.Text) > 0) then
      Msg.text := StringReplace(Msg.Text, ' ' + s, ' ' + nick + ' ', [rfReplaceAll])
    else
      Msg.text := StringReplace(Msg.Text, s, nick + ': ', [rfReplaceAll]);
    Msg.SelStart := Length(Msg.Text);
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin  
  Gauge1.Width := Form1.Width - Gauge1.Left - 34;
end;

end.
