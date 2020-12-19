program pastasks;

var
  todos: array [0..100, 0..1] of string; (* 0: text, 1: status (do, done) *)
  inp: string;
  todoText: string;
  todoIndex: integer;

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
begin
  write('what to you want to do? ');
  readln(todoText);
  todos[todoIndex][0] := todoText;
  todos[todoIndex][1] := 'do';
  todoIndex := todoIndex + 1;
  writeln('"', todoText, '" added.');
end;

procedure listTodos();
var
  i: integer;
begin
  writeln('you currently have ', todoIndex, ' todos.');
  if todoIndex > 0 then
    begin
      for i := 0 to todoIndex - 1 do
        if todos[i][1] = 'do' then
          begin
            writeln('[', i, ']: ', todos[i][0]);
          end
        else 
          writeln('[', i, ']: ', todos[i][0], ' (', todos[i][1], ')');
    end
end;

procedure setTodoToDone();
var
  i: integer;
begin
  listTodos();
  write('enter index of done task: ');
  readln(i);
  todos[i][1] := 'done';
  writeln('task set to done');
end;

procedure enterMainLoop();
begin
  repeat 
    readln(inp);
    if (inp = 'a') then
      begin
        addTodo();
      end
    else if (inp = 'l') then
      begin
        listTodos();
      end
    else if (inp = 'd') then
      begin
        setTodoToDone();
      end
    else if (inp = 'i') then
      begin
        printOptions();
      end
    else if (inp = 'q') then
      begin
        writeln('dying ...');
      end
    else
        writeln('i do not understand ...');
        todos[todoIndex][1] := 'do';
  until inp = 'q';
end;

begin
  todoIndex := 0;

  printTitle();
  printOptions();
  writeln;
  enterMainLoop();
end.
