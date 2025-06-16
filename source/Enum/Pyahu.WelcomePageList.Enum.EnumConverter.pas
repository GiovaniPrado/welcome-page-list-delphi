unit Pyahu.WelcomePageList.Enum.EnumConverter;

interface

uses
  System.TypInfo;

type

  TEnumConverter = class
  public
    class function EnumToInt<T>(const Value: T): Integer;
    class function EnumToString<T>(const Value: T): string;
    class function StringToEnum<T>(const Value: string): T;
  end;

implementation

class function TEnumConverter.EnumToInt<T>(const Value: T): Integer;
begin
  Result := 0;
  Move(Value, Result, SizeOf(Value));
end;

class function TEnumConverter.EnumToString<T>(const Value: T): string;
begin
  Result := GetEnumName(TypeInfo(T), EnumToInt(Value));
end;

class function TEnumConverter.StringToEnum<T>(const Value: string): T;
begin
  var TypeInfo := TypeInfo(T);
  var Temp := GetEnumValue(TypeInfo, Value);
  var PTemp := @Temp;

  Result := T(PTemp^);
end;

end.
