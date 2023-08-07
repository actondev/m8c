import std/ [os, strformat]
import system

let cflags = staticExec("pkg-config --cflags sdl2 libserialport")
switch("passC", cflags)

let lflags = staticExec("pkg-config --libs sdl2 libserialport")
switch("passL", lflags)
