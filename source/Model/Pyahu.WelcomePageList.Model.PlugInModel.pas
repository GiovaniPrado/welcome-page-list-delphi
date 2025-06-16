unit Pyahu.WelcomePageList.Model.PlugInModel;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.Math,
  Vcl.ImageCollection,
  ToolsAPI,
  ToolsAPI.WelcomePage,
  System.IniFiles,
  Pyahu.WelcomePageList.Model.PlugInItemData,
  Pyahu.WelcomePageList.Model.ItemData,
  Pyahu.WelcomePageList.DAO.ItemDataIniFile,
  Pyahu.WelcomePageList.Enum.OrderBy;

type
  TWelcomePagePlugInModel = class(TInterfacedObject, INTAWelcomePagePluginModel)
  private
    FFavorites: TDictionary<string, Boolean>;
    FData: IInterfaceList;
    FStatusMessage: string;
    [weak] FOnLoadFinished: TProc;
    FListItemData: TListItemData;

    // Favorites
    function GetFavorite(Index: Integer): Boolean;
    procedure SetFavorite(Index: Integer; Value: Boolean);
    // Plugins info
    function GetPlugInItemData(Index: Integer): TWelcomePagePlugInItemData;
    function AddPlugInItemData(const ItemData: TItemData): Integer; overload;
    function IndexOf(const APlugInID: string): Integer;
    { INTAWelcomePagePluginModel }
    function GetData: IInterfaceList;
    function GetImageCollection: TImageCollection;
    function GetIsDataLoaded: Boolean;
    function GetStatusMessage: string;

    procedure OrderListItemData(const OrderBy: TOrderBy);
    function GetOrderByFromSettings: TOrderBy;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ItemDblClick(Sender: TObject; AItemIndex: Integer);
    procedure ItemAdditionalClick(Sender: TObject; AItemIndex: Integer);
    { INTAWelcomePagePluginModel }
    procedure SetOnLoadingFinished(const AProc: TProc);
    procedure LoadData;
    procedure RefreshData;
    procedure StopLoading;
    property IsFavorite[AIndex: Integer]: Boolean read GetFavorite write SetFavorite;
    property PlugInItemData[AIndex: Integer]: TWelcomePagePlugInItemData read GetPlugInItemData;
  end;

function GetPlugInModel: TWelcomePagePlugInModel;

implementation

uses
  Pyahu.WelcomePageList.Resources,
  Pyahu.WelcomePageList.Model.Constants,
  Pyahu.WelcomePageList.DAO.SettingsIniFile;

function GetPlugInModel: TWelcomePagePlugInModel;
begin
  Result := TWelcomePagePlugInModel.Create();
end;

function TWelcomePagePlugInModel.AddPlugInItemData(const ItemData: TItemData): Integer;
begin
  if not Assigned(FData) then
    Exit(-1);

  Result := IndexOf(ItemData.Title);

  if (Result = -1) then
    Result := FData.Add(TWelcomePagePlugInItemData.Create(ItemData.Title, ItemData.Description, ItemData.IsFavorite, ItemData.ImageName));
end;

constructor TWelcomePagePlugInModel.Create;
begin
  FFavorites := TDictionary<string, Boolean>.Create();
  FData := TInterfaceList.Create();
  FListItemData := TListItemData.Create();
  LoadData();
end;

destructor TWelcomePagePlugInModel.Destroy;
begin
  FreeAndNIl(FFavorites);

  if Assigned(FData) then
  begin
    FData.Clear();
    FData := nil;
  end;

  FreeAndNil(FListItemData);

  inherited;
end;

function TWelcomePagePlugInModel.GetFavorite(Index: Integer): Boolean;
begin
  var Item := PlugInItemData[Index];

  if FFavorites.ContainsKey(Item.Title) then
    Result := FFavorites[Item.Title]
  else
    Result := False;
end;

procedure TWelcomePagePlugInModel.SetFavorite(Index: Integer; Value: Boolean);
begin
  var Item := PlugInItemData[Index];

  if Assigned(Item) and (Value <> Item.IsFavorite)  then
  begin
    if not FFavorites.ContainsKey(Item.Title) then
      FFavorites.Add(Item.Title, Value)
    else
      FFavorites[Item.Title] := Value;

    Item.IsFavorite := Value;
  end;
