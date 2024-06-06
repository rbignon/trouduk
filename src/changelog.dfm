object Changes: TChanges
  Left = 257
  Top = 161
  BorderStyle = bsDialog
  Caption = 'Changes'
  ClientHeight = 345
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 31
    Width = 505
    Height = 281
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 312
    Width = 505
    Height = 33
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 424
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Fermer'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 4
      Top = 4
      Width = 147
      Height = 25
      Caption = 'Afficher le fichier changelog'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 152
      Top = 4
      Width = 149
      Height = 25
      Caption = 'Afficher le fichier TODO'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 302
      Top = 4
      Width = 121
      Height = 25
      Caption = 'Changements majeurs'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 505
    Height = 31
    Align = alTop
    TabOrder = 2
    object Button5: TButton
      Left = 6
      Top = 2
      Width = 487
      Height = 25
      Caption = '!! A LIRE !! - CLIQUEZ ICI'
      TabOrder = 0
      OnClick = Button5Click
    end
  end
end
