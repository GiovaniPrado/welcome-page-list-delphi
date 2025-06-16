unit Pyahu.WelcomePageList.DAO.SettingsIniFile;

interface

uses
  System.SysUtils,
  System.Classes,
  Pyahu.WelcomePageList.Enum.OrderBy,
  Pyahu.WelcomePageList.Enum.EnumConverter,
  Pyahu.WelcomePageList.Model.Constants,
  Pyahu.WelcomePageList.Utils.WelcomePagePathUtils,
  Pyahu.WelcomePageList.DAO.IniFile;

type
  ISettingsIniFile = interface
    ['{1658FE81-BD2C-4540-BD5E-9AFBD57DE2E4}']

    function GetOrderBy: TOrderBy;
    function GetDefaultImageName: string;
    function SetOrderBy(const OrderBy: TOrderBy): ISettingsIniFile;
    function SetDefaultImageName(const DefaultImageName: string): ISettingsIniFile;
  end;

  TSettingsIniFile = class(TInterfacedObject, ISettingsIniFile)
  protected
    FIniFile: IPYIniFile;

    const CONST_WELCOME_PAGE_SETTINGS_INI_FILE_NAME = 'Settings.ini';
    const SECTION_NAME = 'Settings';
    const IDENT_ORDER_BY = 'OrderByItems';
    const IDENT_DEFAULT_IMAGE_NAME = 'DefaultImageName';
  private
    constructor Create;
  public
    function GetOrderBy: TOrderBy;
    function GetDefaultImageName: string;
    function SetOrderBy(const OrderBy: TOrderBy): ISettingsIniFile;
    function SetDefaultImageName(const DefaultImageName: string): ISettingsIniFile;

    class function Load: ISettingsIniFile;
  end;

implementation

{ TSettingsIniFile }

constructor TSettingsIniFile.Create;
begin
  FIniFile := TPYIniFile.LoadIniFile(TWelcomePagePath.GetPlugInPath() + CONST_WELCOME_PAGE_SETTINGS_INI_FILE_NAME);
end;

function TSettingsIniFile.GetDefaultImageName: string;
begin
  Result := FIniFile.ReadString(SECTION_NAME, IDENT_DEFAULT_IMAGE_NAME, CONST_COMPUTER_ICON_NAME);
end;

function TSettingsIniFile.GetOrderBy: TOrderBy;
begin
  Result := TEnumConverter.StringToEnum<TOrderBy>(FIniFile.ReadString(SECTION_NAME, IDENT_ORDER_BY, 'Asc'));
end;

class function TSettingsIniFile.Load: ISettingsIniFile;
begin
  Result := TSettingsIniFile.Create();
end;

function TSettingsIniFile.SetDefaultImageName(const DefaultImageName: string): ISettingsIniFile;
begin
  FIniFile.WriteString(SECTION_NAME, IDENT_DEFAULT_IMAGE_NAME, DefaultImageName);
end;

function TSettingsIniFile.SetOrderBy(const OrderBy: TOrderBy): ISettingsIniFile;
begin
  FIniFile.WriteString(SECTION_NAME, IDENT_ORDER_BY, TEnumConverter.EnumToString<TOrderBy>(OrderBy));
end;

end.
