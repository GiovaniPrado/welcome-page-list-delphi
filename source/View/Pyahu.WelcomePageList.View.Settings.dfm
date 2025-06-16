object FormSettings: TFormSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 380
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object groupBoxImages: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 99
    Width = 376
    Height = 226
    Align = alClient
    Caption = 'Images'
    TabOrder = 1
  end
  object groupBoxDefaultValues: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 376
    Height = 90
    Align = alTop
    Caption = 'Default values'
    TabOrder = 0
    object panelGroupDefatulValues: TPanel
      AlignWithMargins = True
      Left = 2
      Top = 27
      Width = 372
      Height = 61
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 0
      object labelItemsOrder: TLabel
        Left = 10
        Top = 10
        Width = 60
        Height = 15
        Caption = 'Items order'
      end
      object comboBoxItemsOrder: TComboBox
        Left = 10
        Top = 31
        Width = 55
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Asc'
        Items.Strings = (
          'Asc'
          'Dec')
      end
    end
  end
  object panelButtons: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 331
    Width = 376
    Height = 46
    Align = alBottom
    TabOrder = 2
    object buttonClose: TButton
      Left = 284
      Top = 11
      Width = 75
      Height = 25
      Caption = '&Close'
      ModalResult = 8
      TabOrder = 0
      OnClick = buttonCloseClick
    end
  end
end
