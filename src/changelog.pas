unit changelog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TChanges = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel2: TPanel;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure show_changelog();
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Changes: TChanges;

implementation

uses
  newgame, config, update;

{$R *.dfm}

procedure TChanges.show_changelog();
var
  i: integer;
begin
  if(conf.progversion < PROTO_VERSION) then
  begin
    Changes.memo1.lines.add('*** Changements depuis la version ' + PATCH_LEVEL[conf.progversion] + sLineBreak);
    for i := 1 to PROTO_VERSION do
      if(conf.progversion < i) and (PATCH_CHANGES[i] <> '') then
      begin
        changes.memo1.lines.add('* Nouvelles fonctionnalités de la version ' + PATCH_LEVEL[i]);
        Changes.memo1.Lines.Add(PATCH_CHANGES[i] + sLineBreak);
      end;
    Changes.Memo1.lines.add('*** Pour plus d''informations veuillez lire le fichier ChangeLog.txt' +
                            sLineBreak + '*** Site Internet : ' +
                            WEBSITE + sLineBreak);
    Changes.memo1.lines.add('Bon jeu !' + sLineBreak + sLineBreak + 'Progs');
    if(Changes.showing = false) then Changes.ShowModal;
  end;
end;

procedure TChanges.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TChanges.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Memo1.Lines.Clear;
  conf.progversion := PROTO_VERSION;
end;

procedure TChanges.Button2Click(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(DIR + CHANGELOG_FILE);
end;

procedure TChanges.Button3Click(Sender: TObject);
begin
  Memo1.lines.LoadFromFile(DIR + TODO_FILE);
end;

procedure TChanges.Button4Click(Sender: TObject);
begin
  Memo1.Lines.clear;
  show_changelog();
end;

procedure TChanges.Button5Click(Sender: TObject);
begin
  Memo1.Lines.clear;
  Memo1.Lines.Add('AVIS AUX UTILISATEURS !!' + sLineBreak +
                  sLineBreak +
                  'Il existe dans le jeu un bug sur lequel je n''ai pas encore' +
                  ' réussi à mettre la main. Il s''agit de la disparition de cartes' +
                  ' de votre jeu. Si cela vous arrive, veuillez faire une screen shot' +
                  ' (Impr. Ecran. puis coller dans Paint) et veuillez me l''envoyer par' +
                  ' mail (voir à propos), puis fermer complètement l''application et relancez la.' + sLineBreak +
                  'Ceci permettrait de trouver ce bug et de le corriger.' + sLineBreak +
                  sLineBreak +
                  'Merci bien');
end;

end.
