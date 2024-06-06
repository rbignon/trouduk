object upgrade: Tupgrade
  Left = 353
  Top = 227
  BorderStyle = bsDialog
  Caption = 'Mise '#224' jour du trou du cul...'
  ClientHeight = 135
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge: TGauge
    Left = 4
    Top = 64
    Width = 325
    Height = 24
    Progress = 0
    Visible = False
  end
  object etat: TLabel
    Left = 52
    Top = 8
    Width = 19
    Height = 13
    Caption = 'Etat'
  end
  object Label1: TLabel
    Left = 4
    Top = 44
    Width = 58
    Height = 13
    Caption = 'Progression:'
    Visible = False
  end
  object filename: TLabel
    Left = 96
    Top = 44
    Width = 39
    Height = 13
    Caption = 'filename'
    Visible = False
  end
  object Gauge1: TGauge
    Left = 4
    Top = 96
    Width = 325
    Height = 24
    MaxValue = 4
    Progress = 0
    Visible = False
  end
  object NMHTTP1: TNMHTTP
    Host = 'kouak.org'
    Port = 0
    ReportLevel = 0
    OnDisconnect = NMHTTP1Disconnect
    OnConnect = NMHTTP1Connect
    OnConnectionFailed = NMHTTP1ConnectionFailed
    OnPacketRecvd = NMHTTP1PacketRecvd
    Body = 'trouduk.patch'
    Header = 'Head.txt'
    InputFileMode = True
    OutputFileMode = False
    ProxyPort = 0
    Left = 260
    Top = 20
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 180
    Top = 4
  end
end
