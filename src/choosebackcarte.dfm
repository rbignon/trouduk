object takebackcarte: Ttakebackcarte
  Left = 253
  Top = 194
  BorderStyle = bsDialog
  Caption = 'takebackcarte'
  ClientHeight = 262
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object back0: TImage
    Left = 12
    Top = 8
    Width = 69
    Height = 97
    Stretch = True
    OnClick = back0Click
  end
  object back1: TImage
    Tag = 1
    Left = 92
    Top = 8
    Width = 69
    Height = 97
    Stretch = True
    OnClick = back0Click
  end
  object Bevel1: TBevel
    Left = 8
    Top = 116
    Width = 261
    Height = 9
    Shape = bsTopLine
  end
  object Backm1: TImage
    Tag = -1
    Left = 12
    Top = 160
    Width = 69
    Height = 97
    Stretch = True
    Visible = False
    OnClick = back0Click
  end
  object Label1: TLabel
    Left = 20
    Top = 128
    Width = 111
    Height = 13
    Caption = 'Carte depuis un fichier :'
  end
  object Label2: TLabel
    Left = 92
    Top = 188
    Width = 168
    Height = 13
    Caption = 'Note: il est recommand'#233' de prendre'
  end
  object Label3: TLabel
    Left = 92
    Top = 204
    Width = 160
    Height = 13
    Caption = 'une image de taille raisonnable, et'
  end
  object Label4: TLabel
    Left = 92
    Top = 220
    Width = 150
    Height = 13
    Caption = 'qu'#39'elle ait un cadre pour plus de'
  end
  object Label5: TLabel
    Left = 92
    Top = 236
    Width = 35
    Height = 13
    Caption = 'lisibilit'#233'.'
  end
  object Button1: TButton
    Left = 152
    Top = 124
    Width = 75
    Height = 25
    Caption = 'Ouvrir...'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 92
    Top = 160
    Width = 153
    Height = 21
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Title = 'Charger une image'
    Left = 252
    Top = 136
  end
end
