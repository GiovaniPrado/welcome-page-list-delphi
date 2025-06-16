object WelcomePagePlugInCaptionFrame: TWelcomePagePlugInCaptionFrame
  Left = 0
  Top = 0
  Width = 223
  Height = 38
  AutoSize = True
  TabOrder = 0
  object buttonOpenProject: TSpeedButton
    AlignWithMargins = True
    Left = 136
    Top = 8
    Width = 38
    Height = 22
    Hint = 'Open...'
    Margins.Left = 0
    Margins.Top = 8
    Margins.Bottom = 8
    Align = alRight
    BiDiMode = bdLeftToRight
    ImageIndex = 1
    ImageName = 'OpenFolder'
    Images = VirtualImageList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = 18
    Font.Name = 'Segoe UI'
    Font.Style = [fsItalic]
    ParentFont = False
    ParentShowHint = False
    ParentBiDiMode = False
    ShowHint = True
    OnClick = buttonOpenProjectClick
    ExplicitLeft = 139
  end
  object labelTitle: TLabel
    Left = 0
    Top = 0
    Width = 109
    Height = 38
    Align = alLeft
    Caption = 'Favorite projects'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    ExplicitHeight = 20
  end
  object buttonSettings: TSpeedButton
    AlignWithMargins = True
    Left = 177
    Top = 8
    Width = 38
    Height = 22
    Hint = 'Open...'
    Margins.Left = 0
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alRight
    BiDiMode = bdLeftToRight
    ImageIndex = 0
    ImageName = 'Plugin - Configuration'
    Images = VirtualImageList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = 18
    Font.Name = 'Segoe UI'
    Font.Style = [fsItalic]
    ParentFont = False
    ParentShowHint = False
    ParentBiDiMode = False
    ShowHint = True
    OnClick = buttonSettingsClick
    ExplicitLeft = 185
    ExplicitTop = 16
  end
  object VirtualImageList: TVirtualImageList
    Images = <
      item
        CollectionIndex = 4
        CollectionName = 'Plugin - Configuration'
        Name = 'Plugin - Configuration'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Plugin - Open folder'
        Name = 'OpenFolder'
      end>
    ImageCollection = WelcomePageResources.ImageCollection
    Width = 18
    Height = 18
    Left = 70
    Top = 3
  end
end
