object showstats: Tshowstats
  Left = 371
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Statistiques'
  ClientHeight = 404
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 351
    Height = 165
    Align = alTop
    Caption = 'Statistiques de l'#39'user '
    TabOrder = 0
    object wait: TImage
      Left = 320
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
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 132
      Width = 333
      Height = 25
      Caption = 'R'#233'initialiser les stats'
      Flat = True
      OnClick = SpeedButton1Click
    end
    object Panel1: TPanel
      Left = 8
      Top = 20
      Width = 237
      Height = 109
      BevelOuter = bvNone
      TabOrder = 0
      object nbgames: TLabel
        Left = 8
        Top = 8
        Width = 92
        Height = 13
        Caption = 'Nombre de parties :'
      end
      object Label1: TLabel
        Left = 52
        Top = 28
        Width = 50
        Height = 13
        Caption = 'Pr'#233'sident :'
      end
      object Label2: TLabel
        Left = 28
        Top = 40
        Width = 73
        Height = 13
        Caption = 'Vice pr'#233'sident :'
      end
      object Label3: TLabel
        Left = 20
        Top = 52
        Width = 80
        Height = 13
        Caption = 'Vice trou du cul :'
      end
      object Label4: TLabel
        Left = 40
        Top = 64
        Width = 60
        Height = 13
        Caption = 'Trou du cul :'
      end
      object Label5: TLabel
        Left = 40
        Top = 84
        Width = 57
        Height = 13
        Caption = 'Score total :'
      end
      object pr: TLabel
        Left = 108
        Top = 28
        Width = 9
        Height = 13
        Caption = 'pr'
      end
      object vpr: TLabel
        Left = 108
        Top = 40
        Width = 15
        Height = 13
        Caption = 'vpr'
      end
      object vtr: TLabel
        Left = 108
        Top = 52
        Width = 12
        Height = 13
        Caption = 'vtr'
      end
      object tr: TLabel
        Left = 108
        Top = 64
        Width = 6
        Height = 13
        Caption = 'tr'
      end
      object score: TLabel
        Left = 108
        Top = 80
        Width = 33
        Height = 18
        Caption = '000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object Button1: TButton
    Left = 136
    Top = 172
    Width = 75
    Height = 25
    Caption = 'Fermer'
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 239
    Width = 351
    Height = 165
    Align = alBottom
    Caption = 'Classement, les 5 meilleurs'
    TabOrder = 2
    object ListStats: TListView
      Left = 2
      Top = 15
      Width = 347
      Height = 148
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Columns = <
        item
          Caption = 'Pseudo'
          Width = 70
        end
        item
          Caption = 'Score'
        end
        item
          Caption = 'Pr'#233'sident'
          Width = 55
        end
        item
          Caption = 'Vice pr'#233'sident'
          Width = 55
        end
        item
          Caption = 'Vice trou du cul'
          Width = 55
        end
        item
          Caption = 'Trou du cul'
          Width = 55
        end>
      FlatScrollBars = True
      ReadOnly = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
