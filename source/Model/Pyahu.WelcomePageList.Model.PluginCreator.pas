unit Pyahu.WelcomePageList.Model.PluginCreator;

interface

uses
  System.SysUtils,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Graphics,
  ToolsAPI.WelcomePage,
  Pyahu.WelcomePageList.Model.Constants,
  Pyahu.WelcomePageList.Model.PlugInModel;

type
  TWelcomePagePluginCreator = class(TInterfacedObject, INTAWelcomePagePlugin, INTAWelcomePageContentPluginCreator)
  private
    FPluginView: TFrame;
    FIconIndex: Integer;
    FWelcomePagePluginModel: INTAWelcomePagePluginModel;
    { INTAWelcomePageContentPluginCreator }
    function GetView: TFrame;
    function GetIconIndex: Integer;
    procedure SetIconIndex(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    { INTAWelcomePagePlugin }
    function GetPluginID: string;
    function GetPluginName: string;
    function GetPluginVisible: boolean;
    { INTAWelcomePageContentPluginCreator }
    function CreateView: TFrame;
    procedure DestroyView;
    function GetIcon: TGraphicArray;
  end;

implementation

uses
  Pyahu.WelcomePageList.View.CaptionFrame,
  Pyahu.WelcomePageList.Model.PlugInItemData;

function TWelcomePagePluginCreator.GetPluginID: string;
begin
  Result := CONST_PLUGIN_ID;
end;

function TWelcomePagePluginCreator.GetPluginName: string;
begin
  Result := RES_PLUGIN_NAME;
end;

function TWelcomePagePluginCreator.GetPluginVisible: boolean;
begin
  Result := True;
end;

constructor TWelcomePagePluginCreator.Create;
begin
  FWelcomePagePluginModel := GetPlugInModel();
  FIconIndex := -1;
end;

destructor TWelcomePagePluginCreator.Destroy;
begin
  DestroyView();
  inherited;
end;

function TWelcomePagePluginCreator.CreateView: TFrame;
var
  PluginView: INTAWelcomePageDataPluginListView;
  CaptionFrame: TWelcomePagePlugInCaptionFrame;
begin
  if not Assigned(FPluginView) then
    FPluginView := WelcomePagePluginService.CreateListViewFrame(CONST_PLUGIN_ID, RES_PLUGIN_NAME, vmListShort, FWelcomePagePluginModel);

  Result := FPluginView;

  if Supports(FPluginView, INTAWelcomePageDataPluginListView, PluginView) then
  begin
    PluginView.ItemHeight := TWelcomePageMetrics.ListView.MediumItemHeight;
    CaptionFrame := TWelcomePagePlugInCaptionFrame.Create(nil);
    CaptionFrame.Model := FWelcomePagePluginModel;
    PluginView.SetCaptionFrame(CaptionFrame);
    PluginView.SetOnItemDblClick(TWelcomePagePlugInModel(FWelcomePagePluginModel).ItemDblClick);
    PluginView.SetOnItemAdditionalClick(TWelcomePagePlugInModel(FWelcomePagePluginModel).ItemAdditionalClick);
  end;
end;

procedure TWelcomePagePluginCreator.DestroyView;
begin
  FreeAndNil(FPluginView);
end;

function TWelcomePagePluginCreator.GetIcon: TGraphicArray;
begin
  Result := [];
end;

function TWelcomePagePluginCreator.GetIconIndex: Integer;
begin
  Result := FIconIndex;
end;

procedure TWelcomePagePluginCreator.SetIconIndex(const Value: Integer);
begin
  FIconIndex := Value;
end;

function TWelcomePagePluginCreator.GetView: TFrame;
begin
  Result := FPluginView;
end;

end.
