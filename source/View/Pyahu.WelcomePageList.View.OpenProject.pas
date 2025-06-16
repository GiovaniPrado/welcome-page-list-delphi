unit Pyahu.WelcomePageList.View.OpenProject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Pyahu.WelcomePageList.View.FrameImageList;

type
  TFormOpenFile = class(TForm)
    groupBoxImages: TGroupBox;
    editFileName: TEdit;
    panelButtons: TPanel;
    groupBoxFileName: TGroupBox;
    buttonOk: TButton;
    buttonCancel: TButton;
    panelFileName: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFramImages: TFrameImageList;
  public
    function GetImageNameFromSelectedItem: string;
  end;

var
  FormOpenFile: TFormOpenFile;

implementation

uses
  Pyahu.WelcomePageList.Utils;

{$R *.dfm}

procedure TFormOpenFile.buttonCancelClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TFormOpenFile.FormCreate(Sender: TObject);
begin
  TIdeThemeService.ApplyIdeTheme(TFormOpenFile, Self);

  FFramImages := TFrameImageList.Create(Self, False);
  FFramImages.Parent := groupBoxImages;
  FFramImages.Align := TAlign.alClient;
  FFramImages.AlignWithMargins := True;
  FFramImages.Margins.Top := 10;
  FFramImages.Margins.Left := 0;
  FFramImages.Margins.Right := 0;
  FFramImages.Margins.Bottom := 0;
end;

procedure TFormOpenFile.FormShow(Sender: TObject);
begin
  editFileName.SetFocus();
end;

function TFormOpenFile.GetImageNameFromSelectedItem: string;
begin
  Result := FFramImages.GetImageNameFromSelectedItem();
end;

end.
