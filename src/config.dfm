object cfg: Tcfg
  Left = 232
  Top = 121
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 357
  ClientWidth = 369
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 369
    Height = 324
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Couleurs'
      OnShow = TabSheet1Show
      object Label2: TLabel
        Left = 16
        Top = 12
        Width = 283
        Height = 13
        Caption = 'Cliquez sur la partie dont vous souhaitez modifier la couleur :'
      end
      object backcolor: TPanel
        Left = 28
        Top = 32
        Width = 293
        Height = 241
        BevelOuter = bvLowered
        TabOrder = 0
        OnClick = backcolorClick
        object frontcolor: TLabel
          Left = 212
          Top = 12
          Width = 32
          Height = 13
          Caption = 'Textes'
          OnClick = frontcolorClick
        end
        object fontpresident: TLabel
          Left = 112
          Top = 8
          Width = 44
          Height = 13
          Caption = 'Pr'#233'sident'
          OnClick = fontpresidentClick
        end
        object fontvpresident: TLabel
          Left = 212
          Top = 52
          Width = 67
          Height = 13
          Caption = 'Vice pr'#233'sident'
          OnClick = fontvpresidentClick
        end
        object fontvtrouduk: TLabel
          Left = 8
          Top = 52
          Width = 74
          Height = 13
          Caption = 'Vice trou du cul'
          OnClick = fontvtroudukClick
        end
        object fonttrouduk: TLabel
          Left = 112
          Top = 136
          Width = 54
          Height = 13
          Caption = 'Trou du cul'
          OnClick = fonttroudukClick
        end
        object Image1: TImage
          Left = 220
          Top = 68
          Width = 45
          Height = 69
          Stretch = True
          OnClick = Image3Click
        end
        object Image23: TImage
          Left = 112
          Top = 156
          Width = 45
          Height = 69
          Stretch = True
        end
        object Image33: TImage
          Left = 120
          Top = 156
          Width = 45
          Height = 69
          Stretch = True
        end
        object Image4: TImage
          Left = 12
          Top = 68
          Width = 45
          Height = 69
          Stretch = True
          OnClick = Image3Click
        end
        object Image5: TImage
          Left = 12
          Top = 76
          Width = 45
          Height = 69
          Stretch = True
          OnClick = Image3Click
        end
        object Image2: TImage
          Left = 220
          Top = 76
          Width = 45
          Height = 69
          Stretch = True
          OnClick = Image3Click
        end
        object Image6: TImage
          Left = 108
          Top = 24
          Width = 45
          Height = 69
          Stretch = True
          OnClick = Image3Click
        end
        object Image3: TImage
          Left = 116
          Top = 24
          Width = 45
          Height = 69
          Stretch = True
          OnClick = Image3Click
        end
        object Panel2: TPanel
          Left = 8
          Top = 168
          Width = 65
          Height = 61
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          OnClick = backcolorClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Jeu'
      ImageIndex = 1
      OnShow = TabSheet2Show
      object RadioGroup1: TRadioGroup
        Left = 4
        Top = 4
        Width = 145
        Height = 101
        Caption = 'Vitesse d'#39'animation'
        TabOrder = 0
      end
      object alente: TRadioButton
        Left = 20
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Lente'
        TabOrder = 1
        OnClick = alenteClick
      end
      object anormale: TRadioButton
        Left = 20
        Top = 48
        Width = 113
        Height = 17
        Caption = 'Normale'
        TabOrder = 2
        OnClick = alenteClick
      end
      object arapide: TRadioButton
        Left = 20
        Top = 72
        Width = 113
        Height = 17
        Caption = 'Rapide'
        TabOrder = 3
        OnClick = alenteClick
      end
      object nowaitcant: TCheckBox
        Left = 4
        Top = 112
        Width = 353
        Height = 21
        Caption = 
          'Si il est impossible de contrer, ne pas attendre de dire qu'#39'on p' +
          'eut pas'
        TabOrder = 4
        OnClick = nowaitcantClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 324
    Width = 369
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 140
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Fermer'
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 332
    Top = 28
  end
end
