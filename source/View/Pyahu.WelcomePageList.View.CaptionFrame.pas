unit Pyahu.WelcomePageList.View.CaptionFrame;

interface

uses
  Vcl.Dialogs, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.WinXCtrls, ToolsAPI.WelcomePage, ToolsAPI, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, System.IOUtils,
  Pyahu.WelcomePageList.Model.PlugInItemData;

type
  TWelcomePagePlugInCaptionFrame = class(TFrame)
    labelTitle: TLabel;
    buttonOpenProject: TSpeedButton;
    VirtualImageList: TVirtualImageList;
    buttonSettings: TSpeedButton;
    procedure buttonOpenProjectClick(Sender: TObject);
    procedure buttonSettingsClick(Sender: TObject);
  protected
    procedure PaintWindow(DC: HDC); override;
  private
    [weak] FWelcomePagePluginModel: INTAWelcomePagePluginModel;

    procedure SetModel(const Value: INTAWelcomePagePluginModel);
  public
    property Model: INTAWelcomePagePluginModel read FWelcomePagePluginModel write SetModel;
  end;

implementation

{$R *.dfm}

uses
  Pyahu.WelcomePageList.Resources,
  Pyahu.WelcomePageList.DAO.ItemDataIniFile,
  Pyahu.WelcomePageList.View.Settings,
  Pyahu.WelcomePageList.View.OpenProject;

procedure TWelcomePagePlugInCaptionFrame.buttonOpenProjectClick(Sender: TObject);
begin
  var OpenDialog := TOpenDialog.Create(Self);
  var FileName := '';
  try
    OpenDialog.Title := 'Open Project';
    OpenDialog.Filter := 'Delphi Project Files|*.groupproj;*.dproj;*.dpr;*.dpk;*.dpkw;*.bdsgroup;*.bdsproj';

    if OpenDialog.Execute() then
    begin
      const FullFilePath = OpenDialog.FileName;

      var FormOpenProject := TFormOpenFile.Create(Self);
      try
        FormOpenProject.editFileName.Text := TPath.GetFileName(FullFilePath);

        if IsPositiveResult(FormOpenProject.ShowModal()) then
        begin
          TItemDataIniFile.Load().SetItem(FormOpenProject.editFileName.Text, FullFilePath, False, FormOpenProject.GetImageNameFromSelectedItem());
          Self.Model.RefreshData();
        end;
      finally
        FreeAndNil(FormOpenProject);
      end;
    end;
  finally
    FreeAndNil(OpenDialog);
  end;
end;

procedure TWelcomePagePlugInCaptionFrame.buttonSettingsClick(Sender: TObject);
begin
  FormSettings := TFormSettings.Create(Self);
  try
    FormSettings.ShowModal();
    Self.Model.RefreshData();
  finally
    FreeAndNil(FormSettings);
  end;
end;

procedure TWelcomePagePlugInCaptionFrame.PaintWindow(DC: HDC);
begin
  inherited;

  var Canvas := TCanvas.Create();
  var NewColor: TColor;
  const CaptionOpacity = 64;
  try
    Canvas.Handle := DC;
    if Assigned(BorlandIDEServices) then
      NewColor := (BorlandIDEServices as IOTAIDEThemingServices).StyleServices.GetSystemColor(Color)
    else
      NewColor := clNone;

    (WelcomePagePluginService as INTAWelcomePageBackgroundService).PaintBackgroundTo(Canvas, Self, NewColor, CaptionOpacity);
  finally
    Canvas.Handle := 0;
    FreeAndNil(Canvas);
  end;
end;

procedure TWelcomePagePlugInCaptionFrame.SetModel(const Value: INTAWelcomePagePluginModel);
begin
  FWelcomePagePluginModel := Value;
end;

end.
