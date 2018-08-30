unit GeneralUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TCalcForm }

  TCalcForm = class(TForm)
    ClearAll: TButton;
    ResButton: TButton;
    NumBut1: TButton;
    NumField: TEdit;
    NumBut10: TButton;
    Comma: TButton;
    NumBut2: TButton;
    NumBut3: TButton;
    NumBut4: TButton;
    NumBut5: TButton;
    NumBut6: TButton;
    NumBut7: TButton;
    NumBut8: TButton;
    NumBut9: TButton;
    AddButton: TButton;
    SubsButton: TButton;
    MultButton: TButton;
    DivButton: TButton;
    ClearHist: TButton;
    EditButton: TButton;
    procedure ClearHistClick(Sender: TObject);
    procedure OpButtonClick(Sender: TObject);
    procedure ClearAllClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure NumButClick(Sender: TObject);
    procedure ResButtonClick(Sender: TObject);
    procedure CommaClick(Sender: TObject);
    procedure ZeroClick(Sender: TObject);
  private

  public

  end;

var
  CalcForm: TCalcForm;
  Num1, Num2, ResNum: Real;
  Sign: String;

implementation

{$R *.lfm}

{ TCalcForm }
procedure TCalcForm.CommaClick(Sender: TObject);
var
  buf: String;
  i: Integer;
  flag: Boolean;
begin
  flag:=false;
  buf:=NumField.Caption;
   for  i:=1 to buf.length do
   begin
     if buf[i]='.' then
        begin
           flag:=true;
           break;
        end;
   end;
   if ( not flag) and (buf<>'') then
     NumField.Caption:=NumField.Caption+'.';
end;
procedure TCalcForm.ZeroClick(Sender: TObject);
begin
   if (NumField.Caption<>'') and (NumField.Caption<>'0') then
      NumField.Caption:=NumField.Caption+(Sender as TButton).Caption
   else
      NumField.Caption:='0';
end;

procedure TCalcForm.NumButClick(Sender: TObject);
begin
   if (NumField.Caption='0') then
       NumField.Clear;
   NumField.Caption:=NumField.Caption+(Sender as TButton).Caption;
end;

procedure TCalcForm.ResButtonClick(Sender: TObject);
begin
   if NumField.Caption<>'' then
     begin
        Num2:=StrToFloat(NumField.Caption);
        case Sign of
             '+':
                 ResNum:=Num1+Num2;
             '-':
                 ResNum:=Num1-Num2;
             '*':
                 ResNum:=Num1*Num2;
             '/':
                 ResNum:=Num1/Num2;
        end;
        NumField.Caption:=FloatToStr(ResNum);
     end;
end;

procedure TCalcForm.EditButtonClick(Sender: TObject);
var
  buf: String;
  len: Integer;
begin
   buf:=NumField.Caption;
   len:=buf.Length;
   if len>0 then
      Delete(buf, len, 1);
   NumField.Caption:=buf;
end;

procedure TCalcForm.ClearAllClick(Sender: TObject);
begin
  NumField.Clear;
end;

procedure TCalcForm.OpButtonClick(Sender: TObject);
begin
  if NumField.Caption<>'' then
     begin
        Num1:=StrToFloat(NumField.Caption);
        NumField.Clear;
        Sign:=(Sender as TButton).Caption;
     end;
end;

procedure TCalcForm.ClearHistClick(Sender: TObject);
begin
  NumField.Clear;
  Num1:=0;
  Num2:=0;
  ResNum:=0;
end;



end.

