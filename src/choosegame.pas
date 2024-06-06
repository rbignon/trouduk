unit choosegame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, Spin, ExtCtrls, Mask, ImgList;

type
  Tgamelist = class(TForm)
    Newgame: TRadioButton;
    Listgame: TRadioButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    actualiser: TBitBtn;
    join: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    gamename: TLabeledEdit;
    reflextime: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    ListView1: TListView;
    ImageList1: TImageList;
    Timer1: TTimer;
    needpass: TCheckBox;
    Password: TEdit;
    IASpeak: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure NewgameClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure actualiserClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure joinClick(Sender: TObject);
    procedure gamenameChange(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListView1Click(Sender: TObject);
    procedure ListView1Changing(Sender: TObject; Item: TListItem;
      Change: TItemChange; var AllowChange: Boolean);
    procedure needpassClick(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  gamelist: Tgamelist;
  showgamelist: boolean = false;
  waitgamelist: boolean = false;
  creating: boolean = false;
  joining: boolean = false;

procedure AddGameList(nom: string; gamers: string; libres: integer; ingame: boolean; nbcartes: integer);

implementation

uses
  newgame, config;

{$R *.dfm}

procedure UpdateGamelist;
var
  anItem: TListItem;
begin
  sendtoserver(MSG_LIST);
  showgamelist := true;
  waitgamelist := true;
  GameList.ListView1.Items.Clear;
  anItem := GameList.ListView1.Items.Add;
  anItem.caption := 'Réception';
  anItem.ImageIndex := -1;
  GameList.ListView1.Enabled := false;
  GameList.join.Enabled := False;
end;

// Il est à noter que "libre" est en fait le nombre d'users (changement de dernière minute)
procedure AddGameList(nom: string; gamers: string; libres: integer; ingame: boolean; nbcartes: integer);
var
  ListItem: TListItem;
begin
  if(showgamelist = false) then exit;

  if waitgamelist then
  begin
    waitgamelist := false;
    GameList.ListView1.Clear;
  end;

  ListItem := Gamelist.ListView1.Items.Add;
  ListItem.Caption := nom;
  if(nbcartes = 1) then ListItem.SubItems.Add('52 C')
  else ListItem.SubItems.Add('32 C');
  if(ingame = true) then
  begin
        ListItem.SubItems.Add('En jeu');
        ListItem.ImageIndex := 2;
  end
  else begin
        ListItem.SubItems.Add('Stop');
        ListItem.ImageIndex := 1;
  end;
  if(libres >= 4) then ListItem.ImageIndex := 0;
  ListItem.SubItems.Add(IntToStr(libres) + '/4');
  ListItem.SubItems.Add(gamers);
end;

procedure Tgamelist.FormCreate(Sender: TObject);
begin
Height := 339;
if conf.def_52C then
  RadioButton2.Checked := true;
end;

procedure Tgamelist.NewgameClick(Sender: TObject);
begin
  if(Newgame.Checked = true) then
  begin
    GroupBox1.Visible := True;
    GroupBox1.Top := 48;
    GroupBox2.Visible := False;
    GroupBox2.Top := 316;
    Timer1.Enabled := false;
  end
  else if(Listgame.Checked = true) then
  begin
    GroupBox2.Visible := True;
    GroupBox2.Top := 48;
    GroupBox1.Visible := False;
    GroupBox1.Top := 316;
    UpdateGamelist;
    Timer1.Enabled := true;
  end;
end;

procedure Tgamelist.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure Tgamelist.actualiserClick(Sender: TObject);
begin
UpdateGameList;
end;

procedure Tgamelist.Timer1Timer(Sender: TObject);
begin
UpdateGameList;
end;

procedure Tgamelist.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Timer1.Enabled := false;
newgame.Checked := false;
listgame.Checked := false;
GroupBox1.Visible := false;
GroupBox2.Visible := false;
password.Text := '';
needpass.Checked := false;
password.Enabled := false;
gamename.Text := '';
reflextime.Value := 20;
ListView1.Clear;
end;

procedure Tgamelist.BitBtn3Click(Sender: TObject);
var
  s: string;
  i, j: integer;
begin
  s := gamename.text;
  while Pos(' ', S) > 0 do
    S[Pos(' ', S)] := '_';
  if IaSpeak.Checked then
    i := 1
  else
    i := 0;
  if RadioButton1.Checked then j := 0
  else j := 1;
if(needpass.Checked = true) then
  sendtoserver(MSG_CREATE + S + ' ' + IntToStr(reflextime.value) + ' ' + IntToStr(i) + ' ' + IntToStr(j) + ' :' + password.Text)
else
  sendtoserver(MSG_CREATE + S + ' ' + IntToStr(reflextime.Value) + ' ' + IntToStr(i) + ' ' + IntToStr(j));
creating := true;
BitBtn3.Enabled := false;
conf.def_52c := RadioButton2.checked;
end;

procedure Tgamelist.joinClick(Sender: TObject);
begin
sendtoserver(MSG_JOIN + ListView1.Items.Item[ListView1.ItemIndex].Caption);
joining := true;
BitBtn3.Enabled := false;
end;

procedure Tgamelist.gamenameChange(Sender: TObject);
begin
  if(gamename.Text <> '') and ((needpass.Checked = false) or (password.Text <> '')) then
    BitBtn3.Enabled := true
  else BitBtn3.Enabled := false; 
end;

procedure Tgamelist.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if(ListView1.ItemIndex = -1) or (ListView1.Items.Item[ListView1.ItemIndex].ImageIndex = 0) then join.Enabled := false
  else join.Enabled := true;
end;

procedure Tgamelist.ListView1Click(Sender: TObject);
begin
  if(ListView1.ItemIndex = -1) or (ListView1.Items.Item[ListView1.ItemIndex].ImageIndex = 0) then join.Enabled := false
  else join.Enabled := true;
end;

procedure Tgamelist.ListView1Changing(Sender: TObject; Item: TListItem;
  Change: TItemChange; var AllowChange: Boolean);
begin
  if(ListView1.ItemIndex = -1) or (ListView1.Items.Item[ListView1.ItemIndex].ImageIndex = 0) then join.Enabled := false
  else join.Enabled := true;
end;

procedure Tgamelist.needpassClick(Sender: TObject);
begin
  if(needpass.Checked = true) then
  begin
    if((password.text = '') or (gamename.Text = '')) then
      BitBtn3.Enabled := false
    else BitBtn3.Enabled := true;
    Password.Enabled := true;
  end
  else begin
    if(gamename.Text = '') then
      BitBtn3.Enabled := false
    else BitBtn3.Enabled := true;
    Password.Enabled := false;
  end;
end;

procedure Tgamelist.ListView1DblClick(Sender: TObject);
begin
  if(ListView1.ItemIndex <> -1) and (ListView1.Items.Item[ListView1.ItemIndex].ImageIndex <> 0) then
    join.OnClick(Sender);
end;

end.
