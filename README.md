# pastasks

[!pasta](pasta.png)

simple todo app written in pascal for learning purpose.

## requirements

```
sudo apt install \
  fp-compiler \
  make
```

## build

just `cd` to pastasks and do a `make`.

## how does it look like?

```
--------
pastasks
--------
(a)dd todo, (l)ist todos, task (d)one, print (i)nfo, (q)uit

a         
what to you want to do? feed the kitten!!!
"feed the kitten!!!" added.
a
what to you want to do? buy new clothes
"buy new clothes" added.
l
you currently have 2 todos.
[0]: feed the kitten!!!
[1]: buy new clothes
d
you currently have 2 todos.
[0]: feed the kitten!!!
[1]: buy new clothes
enter index of done task: 1
task set to done
l
you currently have 2 todos.
[0]: feed the kitten!!!
[1]: buy new clothes (done)
q
dying ...
```
