{.compile: "audio.c" .}
{.compile: "command.c" .}
{.compile: "config.c" .}
{.compile: "fx_cube.c" .}
{.compile: "ini.c" .}
{.compile: "inprint2.c" .}
{.compile: "input.c" .}
{.compile: "main.c" .}
{.compile: "render.c" .}
{.compile: "ringbuffer.c" .}
{.compile: "serial.c" .}
{.compile: "slip.c" .}
# {.compile: "usb.c" .}
{.compile: "usb_audio.c" .}

import net
discard type(net_init) is int # hack to disable warnings

# # echo "m8c.nim init"
# # discard net_init(0.cint)

proc cmain(arc: cint, argv: ptr UncheckedArray[cstring]) {.header: "main.h", importc: "cmain" .}

cmain(0, nil)
