unit Pyahu.WelcomePageList.PluginRegister;

interface

uses
  ToolsAPI.WelcomePage,
  Pyahu.WelcomePageList.Model.Constants,
  Pyahu.WelcomePageList.Model.PluginCreator;

type
  TPluginRegister = class
  public
    class procedure RegisterPlugin;
    class procedure UnRegisterPlugin;
  end;

  procedure Register;

implementation

procedure Register;
begin
  TPluginRegister.RegisterPlugin();
end;

{ TPluginRegister }

class procedure TPluginRegister.RegisterPlugin;
begin
  WelcomePagePluginService.RegisterPluginCreator(TWelcomePagePluginCreator.Create());
end;

class procedure TPluginRegister.UnRegisterPlugin;
begin
  if Assigned(WelcomePagePluginService) then
    WelcomePagePluginService.UnRegisterPlugin(CONST_PLUGIN_ID);
end;

initialization

finalization
  TPluginRegister.UnRegisterPlugin();

end.