end;

function TWelcomePagePlugInModel.GetPlugInItemData(Index: Integer): TWelcomePagePlugInItemData;
begin
  if Assigned(FData) and (Index >= 0) and (Index < FData.Count) then
    Result := TWelcomePagePlugInItemData(FData[Index])
  else
    Result := nil;
end;

function TWelcomePagePlugInModel.IndexOf(const APluginID: string): Integer;
begin
  if (not Assigned(FData))  then
    Exit(-1);

  for var I := 0 to Pred(FData.Count) do
  begin
    if SameText(TWelcomePagePlugInItemData(FData[I]).Title, APluginID) then
      Exit(I);
  end;

  Result := -1;
end;

procedure TWelcomePagePlugInModel.ItemAdditionalClick(Sender: TObject; AItemIndex: Integer);
begin
  PlugInItemData[AItemIndex].IsFavorite := not PlugInItemData[AItemIndex].IsFavorite;

  if PlugInItemData[AItemIndex].IsFavorite then
    TItemDataIniFile.Load().SetItem(PlugInItemData[AItemIndex].Title, PlugInItemData[AItemIndex].Description, PlugInItemData[AItemIndex].IsFavorite, PlugInItemData[AItemIndex].ImageName)
  else
    TItemDataIniFile.Load().RemoveItem(PlugInItemData[AItemIndex].Description);

  RefreshData();
end;

procedure TWelcomePagePlugInModel.ItemDblClick(Sender: TObject; AItemIndex: Integer);
begin
  if not FileExists(TWelcomePagePlugInItemData(FData[AItemIndex]).Description) then
    Exit();

  var OTAActionServices: IOTAActionServices;

  if Supports(BorlandIDEServices, IOTAActionServices, OTAActionServices) then
    OTAActionServices.OpenProject(TWelcomePagePlugInItemData(FData[AItemIndex]).Description, True);
end;

function TWelcomePagePlugInModel.GetData: IInterfaceList;
begin
  Result := FData;
end;

function TWelcomePagePlugInModel.GetImageCollection: TImageCollection;
begin
  Result := WelcomePageResources.ImageCollection;
end;

function TWelcomePagePlugInModel.GetIsDataLoaded: Boolean;
begin
  Result := FStatusMessage.IsEmpty();
end;

function TWelcomePagePlugInModel.GetOrderByFromSettings: TOrderBy;
begin
  Result := TSettingsIniFile.Load().GetOrderBy();
end;

function TWelcomePagePlugInModel.GetStatusMessage: string;
begin
  Result := FStatusMessage;
end;

procedure TWelcomePagePlugInModel.SetOnLoadingFinished(const AProc: TProc);
begin
  FOnLoadFinished := AProc;
end;

procedure TWelcomePagePlugInModel.LoadData;
begin
  FData.Clear();
  FListItemData.Clear();
  try
    TItemDataIniFile.Load().LoadItens(FListItemData);
    OrderListItemData(GetOrderByFromSettings());

    for var ItemData in FListItemData do
      AddPlugInItemData(ItemData);

   if Assigned(FOnLoadFinished) then
     FOnLoadFinished;
  except on E: Exception do
    begin
      FStatusMessage := E.Message;

      if Assigned(FOnLoadFinished) then
        FOnLoadFinished
      else
        raise;
    end;
  end;
end;

procedure TWelcomePagePlugInModel.OrderListItemData(const OrderBy: TOrderBy);
begin
  FListItemData.Sort(TComparer<TItemData>.Construct(
                     function(const L, R: TItemData): Integer
                     begin
                       if L.IsFavorite <> R.IsFavorite then
                         Result := Integer(R.IsFavorite) - Integer(L.IsFavorite)
                       else
                         Result := IfThen(OrderBy = TOrderBy.Asc, CompareStr(L.Title, R.Title), CompareStr(R.Title, L.Title));
                     end));
end;

procedure TWelcomePagePlugInModel.RefreshData;
begin
  FStatusMessage := '';
  LoadData();
end;

procedure TWelcomePagePlugInModel.StopLoading;
begin
  // Do nothing
end;

end.
