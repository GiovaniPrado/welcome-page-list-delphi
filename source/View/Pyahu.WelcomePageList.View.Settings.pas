unit Pyahu.WelcomePageList.View.Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.ImageCollection, System.IOUtils, System.StrUtils,
  Pyahu.WelcomePageList.Utils,
  Pyahu.WelcomePageList.Utils.WelcomePagePathUtils,
  Pyahu.WelcomePageList.Resources,
  Pyahu.WelcomePageList.Enum.OrderBy,
  Pyahu.WelcomePagelist.Enum.EnumConverter,
  Pyahu.WelcomePageList.DAO.SettingsIniFile,
  Pyahu.WelcomePageList.View.FrameImageList,
  ToolsAPI.WelcomePage;

type
  TFormSettings = class(TForm)
    comboBoxItemsOrder: TComboBox;
    labelItemsOrder: TLabel;
    groupBoxImages: TGroupBox;
    groupBoxDefaultValues: TGroupBox;
    panelGroupDefatulValues: TPanel;
    panelButtons: TPanel;
    buttonClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFramImages: TFrameImageList;

    procedure SaveSettings;
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;

implementation

{$R *.dfm}

procedure TFormSettings.buttonCloseClick(Sender: TObject);
begin
  SaveSettings();
  Self.Close();
end;

procedure TFormSettings.FormCreate(Sender: TObject);
begin
  FFramImages := TFrameImageList.Create(Self, True);
  FFramImages.Parent := groupBoxImages;
  FFramImages.Align := TAlign.alClient;
  FFramImages.AlignWithMargins := True;
  FFramImages.Margins.Top := 10;
  FFramImages.Margins.Left := 0;
  FFramImages.Margins.Right := 0;
  FFramImages.Margins.Bottom := 0;

  TIdeThemeService.ApplyIdeTheme(TFormSettings, Self);

  const SettingsIniFile = TSettingsIniFile.Load();

  comboBoxItemsOrder.ItemIndex := comboBoxItemsOrder.Items.IndexOf(SettingsIniFile.GetOrderBy().ToString());
end;

procedure TFormSettings.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FFramImages);
end;

procedure TFormSettings.FormShow(Sender: TObject);
begin
  comboBoxItemsOrder.SetFocus();
end;

procedure TFormSettings.SaveSettings;
begin
  const SettingsIniFile = TSettingsIniFile.Load();
  SettingsIniFile.SetOrderBy(TEnumConverter.StringToEnum<TOrderBy>(comboBoxItemsOrder.Items[comboBoxItemsOrder.ItemIndex]));
  SettingsIniFile.SetDefaultImageName(FFramImages.GetDefaultImageName());
end;

end.
