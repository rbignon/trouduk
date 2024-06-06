object Connexion: TConnexion
  Left = 533
  Top = 360
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Connexion au serveur'
  ClientHeight = 192
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 12
    Top = 160
    Width = 253
    Height = 20
    MaxValue = 5
    Progress = 0
  end
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 36
    Height = 13
    Caption = 'Pseudo'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 124
    Width = 253
    Height = 5
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 36
    Top = 136
    Width = 59
    Height = 13
    Caption = 'D'#233'connect'#233
  end
  object SpeedButton1: TSpeedButton
    Left = 220
    Top = 36
    Width = 23
    Height = 22
    AllowAllUp = True
    Caption = '+'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Button1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 244
    Top = 36
    Width = 23
    Height = 22
    AllowAllUp = True
    Caption = '-'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Button2Click
  end
  object ServerList: TComboBox
    Left = 16
    Top = 60
    Width = 253
    Height = 19
    Style = csOwnerDrawVariable
    Enabled = False
    ItemHeight = 13
    TabOrder = 2
    OnChange = ServerListChange
  end
  object ToConnect: TBitBtn
    Left = 108
    Top = 88
    Width = 81
    Height = 25
    Caption = 'Connecter'
    Default = True
    Enabled = False
    TabOrder = 3
    OnClick = ToConnectClick
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 192
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Quitter'
    TabOrder = 4
    OnClick = BitBtn2Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object login: TEdit
    Left = 52
    Top = 8
    Width = 141
    Height = 21
    MaxLength = 15
    TabOrder = 0
    OnChange = loginChange
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 36
    Width = 205
    Height = 17
    Caption = 'Serveur par default (Inter System)'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object IdTCPClient1: TIdTCPClient
    OnDisconnected = IdTCPClient1Disconnected
    OnConnected = IdTCPClient1Connected
    Port = 0
    Left = 208
    Top = 128
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 240
    Top = 128
  end
end
