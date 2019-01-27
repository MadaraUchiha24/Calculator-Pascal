unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ClassStruct;

type

  { TcalcForm }

  TcalcForm = class(TForm)
    calcArea: TEdit;
    histArea: TEdit;
    clearLastBtn: TButton;
    clearAllBtn: TButton;
    delEndBtn: TButton;
    divBtn: TButton;
    numBtn_7: TButton;
    numBtn_8: TButton;
    numBtn_9: TButton;
    sqrtOpBtn: TButton;
    mulBtn: TButton;
    numBtn_4: TButton;
    numBtn_5: TButton;
    numBtn_6: TButton;
    subBtn: TButton;
    invertSignBtn: TButton;
    numBtn_1: TButton;
    numBtn_2: TButton;
    numBtn_3: TButton;
    percBtn: TButton;
    plusBtn: TButton;
    numBtn_0: TButton;
    pointBtn: TButton;
    resultBtn: TButton;
    binPowOpBtn: TButton;
    memCallBtn: TButton;
    memAddBtn: TButton;
    memSubBtn: TButton;
    revBtn: TButton;
    memPushBtn: TButton;
    clearMemBtn: TButton;
    procedure binPowOpBtnClick(Sender: TObject);
    procedure clearAllBtnClick(Sender: TObject);
    procedure clearLastBtnClick(Sender: TObject);
    procedure clearMemBtnClick(Sender: TObject);
    procedure delEndBtnClick(Sender: TObject);
    procedure invertSignBtnClick(Sender: TObject);
    procedure memAddBtnClick(Sender: TObject);
    procedure memCallBtnClick(Sender: TObject);
    procedure memPushBtnClick(Sender: TObject);
    procedure memSubBtnClick(Sender: TObject);
    procedure numBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure oprtBtnClick(Sender: TObject);
    procedure percBtnClick(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure pointBtnClick(Sender: TObject);
    procedure resultBtnClick(Sender: TObject);
    procedure revBtnClick(Sender: TObject);
    procedure sqrtOpBtnClick(Sender: TObject);
    procedure countResult(sign: char);
    procedure clearall();
  private

  public

  end;

var
  calcForm: TcalcForm;
  dot: boolean = False;
  history: TListStackOfFloat;
  memory: TListStackOfFLoat;
  oprt: TListStackOfChar;


implementation

{$R *.lfm}

{ TcalcForm }


procedure TCalcForm.countResult(sign: char);
var
  a, b: double;
begin
  case sign of
    '+':
    begin
      b := history.Get();
      history.Pop();
      a := history.Get();
      history.Pop();
      history.Push(a + b);
      calcArea.Caption := floattostr(a + b);
    end;
    '-':
    begin
      b := history.Get();
      history.Pop();
      a := history.Get();
      history.Pop();
      history.Push(a - b);
      calcArea.Caption := floattostr(a - b);
    end;
    '*':
    begin
      b := history.Get();
      history.Pop();
      a := history.Get();
      history.Pop();
      history.Push(a * b);
      calcArea.Caption := floattostr(a * b);
    end;
    '/':
    begin
      b := history.Get();
      history.Pop();
      a := history.Get();
      history.Pop();
      if (b = 0) then
        calcArea.Caption := 'infinity'
      else
      begin
        history.Push(a / b);
        calcArea.Caption := floattostr(a / b);
      end;
    end;
  end;
  oprt.Pop();
end;

procedure TcalcForm.FormCreate(Sender: TObject);
begin
end;

procedure tcalcform.clearAll();
begin
  calcArea.Caption := '0';
  histArea.Caption := '';
  while (history.size > 0) do
    history.Pop();
  while (oprt.size > 0) do
    oprt.Pop();
end;

procedure TcalcForm.pointBtnClick(Sender: TObject);
var
  s : string;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') then
    clearAll()
  else
  begin
    if (pos(',', s) = 0) then
      calcArea.Caption := calcArea.Caption + ',';
  end;

end;

procedure TcalcForm.resultBtnClick(Sender: TObject);
var
  s: string;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') then
    clearAll()
  else
  begin
    if (histArea.Caption <> '') and (oprt.size > 0) then
    begin
      history.Push(strtofloat(calcArea.Caption));
      histArea.Caption := '';
      countResult(oprt.Get());
    end;
    if (history.size > 0) then
       calcArea.Caption := floattostr(history.Get());
  end;

end;

procedure TcalcForm.revBtnClick(Sender: TObject);
var
  s : string;
  num: double;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') then
    clearAll()
  else
  begin
    num := strToFloat(s);
    if (num <> 0) then
      s := floattostr(1 / num)
    else
      s := 'infinity';
    calcArea.Caption := s;
  end;
end;

procedure TcalcForm.sqrtOpBtnClick(Sender: TObject);
var
  s : string;
  num: double;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') then
    clearAll()
  else
  begin
    num := strToFloat(s);
    if (num >= 0) then
      s := floattostr(sqrt(num))
    else
      s := 'error';
    calcArea.Caption := s;
  end;

end;

procedure TcalcForm.oprtBtnClick(Sender: TObject);
var
  num: string;
  s, s1: string;
  sign: char;
begin
  s1 := calcArea.Caption;
  if (s1 = 'error') or (s1 = 'infinity') or (s1 = 'overflow') then
    clearAll()
  else
  begin
      s := (Sender as TButton).Caption;
      sign := s[1];
      num := s1;
      history.Push(strtofloat(num));
      histArea.Caption := histArea.Caption + num + s;
      if (oprt.size = 0) then
      begin
        oprt.Push(sign);
      end
      else
      begin
        countResult(oprt.Get());
        oprt.Pop();
        oprt.Push(sign);
      end;
      calcArea.Caption := '0';
  end;

end;

procedure TcalcForm.percBtnClick(Sender: TObject);
var
  a, b: double;
  s: string;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') then
    clearAll()
  else
  begin
    if (history.size = 0) then
      calcArea.Caption := '0'
    else
    begin
      a := history.Get();
      b := strtofloat(calcArea.Caption);
      calcArea.Caption := floattoStr((a / 100) * b);
    end;
  end;

end;


procedure TcalcForm.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = 08) then delEndBtnClick(delEndBtn);
   if (key = 107) or ((key = 187) and (ssShift in shift)) then oprtBtnClick(plusBtn);
   if (key = 106) or ((key = 56) and (ssShift in shift)) then oprtBtnClick(mulBtn);
   if (key = 111) or (key = 191) then oprtBtnClick(divBtn);
   if (key = 109) or (key = 189) then oprtBtnClick(subBtn);
   if (key = 188) then pointBtnClick(pointBtn);
   if (key = 187) and not(ssShift in shift) then resultBtnClick(resultBtn);
   if (key = 57) or (key = 105) then numBtnClick(numbtn_9);
   if (key = 56) and not(ssShift in shift) or (key = 104)  then numBtnClick(numbtn_8);
   if (key = 55) or (key = 103) then numBtnClick(numbtn_7);
   if (key = 54) or (key = 102) then numBtnClick(numbtn_6);
   if (key = 53) or (key = 101) then numBtnClick(numbtn_5);
   if (key = 52) or (key = 100) then numBtnClick(numbtn_4);
   if (key = 51) or (key = 99) then numBtnClick(numbtn_3);
   if (key = 50) or (key = 98) then numBtnClick(numbtn_2);
   if (key = 49) or (key = 97) then numBtnClick(numbtn_1);
   if (key = 48) or (key = 96) then numBtnClick(numbtn_0);
