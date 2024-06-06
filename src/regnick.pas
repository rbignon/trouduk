unit regnick;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask;

type
  Tregister = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    mail: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    nick: TLabeledEdit;
    Label3: TLabel;
    pass: TMaskEdit;
    Label4: TLabel;
    spass: TMaskEdit;
    CheckBox1: TCheckBox;
    procedure mailChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  register: Tregister;
  IsRegPass: boolean = false;

implementation

uses
  newgame, config;

{$R *.dfm}

procedure Tregister.mailChange(Sender: TObject);
begin
  if(mail.Text <> '') and (pass.Text <> '') and (spass.text <> '') then
    Button2.Enabled := true
  else
    Button2.Enabled := false;
end;

procedure Tregister.Button2Click(Sender: TObject);
begin
  if(Pos(' ', pass.text) > 0) or (Length(pass.text) < 8) then
    MessageDlg('Le mot de passe ne doit pas contenir d''espace et faire entre 8 et 15 caractères',
      mterror, [mbok], 0)
  else if(pass.text <> spass.Text) then
    MessageDlg('Les deux mots de passe sont différents', mterror, [mbok], 0)
  else if(Pos('@', mail.Text) = 0) or (Pos('.', mail.text) = 0) or (Pos(' ', mail.Text) > 0) then
    MessageDlg('Adresse e-mail incorrecte.', mterror, [mbok], 0)
  else begin
    sendtoserver('REGISTER ' + mail.Text + ' ' + pass.Text);
    Button2.enabled := false;
    if Checkbox1.Checked then
      conf.pass := pass.text;
  end;
end;

procedure Tregister.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure Tregister.FormShow(Sender: TObject);
begin
  mail.Text := '';
  pass.Text := '';
  Button2.Enabled := false;
  IsRegPass := true;
  nick.Text := nickname;
end;

end.
