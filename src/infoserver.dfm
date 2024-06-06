object serverinfo: Tserverinfo
  Left = 198
  Top = 106
  BorderStyle = bsDialog
  Caption = 'Informations serveur...'
  ClientHeight = 177
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 254
    Height = 141
    Align = alTop
    Caption = 'Informations serveur'
    TabOrder = 0
    object version: TLabel
      Left = 12
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Version :'
    end
    object CONact: TLabel
      Left = 12
      Top = 44
      Width = 38
      Height = 13
      Caption = 'CONact'
    end
    object CONtotal: TLabel
      Left = 12
      Top = 60
      Width = 43
      Height = 13
      Caption = 'CONtotal'
    end
    object Label3: TLabel
      Left = 12
      Top = 96
      Width = 136
      Height = 13
      Caption = 'Le serveur est lanc'#233' depuis :'
    end
    object uptime: TLabel
      Left = 12
      Top = 112
      Width = 31
      Height = 13
      Caption = 'uptime'
    end
    object wait: TImage
      Left = 204
      Top = 12
      Width = 16
      Height = 17
      Picture.Data = {
        07544269746D617076010000424D760100000000000076000000280000002000
        000010000000010004000000000000010000120B0000120B0000100000000000
        0000000000000000800000800000008080008000000080008000808000007F7F
        7F00BFBFBF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF003333333333333333333333FFFFF3333333333000003333333333F77777FF
        F3333330099999003333333777777777FF33330998FFF899033333777333F377
        7FF33099FFFCFFF9903337773337333777F3309FFFFFFFCF9033377333F33373
        77FF098FF0FFFFFF890377F3373F3333377F09FFFF0FFFFFF90377F3F373FFFF
        F77F09FCFFF90000F90377F733377777377F09FFFFFFFFFFF90377F333333333
        377F098FFFFFFFFF890377FF3F33333F3773309FCFFFFFCF9033377F7333F373
        77F33099FFFCFFF990333777FF37F3377733330998FCF899033333777FF7FF77
        7333333009999900333333377777777733333333300000333333333337777733
        3333}
      Transparent = True
      Visible = False
    end
    object GAMEtotal: TLabel
      Left = 12
      Top = 76
      Width = 51
      Height = 13
      Caption = 'GAMEtotal'
    end
  end
  object Button1: TButton
    Left = 96
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Fermer'
    TabOrder = 1
    OnClick = Button1Click
  end
end
