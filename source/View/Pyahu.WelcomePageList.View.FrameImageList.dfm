object FrameImageList: TFrameImageList
  Left = 0
  Top = 0
  Width = 372
  Height = 196
  TabOrder = 0
  object panelGroupImage: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 372
    Height = 196
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 0
    object buttonAddImage: TButton
      Left = 4
      Top = 10
      Width = 60
      Height = 25
      Caption = 'Add'
      TabOrder = 0
      OnClick = buttonAddImageClick
    end
    object buttonRemove: TButton
      Left = 70
      Top = 10
      Width = 60
      Height = 25
      Caption = 'Remove'
      Enabled = False
      TabOrder = 1
      OnClick = buttonRemoveClick
    end
    object listBoxImages: TListBox
      AlignWithMargins = True
      Left = 4
      Top = 44
      Width = 212
      Height = 148
      Margins.Top = 43
      Align = alLeft
      ItemHeight = 15
      TabOrder = 3
      OnClick = listBoxImagesClick
    end
    object panelImage: TPanel
      Left = 222
      Top = 44
      Width = 136
      Height = 148
      TabOrder = 4
      object image: TImage
        Left = 4
        Top = 4
        Width = 128
        Height = 128
        Center = True
      end
      object labelIdealSize: TLabel
        Left = 1
        Top = 134
        Width = 128
        Height = 13
        Align = alBottom
        Alignment = taCenter
        Caption = 'Ideal image size: 128x128'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object buttonSetAsDefault: TButton
      Left = 136
      Top = 10
      Width = 80
      Height = 25
      Caption = 'Set as default'
      TabOrder = 2
      OnClick = buttonSetAsDefaultClick
    end
  end
end
