unit Pyahu.WelcomePageList.Utils;

interface

uses
  System.TypInfo,
  System.Classes,
  System.SysUtils,
  Vcl.Forms,
  ToolsAPI;

type
  TIdeThemeService = class
  public
    class procedure ApplyIdeTheme(const AFormClass: TCustomFormClass; AComponent: TComponent);
  end;

implementation

{ TIdeThemeService }

class procedure TIdeThemeService.ApplyIdeTheme(const AFormClass: TCustomFormClass; AComponent: TComponent);
begin
{$IF CompilerVersion >= 32.0}
  var OTAIDEThemingServices250: IOTAIDEThemingServices250;

  if (Supports(BorlandIDEServices, IOTAIDEThemingServices250, OTAIDEThemingServices250)) then
  begin
    OTAIDEThemingServices250.RegisterFormClass(AFormClass);
    OTAIDEThemingServices250.ApplyTheme(AComponent);
  end;
{$ENDIF}
end;

end.
