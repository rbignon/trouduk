unit statsshow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  Tshowstats = class(TForm)
    GroupBox1: TGroupBox;
    wait: TImage;
    Button1: TButton;
    Panel1: TPanel;
    nbgames: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pr: TLabel;
    vpr: TLabel;
    vtr: TLabel;
    tr: TLabel;
    score: TLabel;
    SpeedButton1: TSpeedButton;
    GroupBox2: TGroupBox;
    ListStats: TListView;
    procedure FormShow(Sender: TObject);
    procedure GetStats(buf: string);
    procedure StatsReseted;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetTop5(buf: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  showstats: Tshowstats;
  stats_show: boolean = false;
  stats_top5: boolean = false;

implementation

uses
  newgame;

{$R *.dfm}

procedure Tshowstats.StatsReseted;
begin
 sendtoserver('STATS SHOW');
 wait.visible := true;
end;

(* <nick>:<nb parties>:<president>:<vice président>:<vice trou du cul>:<trou du cul>:<score> *)
procedure Tshowstats.GetTop5(buf: string);
var
  s, nbgames: string;
  i: integer;
  grades: array[1..4] of string;
  ListItem: TListItem;
begin
  ListStats.Clear;
  s := strchr(buf, ' ');
  while s <> '' do
  begin
    ListItem := ListStats.Items.Add;
    ListItem.Caption := strchr(s, ':');
    nbgames := strchr(s, ':');
    for i := 1 to 4 do
      grades[i] := strchr(s, ':');

    ListItem.SubItems.Add(strchr(s, ':'));

    for i := 1 to 4 do
      ListItem.SubItems.Add(grades[i] + '/' + nbgames);

    s := strchr(buf, ' ');
  end;
  ListStats.Enabled := true;
end;

(* <nb parties>:<president>:<vice président>:<vice trou du cul>:<trou du cul>:<score>   *)
procedure Tshowstats.GetStats(buf: string);
begin
  nbgames.Caption := 'Nombre de parties :  ' + strchr(buf, ':');
  pr.Caption := strchr(buf, ':');
  vpr.Caption := strchr(buf, ':');
  vtr.Caption := strchr(buf, ':');
  tr.Caption := strchr(buf, ':');
  score.Caption := strchr(buf, ':');
  panel1.Visible := true;
  wait.visible := false;
end;

procedure Tshowstats.FormShow(Sender: TObject);
var
  ListItem: TListItem;
begin
 if stats_show then
 begin
   wait.Visible := true;
   panel1.Visible := false;
   showstats.Caption := 'Statistiques';
   GroupBox1.Caption := 'Statistiques de ' + nickname;
   GroupBox2.Align := alBottom;
   GroupBox1.Align := alTop;
   GroupBox2.Visible := false;
   GroupBox1.Visible := true;
 end
 else if stats_top5 then
 begin
   showstats.Caption := 'Top5';
   GroupBox1.Align := alBottom;
   GroupBox2.Align := alTop;
   GroupBox1.Visible := false;
   GroupBox2.Visible := true;
   ListStats.Clear;
   ListItem := ListStats.Items.Add;
   ListItem.Caption := 'Reception';
   ListStats.Enabled := false;
 end;
end;

procedure Tshowstats.SpeedButton1Click(Sender: TObject);
begin
  if MessageDlg('Êtes-vous sûr ? Cette opération est irréversible !', mtconfirmation, [mbyes, mbno], 0) = mryes then
    sendtoserver('STATS RESET');
end;

procedure Tshowstats.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure Tshowstats.FormCreate(Sender: TObject);
begin
showstats.Height := 230;
end;

procedure Tshowstats.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  stats_top5 := false;
  stats_show := false;
end;

end.
