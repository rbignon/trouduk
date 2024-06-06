object register: Tregister
  Left = 330
  Top = 211
  BorderStyle = bsDialog
  Caption = 'Enregistrement de votre pseudo'
  ClientHeight = 232
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 183
    Height = 13
    Caption = 'L'#39'enregistrement de votre pseudo vous'
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 192
    Height = 13
    Caption = 'permet la sauvegarde de vos statistiques'
  end
  object Label3: TLabel
    Left = 20
    Top = 128
    Width = 67
    Height = 13
    Caption = 'Mot de passe:'
  end
  object Label4: TLabel
    Left = 24
    Top = 152
    Width = 64
    Height = 13
    Caption = 'Confirmation :'
  end
  object mail: TLabeledEdit
    Left = 20
    Top = 100
    Width = 185
    Height = 21
    EditLabel.Width = 133
    EditLabel.Height = 13
    EditLabel.Caption = 'Entrez votre adresse e-mail :'
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 1
    OnChange = mailChange
  end
  object Button1: TButton
    Left = 140
    Top = 200
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 60
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Cr'#233'er'
    Enabled = False
    TabOrder = 6
    OnClick = Button2Click
  end
  object nick: TLabeledEdit
    Left = 20
    Top = 60
    Width = 121
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Pseudo :'
    Enabled = False
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 0
  end
  object pass: TMaskEdit
    Left = 92
    Top = 124
    Width = 113
    Height = 21
    MaxLength = 15
    PasswordChar = '*'
    TabOrder = 2
    OnChange = mailChange
  end
  object spass: TMaskEdit
    Left = 92
    Top = 148
    Width = 113
    Height = 21
    MaxLength = 15
    PasswordChar = '*'
    TabOrder = 3
    OnChange = mailChange
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 176
    Width = 205
    Height = 17
    Caption = 'Se souvenir du mot de passe'
    TabOrder = 4
  end
end
