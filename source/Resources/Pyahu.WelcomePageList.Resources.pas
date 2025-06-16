unit Pyahu.WelcomePageList.Resources;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  Vcl.BaseImageCollection,
  Vcl.ImageCollection;

type
  TWelcomePageResources = class(TDataModule)
    ImageCollection: TImageCollection;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

var
  WelcomePageResources: TWelcomePageResources;

implementation

uses
  Pyahu.WelcomePageList.Utils.WelcomePagePathUtils;

{$R *.dfm}

procedure TWelcomePageResources.DataModuleCreate(Sender: TObject);
begin
  var arrayFiles := TDirectory.GetFiles(TWelcomePagePath.GetImagesPath());

  var imageName := '';

  for var I := Low(arrayFiles) to High(arrayFiles) do
  begin
    imageName := TPath.GetFileNameWithoutExtension(arrayFiles[I]);
    Self.ImageCollection.Add(imageName, arrayFiles[I]);
  end;
end;

initialization
  WelcomePageResources := TWelcomePageResources.Create(nil);

finalization
  FreeAndNil(WelcomePageResources);

end.
