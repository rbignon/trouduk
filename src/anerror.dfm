object Erreur: TErreur
  Left = 239
  Top = 154
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Erreur grave'
  ClientHeight = 246
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 165
    Height = 13
    Caption = 'L'#39'erreur suivante '#224' '#233't'#233' rencontr'#233'e :'
  end
  object Label2: TLabel
    Left = 8
    Top = 108
    Width = 174
    Height = 13
    Caption = 'L'#39'erreur a '#233't'#233' stock'#233'e dans le fichier '
  end
  object errorfile: TLabel
    Left = 184
    Top = 108
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 8
    Top = 128
    Width = 235
    Height = 13
    Caption = 'Veuillez faire le rapport de cette erreur pour qu'#39'elle'
  end
  object Label4: TLabel
    Left = 8
    Top = 144
    Width = 151
    Height = 13
    Caption = 'puisse '#234'tre localis'#233'e et corrig'#233'e.'
  end
  object msg: TMemo
    Left = 20
    Top = 32
    Width = 209
    Height = 61
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 168
    Width = 233
    Height = 25
    Caption = 'Envoyer par mail'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 196
    Width = 233
    Height = 25
    Caption = 'Page WEB du rapport de bugs'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 224
    Width = 233
    Height = 17
    Caption = 'Ne rien faire'
    TabOrder = 2
    OnClick = Button3Click
  end
end
