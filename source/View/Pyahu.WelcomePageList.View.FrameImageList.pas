unit Pyahu.WelcomePageList.View.FrameImageList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.IOUtils, Vcl.ImageCollection,
  Pyahu.WelcomePageList.Enum.OrderBy;

type
  TFrameImageList = class(TFrame)
    panelGroupImage: TPanel;
    labelIdealSize: TLabel;
    buttonAddImage: TButton;
    buttonRemove: TButton;
    listBoxImages: TListBox;
    panelImage: TPanel;
    image: TImage;
    buttonSetAsDefault: TButton;
    procedure buttonAddImageClick(Sender: TObject);
    procedure listBoxImagesClick(Sender: TObject);
    procedure buttonRemoveClick(Sender: TObject);
    procedure buttonSetAsDefaultClick(Sender: TObject);
  private
    function GetDefaultItemIndex: Integer;
    function CanRemoveSelectedImage: Boolean;
    function GetSelectedImageIndex: Integer;
    function GetDefaultImageNameFromSettingsIniFile: string;

    procedure LoadImagesFromResources;
    procedure SetDefaultImage(const ImageName: string);
    procedure ShowSelectedImage;
    procedure SetDefaultImageInSettingsIniFile(const ImageName: string);
  public
    constructor Create(AOwner: TComponent; const CanEditImages: Boolean); reintroduce;

    function GetDefaultImageName: string;
    function GetImageNameFromSelectedItem: string;
  end;

implementation

uses
  Pyahu.WelcomePageList.Utils,
  Pyahu.WelcomePageList.Utils.WelcomePagePathUtils,
  Pyahu.WelcomePageList.Resources,
  Pyahu.WelcomePageList.DAO.SettingsIniFile;

{$R *.dfm}

procedure TFrameImageList.buttonAddImageClick(Sender: TObject);
begin
  var OpenDialog := TOpenDialog.Create(Self);
  var FullPath := '';
  try
    OpenDialog.Title := 'Open';
    OpenDialog.Filter := 'Image Files|*.png;*.jpg;*.jpeg;*.bmp;*.gif;*.tif;...';

    if OpenDialog.Execute() then
    begin
      const ImageName = 'Custom - ' + TPath.GetFileNameWithoutExtension(OpenDialog.FileName);

      if WelcomePageResources.ImageCollection.GetIndexByName(ImageName) > -1 then
      begin
        ShowMessage('This file already exists.');
        Exit();
      end;

      WelcomePageResources.ImageCollection.Add(ImageName, OpenDialog.FileName);

      const LasIndex = WelcomePageResources.ImageCollection.Images.Count -1;

      WelcomePageResources.ImageCollection.Images[LasIndex].SourceImages[0].Image.SaveToFile(TWelcomePagePath.GetImagesPath() + ImageName + '.png');
      listBoxImages.AddItem(ImageName, WelcomePageResources.ImageCollection.Images[LasIndex]);
      listBoxImages.ItemIndex := listBoxImages.Items.Count -1;
      listBoxImagesClick(Self);
    end;
  finally
    FreeAndNil(OpenDialog);
  end;
end;

procedure TFrameImageList.buttonRemoveClick(Sender: TObject);
begin
  const SelectedImageIndex = GetSelectedImageIndex();

  if (SelectedImageIndex < 0) then
    Exit();

  const ImageName = GetImageNameFromSelectedItem();
  const FullImagePath = TWelcomePagePath.GetImagesPath() + ImageName + '.png';

  WelcomePageResources.ImageCollection.Delete(ImageName);

  if FileExists(FullImagePath) then
    DeleteFile(FullImagePath);

  listBoxImages.Items.Delete(SelectedImageIndex);
end;

procedure TFrameImageList.buttonSetAsDefaultClick(Sender: TObject);
begin
  if (GetSelectedImageIndex() < 0) then
    Exit();

  SetDefaultImage(GetImageNameFromSelectedItem());
