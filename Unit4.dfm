object Form4: TForm4
  Left = 266
  Top = 149
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'О программе'
  ClientHeight = 204
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 331
    Height = 167
    Align = alTop
    Alignment = taCenter
    BorderStyle = bsNone
    Color = clWhite
    Lines.Strings = (
      'Карточная игра "Козёл". '
      'Демо версия 1.2  распространяется бесплатно.'
      'Программист: Баженов Александр Владимирович'
      'Технический консультант: Баженов Андрей Владимирович '
      'Полная версия будет поддерживать игру по сети. '
      '(её стоимость пока неопределена).'
      'По всем интересующем вопросом обращаться:'
      ''
      'Mail: Izzy@mail.ru или neyrospace@hotbox.ru.'
      'Site: http://neyrospace.hotbox.ru'
      ''
      'Санкт-Петербург 25.09.2002 г.')
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 224
    Top = 174
    Width = 86
    Height = 25
    Caption = 'Закрыть'
    ModalResult = 1
    TabOrder = 1
  end
end
