import std/ [os, strformat]
import system

var cflags = staticExec("pkg-config --cflags sdl2 libserialport")

# nim suggest fix
if cflags.len == 0:
  cflags = "''"

var lflags = staticExec("pkg-config --libs sdl2 libserialport")

# nim suggest fix
if lflags.len == 0:
  lflags = "''"

switch("passC", cflags)
switch("passL", lflags)
switch("debugger", "native")
