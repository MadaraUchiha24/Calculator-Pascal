//Текущий модуль содержит классы для работы со стеком и очередью на основе массивов и связных списков;
//TODO: Требуется дописать реализацию отдельных методов!

unit ClassStruct;

{$mode objfpc}
{$inline on}

interface

type                      	//Тип элемента структуры;

	PListNodeChar = ^TListNodeChar;
        TListNodeChar = record
          Next: PListNodeChar;
          Data: Char;
        end;

        PListNodeFloat = ^TListNodeFloat;
        TListNodeFloat = record
          Next: PListNodeFloat;
          Data: extended;
        end;

	//Абстрактный класс для стека и очереди:
	TClassStruct = class
	protected
		_size: dword;	//Общее число элементов;
	public
		//Выполняет проверку на пустоту:
		function Empty(): boolean; inline;
		//Возвращает число элементов:
		property size: dword read _size;
	end;


	//Класс стека на основе связного списка:
	TListStackofFloat = class(TClassStruct)
	private
		head : PListNodeFloat;
	public
		//Переопределение методов базового класса:
		function Push(const data: extended): boolean;
		function Pop(): boolean;
		function Get(): extended;
		//Конструктор класса:
		constructor Create();
		//Деструктор класса:
		destructor Destroy(); override;
	end;

       //Класс стека на основе связного списка:
	TListStackofChar = class(TClassStruct)
	private
		head : PListNodeChar;
	public
		//Переопределение методов базового класса:
		function Push(const data: char): boolean;
		function Pop(): boolean;
		function Get(): char;
		//Конструктор класса:
		constructor Create();
		//Деструктор класса:
		destructor Destroy(); override;
	end;


implementation

{-TClassStruct-}

function TClassStruct.Empty(): boolean; inline;
begin
	exit(_size = 0);
end;

{-TListStackofFloat-}

function TListStackofFloat.Push(const data: extended): boolean;
var
	node : PListNodeFloat;
begin
	new(node);
	if (node = nil) then exit(false);
	node^.data := data;
	node^.next := head;
	head := node;
	_size += 1;
	exit(true);
end;

function TListStackofFloat.Pop(): boolean;
var
	node : PListNodeFloat;
begin
	if (head = nil) then exit(false);
	node := head;
	head := head^.next;
	_size -= 1;
	dispose(node);
	exit(true);
end;

function TListStackofFloat.Get(): extended;
begin
	exit(head^.data);
end;

constructor TListStackofFloat.Create();
begin
	head := nil;
	_size := 0;
end;

destructor TListStackofFloat.Destroy();
begin
	while (head <> nil) do
		Pop();
end;

{-TListStackChar-}
function TListStackofChar.Push(const data: char): boolean;
var
	node : PListNodeChar;
begin
	new(node);
	if (node = nil) then exit(false);
	node^.data := data;
	node^.next := head;
	head := node;
	_size += 1;
	exit(true);
end;

function TListStackofChar.Pop(): boolean;
var
	node : PListNodeChar;
begin
	if (head = nil) then exit(false);
	node := head;
	head := head^.next;
	_size -= 1;
	dispose(node);
	exit(true);
end;

function TListStackofChar.Get(): Char;
begin
	exit(head^.data);
end;

constructor TListStackofChar.Create();
begin
	head := nil;
	_size := 0;
end;

destructor TListStackofChar.Destroy();
begin
	while (head <> nil) do
		Pop();
end;


end.
