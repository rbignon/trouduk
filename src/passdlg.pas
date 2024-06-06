unit passdlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, Dialogs;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
    procedure PasswordChange(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordDlg: TPasswordDlg;
  IsLoginPass: boolean = false;
  IsJoinPass: boolean = false;
  WantPass: boolean = false;
  PassGame: string;

implementation

uses
  newgame, choosegame, config;

{$R *.dfm}

procedure TPasswordDlg.OKBtnClick(Sender: TObject);
begin
  if(IsJoinPass) then
  begin
    sendtoserver(MSG_JOIN + PassGame + ' :' + Password.Text);
    joining := true;
    OKBtn.Enabled := false
  end else begin
    if (Length(Password.text) < 8) or (Pos(' ', Password.text) > 0) then
      MessageDlg('Le mot de passe doit être de 8 caractères minimum de ne pas contenir d''espaces', mterror, [mbok], 0)
    else begin
      sendtoserver('AUTH ' + Password.text);
      OKBtn.Enabled := false;
      if Checkbox1.Checked then
        conf.pass := Password.text;
    end;
  end;
end;

procedure TPasswordDlg.PasswordChange(Sender: TObject);
begin
  if(Password.Text <> '') then OkBtn.Enabled := true
  else OkBtn.Enabled := false;
end;

procedure TPasswordDlg.CancelBtnClick(Sender: TObject);
begin
  if IsLoginPass then
    Connexion.IdTCPClient1Disconnected(Sender);
  WantPass := false;
  IsLoginPass := false;
  IsJoinPass := false;
  PassGame := '';
  Close;
end;

procedure TPasswordDlg.FormShow(Sender: TObject);
begin
  OKBtn.Enabled := true;
  if IsLoginPass then
  begin
    Label2.Caption := 'Le pseudo ' + nickname + ' est enregistré !';
    Label1.Caption := 'Veuillez saisir le mot de passe :';
    Checkbox1.Visible := true;
  end
  else
  begin
    Label2.Caption := 'Le jeu choisi requiert un mot de passe.';
    Label1.Caption := 'Veuillez le saisir :';
    Checkbox1.Visible := false;
  end;
end;

end.
 
