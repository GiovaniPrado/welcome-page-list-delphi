unit Pyahu.WelcomePageList.Utils.WelcomePagePathUtils;

interface

uses
  System.SysUtils,
  Pyahu.WelcomePageList.Model.Constants;

type
  TWelcomePagePath = class
  private
    class function GetPackagePath: string;
  public
    class function GetPlugInPath: string;
    class function GetImagesPath: string;
  end;

implementation

{ TPath }

class function TWelcomePagePath.GetImagesPath: string;
begin
  Result := IncludeTrailingPathDelimiter(Self.GetPlugInPath() + CONST_PATH_FOLDER_IMAGES);
  ForceDirectories(Result);
end;

class function TWelcomePagePath.GetPackagePath: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(GetModuleName(HInstance)));
end;

class function TWelcomePagePath.GetPlugInPath: string;
begin
  Result := IncludeTrailingPathDelimiter(GetPackagePath() + CONST_PATH_FOLDER_PLUGIN);
  ForceDirectories(Result);
end;

end.
