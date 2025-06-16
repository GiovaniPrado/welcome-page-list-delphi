unit Pyahu.WelcomePageList.Model.WelcomePageListItensSettings;

interface

uses
  Pyahu.WelcomePageList.Model.IniFile;

type
  TSettings = class
  private

  public
    procedure Load;
  end;

implementation

procedure TSettings.Load;
begin
  const IniFile = TPIniFile.LoadIniFile()
end;

end.
