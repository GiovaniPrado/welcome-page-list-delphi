object FormOpenFile: TFormOpenFile
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 311
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object groupBoxImages: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 66
    Width = 370
    Height = 195
    Align = alClient
    Caption = 'Choose the icon'
    TabOrder = 0
    ExplicitHeight = 199
  end
  object panelButtons: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 267
    Width = 370
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 271
    object buttonOk: TButton
      Left = 207
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object buttonCancel: TButton
      Left = 288
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = buttonCancelClick
    end
  end
  object groupBoxFileName: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 370
    Height = 57
    Align = alTop
    Caption = 'File name'
    TabOrder = 2
    object panelFileName: TPanel
      Left = 2
      Top = 17
      Width = 366
      Height = 38
      Align = alClient
      TabOrder = 0
      object editFileName: TEdit
        Left = 4
        Top = 8
        Width = 357
        Height = 23
        TabOrder = 0
      end
    end
  end
end
