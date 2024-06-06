unit listusers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls;

type
  Tuserlist = class(TForm)
    ListView1: TListView;
    actualiser: TBitBtn;
    fermer: TBitBtn;
    kill: TButton;
    procedure actualiserClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure fermerClick(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListView1Changing(Sender: TObject; Item: TListItem;
      Change: TItemChange; var AllowChange: Boolean);
    procedure ListView1Click(Sender: TObject);
    procedure killClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  userlist: Tuserlist;
  showuserlist: boolean = false;
  waituserlist: boolean = false;

procedure AddUserList(nom: string; status: integer; grade: integer; game: string);

implementation

uses newgame;

{$R *.dfm}

procedure UpdateUserlist;
var
  anItem: TListItem;
begin
  sendtoserver('USERLIST');
  showuserlist := true;
  waituserlist := true;
  UserList.ListView1.Items.Clear;
  anItem := UserList.ListView1.Items.Add;
  anItem.caption := 'Réception';
  UserList.ListView1.Enabled := false;
  UserList.Kill.Enabled := false;
end;

// Il est à noter que "libre" est en fait le nombre d'users (changement de dernière minute)
procedure AddUserList(nom: string; status: integer; grade: integer; game: string);
var
  ListItem: TListItem;
begin
  if(showuserlist = false) then exit;

  if waituserlist then
  begin
    waituserlist := false;
    UserList.ListView1.Clear;
  end;

  ListItem := Userlist.ListView1.Items.Add;
  ListItem.Caption := nom;
  if(status = 0) then ListItem.SubItems.Add('Anonyme')
  else if(status = 1) then ListItem.SubItems.Add('User')
  else if(status = 2) then ListItem.SubItems.Add('Admin')
  else ListItem.SubItems.Add('Unknow');
  if(grade = -1) then ListItem.SubItems.Add('non')
  else
  begin
   ListItem.SubItems.Add('oui');
   ListItem.SubItems.Add(game);
   if(grade = 0) then ListItem.SubItems.Add('Neutre')
   else if(grade = 1) then ListItem.SubItems.Add('Président')
   else if(grade = 2) then ListItem.SubItems.Add('Vice président')
   else if(grade = 3) then ListItem.SubItems.Add('Vice trou du cul')
   else ListItem.SubItems.Add('Trou du cul');
  end;
end;

procedure Tuserlist.actualiserClick(Sender: TObject);
begin
  UpdateUserList;
end;

procedure Tuserlist.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure Tuserlist.fermerClick(Sender: TObject);
begin
 Close;
end;

procedure Tuserlist.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if(ListView1.ItemIndex = -1) then Kill.Enabled := false
  else kill.Enabled := true;
end;

procedure Tuserlist.ListView1Changing(Sender: TObject; Item: TListItem;
  Change: TItemChange; var AllowChange: Boolean);
begin
  if(ListView1.ItemIndex = -1) then Kill.Enabled := false
  else kill.Enabled := true;
end;

procedure Tuserlist.ListView1Click(Sender: TObject);
begin
  if(ListView1.ItemIndex = -1) then Kill.Enabled := false
  else kill.Enabled := true;
end;

procedure Tuserlist.killClick(Sender: TObject);
var
  s: string;
begin
  if(ListView1.ItemIndex = -1) then
    MessageDlg('Aucun user sélectionné', mterror, [mbok], 0)
  else begin
    s := InputBox('Kill de ' + ListView1.Items.Item[ListView1.itemindex].Caption, 'Raison du kill', '');
    if(s <> '') then
      sendtoserver('KILL ' + ListView1.Items.Item[ListView1.itemindex].Caption + ' :' + s);
    UpdateUserList;
  end;
end;

procedure Tuserlist.FormShow(Sender: TObject);
begin
  UpdateUserList;
end;

end.
