unit anerror;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi;

type
  TErreur = class(TForm)
    Label1: TLabel;
    msg: TMemo;
    Label2: TLabel;
    errorfile: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Erreur: TErreur;

implementation

uses
  newgame;

{$R *.dfm}

procedure TErreur.FormClose(Sender: TObject; var Action: TCloseAction);
begin
msg.Lines.Clear;
end;

procedure TErreur.FormCreate(Sender: TObject);
begin
 errorfile.Caption := ERROR_FILE;
end;

procedure TErreur.Button1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pchar(WEBMAIL + '?subject=Erreurs Trouduk'), nil, nil, SW_SHOWNORMAL);
  Close;
end;

procedure TErreur.Button2Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pchar(ERROR_SITE), nil, nil, SW_SHOWNORMAL);
  Close;
end;

procedure TErreur.Button3Click(Sender: TObject);
begin
  if(MessageDlg('Êtes vous certain de ne pas vouloir signaler l''erreur ? Ceci ' +
  	'permettrait de la corriger...', mtconfirmation, [mbyes, mbno], 0) = mryes) then
  	Close;
end;

end.
