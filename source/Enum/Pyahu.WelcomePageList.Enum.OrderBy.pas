unit Pyahu.WelcomePageList.Enum.OrderBy;

interface

uses
  Pyahu.WelcomePageList.Enum.EnumConverter;

type
  TOrderBy = (Asc, Dec);

  TOrderByHelper = record helper for TOrderBy
    function ToString: string;
  end;

implementation

{ TOrderByHelper }

function TOrderByHelper.ToString: string;
begin
  Result := TEnumConverter.EnumToString<TOrderBy>(Self);
end;

end.