end;

procedure TcalcForm.numBtnClick(Sender: TObject);
var
  s: string;
begin
  if (oprt.size = 0) and (history.size = 1) then clearAll();
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') or (pos('E', s) <> 0) then
     clearAll();
  if (1.79769313486232E+308 >= strtofloat(calcArea.Caption)*10 + 10) and (length(calcArea.Caption) >= 1) and (calcArea.Caption <> '0') then
    calcArea.Caption := calcArea.Caption + (Sender as TButton).Caption;
  if (calcArea.Caption = '0') then
    calcArea.Caption := (Sender as TButton).Caption;
end;

procedure TcalcForm.delEndBtnClick(Sender: TObject);
var
  s: string;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') or (pos('E', s) <> 0) then
     clearAll();
  if (length(calcArea.Caption) = 1) then
    calcArea.Caption := '0'
  else
  begin
    s := calcArea.Caption;
    Delete(s, length(s), 1);
    calcArea.caption := s;
  end;
end;

procedure TcalcForm.binPowOpBtnClick(Sender: TObject);
var
  s : string;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') then
    clearAll()
  else
  begin
    if (sqrt(1.79769313486232E+308) > strToFloat(calcArea.Caption)) then
      calcArea.Caption := floattostr(sqr(strToFloat(calcArea.Caption)))
    else
      calcArea.Caption := 'overflow';
  end;
end;

procedure TcalcForm.clearAllBtnClick(Sender: TObject);
begin
  clearAll();
end;

procedure TcalcForm.clearLastBtnClick(Sender: TObject);
begin
  calcArea.Caption := '0';
end;

procedure TcalcForm.clearMemBtnClick(Sender: TObject);
begin
  while (memory.size > 0) do
    memory.Pop();
end;

procedure TcalcForm.invertSignBtnClick(Sender: TObject);
var
  s: string;
  num: double;
begin
  s := calcArea.Caption;
  if (s = 'error') or (s = 'infinity') or (s = 'overflow') or (pos('E', s) <> 0) then
     clearAll();
  num := strtofloat(calcArea.Caption);
  if (num <> 0) then
    num *= (-1);
  s := floattostr(num);
  calcArea.Caption := s;
end;

procedure TcalcForm.memAddBtnClick(Sender: TObject);
var
  a: double;
  s: string;
begin
  s := calcArea.Caption;
  if not ((s = 'error') or (s = 'infinity') or (s = 'overflow')) then
     clearAll();
  if (memory.size > 0) and(memory.Get() <= (1.79769313486232E+308 - strtofloat(calcArea.Caption))) then
  begin
    a := memory.Get();
    memory.Pop();
    memory.push(a + strtofloat(calcArea.Caption));
  end;
end;

procedure TcalcForm.memCallBtnClick(Sender: TObject);
var
  a: double;
begin
  if (memory.size > 0) then
  begin
    a := memory.Get();
    calcArea.Caption := floattostr(a);
  end;
end;

procedure TcalcForm.memPushBtnClick(Sender: TObject);
begin
  memory.Push(strtofloat(calcArea.Caption));
end;

procedure TcalcForm.memSubBtnClick(Sender: TObject);
var
  a: double;
begin
  if (memory.size > 0) then
  begin
    a := memory.Get();
    memory.Pop();
    memory.push(a - strtofloat(calcArea.Caption));
  end;
end;

begin
  history := TListStackOfFloat.Create();
  memory := TListStackOfFloat.Create();
  oprt := TListStackOfChar.Create();

end.