end;

function TFrameImageList.CanRemoveSelectedImage: Boolean;
begin
  Result := not ListBoxImages.Items[GetSelectedImageIndex()].Contains('Plugin');
end;

constructor TFrameImageList.Create(AOwner: TComponent; const CanEditImages: Boolean);
begin
  inherited Create(AOwner);

  LoadImagesFromResources();
  SetDefaultImage(GetDefaultImageNameFromSettingsIniFile());

  const DefaultItemIndex = GetDefaultItemIndex();

  if (DefaultItemIndex < 0) and (listBoxImages.Count > 0) then
    listBoxImages.ItemIndex := 0
  else
    listBoxImages.ItemIndex := DefaultItemIndex;

  ShowSelectedImage();

  if not CanEditImages then
  begin
    buttonAddImage.Visible := False;
    buttonRemove.Visible := False;
    buttonSetAsDefault.Visible := False;

    listBoxImages.Margins.Top := 3;
    panelImage.top := listBoxImages.Top;
  end;
end;

function TFrameImageList.GetDefaultImageName: string;
begin
  const DefaultItemIndex = GetDefaultItemIndex();

  if (DefaultItemIndex < 0) then
    Result := ''
  else
    Result := TImageCollectionItem(listBoxImages.Items.Objects[DefaultItemIndex]).Name;
end;

function TFrameImageList.GetDefaultImageNameFromSettingsIniFile: string;
begin
  Result := TSettingsIniFile.Load().GetDefaultImageName();
end;

function TFrameImageList.GetDefaultItemIndex: Integer;
begin
  Result := -1;

  for var I := 0 to listBoxImages.Items.Count -1 do
  begin
    if listBoxImages.Items[I].Contains('(Default)') then
      Exit(I);
  end;
end;

function TFrameImageList.GetImageNameFromSelectedItem: string;
begin
  const SelectedImageIndex = GetSelectedImageIndex();

  if (SelectedImageIndex < 0) then
    Exit('');

  Result := TImageCollectionItem(listBoxImages.Items.Objects[SelectedImageIndex]).Name;
end;

function TFrameImageList.GetSelectedImageIndex: Integer;
begin
  Result := listBoxImages.ItemIndex;
end;

procedure TFrameImageList.listBoxImagesClick(Sender: TObject);
begin
  if (GetSelectedImageIndex() < 0) then
    Exit();

  buttonRemove.Enabled := CanRemoveSelectedImage();
  ShowSelectedImage();
end;

procedure TFrameImageList.LoadImagesFromResources;
begin
  ListBoxImages.Clear();

  for var I := 0 to WelcomePageResources.ImageCollection.Images.Count -1 do
    ListBoxImages.AddItem(WelcomePageResources.ImageCollection.Images[I].Name, WelcomePageResources.ImageCollection.Images[I]);

  ListBoxImages.Sorted := True;
end;

procedure TFrameImageList.SetDefaultImage(const ImageName: string);
begin
  if ImageName.IsEmpty() then
    Exit();

  for var I := 0 to listBoxImages.Items.Count -1 do
  begin
    listBoxImages.Items[I] := TImageCollectionItem(listBoxImages.Items.Objects[I]).Name;

    if (ImageName = listBoxImages.Items[I]) then
    begin
      listBoxImages.Items[I] := listBoxImages.Items[I] + ' (Default)';
      SetDefaultImageInSettingsIniFile(ImageName);
    end;
  end;
end;

procedure TFrameImageList.SetDefaultImageInSettingsIniFile(const ImageName: string);
begin
  TSettingsIniFile.Load().SetDefaultImageName(ImageName);
end;

procedure TFrameImageList.ShowSelectedImage;
begin
  Image.Picture := nil;
  Image.Picture.Bitmap.Assign(TImageCollectionItem(listBoxImages.Items.Objects[GetSelectedImageIndex()]).SourceImages[0].Image);
end;

end.
