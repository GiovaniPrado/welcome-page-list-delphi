unit Pyahu.WelcomePageList.DAO.IniFile;

interface

uses
  System.SysUtils,
  System.IniFiles,
  System.Classes;

type

  IPYIniFile = interface
    ['{DCCED59E-B656-4CA7-8F93-29FDA9372244}']

    function ReadString(const Section, Ident, Default: string): string;
    function ReadBoolean(const Section, Ident: string; const Default: Boolean): Boolean;
    function SectionExists(const Section: string): Boolean;

    procedure WriteString(const Section, Ident, Value: String);
    procedure WriteBoolean(const Section, Ident: string; Value: Boolean);
    procedure EraseSection(const Section: string);
    procedure ReadSections(Strings: TStrings);
  end;

  TPYIniFile = class(TInterfacedObject, IPYIniFile)
  private
    FIniFile: TIniFile;

    constructor Create(const FileName: string);
  public
    destructor Destroy; override;
    class function LoadIniFile(const FileName: string): IPYIniFile;

    function ReadString(const Section, Ident, Default: string): string;
    function ReadBoolean(const Section, Ident: string; const Default: Boolean): Boolean;
    function SectionExists(const Section: string): Boolean;

    procedure WriteString(const Section, Ident, Value: String);
    procedure WriteBoolean(const Section, Ident: string; Value: Boolean);
    procedure EraseSection(const Section: string);
    procedure ReadSections(Strings: TStrings);
  end;

implementation

{ TPIniFile }

constructor TPYIniFile.Create(const FileName: string);
begin
  FIniFile := TIniFile.Create(FileName);
end;

destructor TPYIniFile.Destroy;
begin
  if Assigned(FIniFile) then
    FreeAndNil(FIniFile);
  inherited;
end;

procedure TPYIniFile.EraseSection(const Section: string);
begin
  FIniFile.EraseSection(Section);
end;

class function TPYIniFile.LoadIniFile(const FileName: string): IPYIniFile;
begin
  Result := TPYIniFile.Create(FileName);
end;

function TPYIniFile.ReadBoolean(const Section, Ident: string; const Default: Boolean): Boolean;
begin
  Result := FIniFile.ReadBool(Section, Ident, Default)
end;

procedure TPYIniFile.ReadSections(Strings: TStrings);
begin
  FIniFile.ReadSections(Strings);
end;

function TPYIniFile.ReadString(const Section, Ident, Default: string): string;
begin
  Result := FIniFile.ReadString(Section, Ident, Default);
end;

function TPYIniFile.SectionExists(const Section: string): Boolean;
begin
  Result := FIniFile.SectionExists(Section);
end;

procedure TPYIniFile.WriteBoolean(const Section, Ident: string; Value: Boolean);
begin
  FIniFile.WriteBool(Section, Ident, Value)
end;

procedure TPYIniFile.WriteString(const Section, Ident, Value: String);
begin
  FIniFile.WriteString(Section, Ident, Value)
end;

end.
