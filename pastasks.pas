program pastasks;
{$MODE OBJFPC}

uses sysutils;

const
  SAVEFILE = 'pastasks.dat';

type
  TaskRecord = record
    id: integer;
    title: string;
    done: boolean;
  end;

var
  todos: array [0..100, 0..1] of string; (* 0: text, 1: status (do, done) *)
  inp: string;
  taskIndex: integer;
  Task: TaskRecord;
  f: file of TaskRecord;

procedure printTitle();
begin
  writeln('--------');
  writeln('pastasks');
  writeln('--------');
end;

procedure printOptions();
begin
  writeln('(a)dd todo, (l)ist todos, task (d)one, print (i)nfo, (q)uit');
end;

procedure addTodo();
var 
  inp: string;
begin
  write('what to you want to do? ');
  readln(inp);

  Task.id := taskIndex;
  Task.title := inp;
  Task.done := false;
  write(f, Task);

  taskIndex := taskIndex + 1;
  writeln('"', Task.title, '" added.');
end;

procedure listTodos();
begin
  writeln('you currently have ', taskIndex, ' todos.');
  
  reset(f);
  while not eof(f) do
  begin
    read(f, Task);
    if Task.done then
      writeln('[', Task.id, ']: ', Task.title, ' (done)')
    else
      writeln('[', Task.id, ']: ', Task.title);
  end;
end;

procedure setTodoToDone();
var
  i: integer;
  taskFound: boolean;
begin
  taskFound := false;

  listTodos();
  write('enter index of done task: ');
  readln(i);
  while not eof(f) do
  begin
    read(f, Task);
    if (Task.id = i) then
      Task.done := true;
      taskFound := true;
      write(f, Task);
  end;
end;

procedure setTaskIndex();
begin
  taskIndex := 0;
  while not eof(f) do
  begin
    read(f, Task);
    taskIndex := taskIndex + 1;
    writeln('new task index: ', taskIndex);
  end;
end;

procedure enterMainLoop();
begin
  repeat 
    readln(inp);
    case inp of
    'A','a':
      begin
        addTodo();
      end;
    'l', 'L':
      begin
        listTodos();
      end;
    'd', 'D':
      begin
        setTodoToDone();
      end;
    'i', 'I':
      begin
        printOptions();
      end;
    'q', 'Q':
      begin
        writeln('dying ...');
      end;
    else if (inp = 'q') then
      begin
        writeln('dying ...');
      end
    else
      begin
        writeln('i do not understand ...');
      end;
    end;
  until inp = 'q';
end;

begin
  assign(f, SAVEFILE);
  try
    reset(f, 1)
  except
    begin
      rewrite(f);
    end;
  end;
  setTaskIndex();
  seek(f, filesize(f)); { move pointer to the end of the file }

  printTitle();
  printOptions();
  writeln;
  enterMainLoop();

  close(f);
end.
