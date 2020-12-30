program pastasks;
{$mode objfpc}

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

procedure setTaskIndex();
begin
  taskIndex := 0;
  while not eof(f) do
  begin
    read(f, Task);
    taskIndex := taskIndex + 1;
  end;
end;

procedure printOptions();
begin
  writeln('(a)dd task, (l)ist tasks, task (d)one, print (i)nfo, (q)uit');
end;

procedure addTask();
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

procedure listTasks();
begin
  writeln('you currently have ', taskIndex, ' tasks.');
  
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

procedure setTaskToDone();
var
  tmpTasks: array of TaskRecord;
  tmpIndex: integer;
  inp: integer;
  i: integer;
begin
  tmpIndex := 0;
  setlength(tmpTasks, taskIndex);

  write('nice, enter index of done task: ');
  readln(inp);

  reset(f);
  while not eof(f) do
  begin
    read(f, Task);

    if (Task.id = inp) then
    begin
      Task.done := true;
      writeln('task "', Task.title, '" done!');
    end;

    tmpTasks[tmpIndex].id := Task.id;
    tmpTasks[tmpIndex].title := Task.title;
    tmpTasks[tmpIndex].done := Task.done;

    tmpIndex := tmpIndex + 1;
  end;

  rewrite(f);
  for i := 0 to taskIndex - 1 do
  begin
    Task.id := tmpTasks[i].id;
    Task.title := tmpTasks[i].title;
    Task.done := tmpTasks[i].done;
    write(f, Task);
  end;
end;

procedure enterMainLoop();
begin
  repeat 
    readln(inp);
    case inp of
    'A','a':
      begin
        addTask();
      end;
    'l', 'L':
      begin
        listTasks();
      end;
    'd', 'D':
      begin
        setTaskToDone();
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
