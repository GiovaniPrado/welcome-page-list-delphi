unit Pyahu.WelcomePageList.Model.ItemData;

interface

uses
  System.Generics.Collections;

type
  TItemData = class
  private
    FTitle: string;
    FDescription: string;
    FIsFavorite: Boolean;
    FImageName: string;
  public
    constructor Create(const Title: string; const Description: string; const IsFavorite: Boolean; const ImageName: string);

    property Title: string read FTitle write FTitle;
    property Description: string read FDescription write FDescription;
    property IsFavorite: Boolean read FIsFavorite write FIsFavorite;
    property ImageName: string read FImageName write FImageName;
  end;

  TListItemData = class(TObjectList<TItemData>);

implementation

{ TItemData }

constructor TItemData.Create(const Title, Description: string; const IsFavorite: Boolean; const ImageName: string);
begin
  FTitle := Title;
  FDescription := Description;
  FIsFavorite := IsFavorite;
  FImageName := ImageName;
end;

end.
