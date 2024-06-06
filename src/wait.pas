unit wait;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Twaitgame = class(TForm)
    Memo1: TMemo;
    ListBox1: TListBox;
    Panel1: TPanel;
    Edit1: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure wait_part(buf: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wait_user_part(Prefix: string);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure wait_game(buf: string);
  end;

var
  waitgame: Twaitgame;

implementation

uses
  main, newgame, choosegame;

{$R *.dfm}

procedure Twaitgame.wait_user_part(Prefix: string);
var
  i: integer;
begin
 i := ListBox1.Items.IndexOf(Prefix);
 ListBox1.Items.Delete(i);
 Memo1.Lines.Add('*** ' + Prefix + ' a quitté la partie');
end;

procedure Twaitgame.wait_part(buf: string);
begin
  Memo1.Clear;
  Edit1.Text := '';
  ListBox1.Clear;
  waitgame.Close;
  game := 0;
end;

procedure Twaitgame.wait_game(buf: string);
var
   nom, nick: string;
begin
  nom := strchr(buf, ' ');
  Memo1.Lines.Add('*** La partie se joue actuellement. A la fin vous'
                        + ' prendrez la place d''un joueur artificiel');
  Memo1.Lines.Add('*** Vous pouvez patienter en dialogant avec les joueurs');
  Caption := nom + ' - Attente de la fin de la partie...';
  nick := strchr(buf, ' ');
  if(creating = true) then
    Error(ERR_CLIENT, 'wait_game(): Mis en liste d''attente alors qu''il est le createur!');
  while nick <> '' do
  begin
    ListBox1.Items.Add(nick);
    nick := strchr(buf, ' ');
  end;
  game := 3;
end;

procedure Twaitgame.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if (key = #13) and (Edit1.Text <> '') then
begin
  sendtoserver(MSG_MSG + Edit1.Text);
  Memo1.Lines.Add('<' + nickname + '> ' + Edit1.text);
  Edit1.text := '';
end;
end;

procedure Twaitgame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (game = 3) then
    sendtoserver('PART')
  else begin
    Memo1.Clear;
    Edit1.Text := '';
    ListBox1.Clear;
  end;
end;

end.
