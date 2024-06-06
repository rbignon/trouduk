object waitgame: Twaitgame
  Left = 399
  Top = 185
  Width = 365
  Height = 317
  Caption = 'Jeu . - En attente de fin de partie'
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
    Top = 0
    Width = 251
    Height = 268
    Align = alClient
    Color = clGreen
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 251
    Top = 0
    Width = 106
    Height = 268
    Align = alRight
    Color = clGreen
    ItemHeight = 13
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 268
    Width = 357
    Height = 22
    Align = alBottom
    TabOrder = 0
    object Edit1: TEdit
      Left = 0
      Top = 0
      Width = 357
      Height = 21
      Color = clGreen
      MaxLength = 300
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
  end
end
