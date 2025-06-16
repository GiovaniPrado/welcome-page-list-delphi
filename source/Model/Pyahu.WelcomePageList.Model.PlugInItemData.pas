unit Pyahu.WelcomePageList.Model.PlugInItemData;
interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Vcl.ImageCollection,
  ToolsAPI.WelcomePage;

type
  TWelcomePagePlugInItemData = class(TInterfacedObject, INTAWelcomePageModelItemData, INTAWelcomePageModelItemAdditionalData)
  private
    FFavoriteImageIndex: Integer;
    FUnFavoriteImageIndex: Integer;
    FTitle: string;
    FDescription: string;
    FImageIndex: Integer;
    FIsFavorite: Boolean;
    FAdditionalImageIndex: Integer;
    FImageName: string;

    { IModelItemData }
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetDescription: string;
    procedure SetDescription(const Value: string);
    function GetImageIndex: Integer;
    procedure SetImageIndex(const Value: Integer);
    { IModelItemAdditionalData }
    function GetAdditionalImageIndex: Integer;
    procedure SetAdditionalImageIndex(const Value: Integer);
    procedure SetIsFavorite(const Value: Boolean);
    function GetImageName: string;
  public
    constructor Create(const Title: string; const Description: string; const IsFavorite: Boolean; const ImageName: string);

    property Title: string read GetTitle write SetTitle;
    property Description: string read GetDescription write SetDescription;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex;
    property AdditionalImageIndex: Integer read GetAdditionalImageIndex write SetAdditionalImageIndex;
    property IsFavorite: Boolean read FIsFavorite write SetIsFavorite;
    property ImageName: string read GetImageName;
  end;

implementation

uses
  Pyahu.WelcomePageList.Resources,
  Pyahu.WelcomePageList.Model.Constants;

{ TPlugInItemData }

constructor TWelcomePagePlugInItemData.Create(const Title, Description: string; const IsFavorite: Boolean; const ImageName: string);
begin
  inherited Create;

  FFavoriteImageIndex := WelcomePageResources.ImageCollection.GetIndexByName(CONST_FAVORITE_ICON_NAME);
  FUnFavoriteImageIndex := WelcomePageResources.ImageCollection.GetIndexByName(CONST_UNFAVORITE_ICON_NAME);
  FTitle := Title;
  FDescription := Description;
  Self.IsFavorite := IsFavorite;

  if ImageName.IsEmpty() then
    FImageName := CONST_COMPUTER_ICON_NAME
  else
    FImageName := ImageName;

  FImageIndex := WelcomePageResources.ImageCollection.GetIndexByName(FImageName);
  FAdditionalImageIndex := AdditionalImageIndex;
end;

function TWelcomePagePlugInItemData.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TWelcomePagePlugInItemData.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

function TWelcomePagePlugInItemData.GetDescription: string;
begin
  Result := FDescription;
end;

procedure TWelcomePagePlugInItemData.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

function TWelcomePagePlugInItemData.GetImageIndex: Integer;
begin
  Result := FImageIndex;
end;

function TWelcomePagePlugInItemData.GetImageName: string;
begin
  Result := FImageName;

  if Result.IsEmpty() then
    Result := CONST_COMPUTER_ICON_NAME;
end;

procedure TWelcomePagePlugInItemData.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
end;

procedure TWelcomePagePlugInItemData.SetIsFavorite(const Value: Boolean);
begin
  FIsFavorite := Value;

  if Self.IsFavorite then
    Self.AdditionalImageIndex := FFavoriteImageIndex
  else
    Self.AdditionalImageIndex := FUnFavoriteImageIndex;
end;

function TWelcomePagePlugInItemData.GetAdditionalImageIndex: Integer;
begin
  Result := FAdditionalImageIndex;
end;

procedure TWelcomePagePlugInItemData.SetAdditionalImageIndex(const Value: Integer);
begin
  FAdditionalImageIndex := Value;
end;

end.
