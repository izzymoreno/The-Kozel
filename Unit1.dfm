object Form1: TForm1
  Left = 145
  Top = 89
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 640
  Color = clGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonBit: TButton
    Left = 201
    Top = 310
    Width = 73
    Height = 25
    Caption = #1055#1077#1088#1077#1073#1080#1090#1100
    Enabled = False
    TabOrder = 0
    OnClick = ButtonBitClick
  end
  object ButtonSkid: TButton
    Left = 361
    Top = 310
    Width = 73
    Height = 25
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = ButtonSkidClick
  end
  object ButtonXod: TButton
    Left = 281
    Top = 310
    Width = 73
    Height = 25
    Caption = #1055#1086#1093#1086#1076#1080#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = ButtonXodClick
  end
  object MainMenu1: TMainMenu
    object N1: TMenuItem
      Caption = '&'#1048#1075#1088#1072
      object N3: TMenuItem
        Caption = '&'#1053#1086#1074#1072#1103' '#1080#1075#1088#1072
        OnClick = N3Click
      end
      object N6: TMenuItem
        Caption = '&'#1042#1099#1093#1086#1076
        OnClick = N6Click
      end
    end
    object N2: TMenuItem
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      object N4: TMenuItem
        Caption = '&'#1055#1088#1072#1074#1080#1083#1072' '#1080#1075#1088#1099
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N5Click
      end
    end
  end
end
