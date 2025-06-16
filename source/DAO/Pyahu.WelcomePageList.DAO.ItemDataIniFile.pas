unit Pyahu.WelcomePageList.DAO.ItemDataIniFile;

interface

uses
  System.SysUtils,
  System.Classes,
  Pyahu.WelcomePageList.Model.ItemData,
  Pyahu.WelcomePageList.Model.Constants,
  Pyahu.WelcomePageList.Utils.WelcomePagePathUtils,
  Pyahu.WelcomePageList.DAO.IniFile;

type
  IItemDataIniFile = interface
    ['{25654286-828C-4E14-B2F2-B72A9318FC83}']

    procedure SetItem(const Title: string; const Description: string; const IsFavorite: Boolean; const ImageName: string);
    procedure RemoveItem(const Description: string);
    procedure LoadItens(ListItemData: TListItemData);
  end;

  TItemDataIniFile = class(TInterfacedObject, IItemDataIniFile)
  protected
    FIniFile: IPYIniFile;

    const IDENT_TITLE = 'Title';
    const IDENT_IS_FAVORITE = 'IsFavorite';
    const IDENT_IMAGE_NAME = 'ImageName';
    const CONST_WELCOME_PAGE_ITENS_INI_FILE_NAME = 'WelcomePageItens.ini';
  private
    constructor Create;
  public
    procedure SetItem(const Title: string; const Description: string; const IsFavorite: Boolean; const ImageName: string);
    procedure RemoveItem(const Description: string);
    procedure LoadItens(ListItemData: TListItemData);

    class function Load: IItemDataIniFile;
  end;

implementation

{ TWelcomePageItensIni }

procedure TItemDataIniFile.RemoveItem(const Description: string);
begin
  if FIniFile.SectionExists(Description) then
    FIniFile.EraseSection(Description);
end;

constructor TItemDataIniFile.Create;
begin
  FIniFile := TPYIniFile.LoadIniFile(TWelcomePagePath.GetPlugInPath() + CONST_WELCOME_PAGE_ITENS_INI_FILE_NAME);
end;

class function TItemDataIniFile.Load: IItemDataIniFile;
begin
  Result := TItemDataIniFile.Create();
end;

procedure TItemDataIniFile.LoadItens(ListItemData: TListItemData);
begin
  var Sections := TStringList.Create();
  FIniFile.ReadSections(Sections);
  try
    for var I := 0 to Sections.Count -1 do
      ListItemData.Add(TItemData.Create(FIniFile.ReadString(Sections[I], IDENT_TITLE, ''),
                                        Sections[I],
                                        FIniFile.ReadBoolean(Sections[I], IDENT_IS_FAVORITE, False),
                                        FIniFile.ReadString(Sections[I], IDENT_IMAGE_NAME, CONST_COMPUTER_ICON_NAME)));
  finally
    FreeAndNil(Sections);
  end;
end;

procedure TItemDataIniFile.SetItem(const Title: string; const Description: string; const IsFavorite: Boolean; const ImageName: string);
begin
  FIniFile.WriteString(Description, IDENT_TITLE, Title);
  FIniFile.WriteBoolean(Description, IDENT_IS_FAVORITE, IsFavorite);
  FIniFile.WriteString(Description, IDENT_IMAGE_NAME, ImageName);
end;

end.
