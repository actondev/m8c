import types
import std/net

let socket = newSocket(buffered=true)

proc net_init*(verbose: cint): cint {.exportc.} =
  echo "net_init.."
  try:
    # TODO pass argument
    socket.connect("localhost", port = Port(1234))
  except CatchableError:
    result = 0
    echo "error ", getCurrentExceptionMsg()
  result = 1

proc net_check_connection*(): cint {.exportc.} =
  result = 1
  # TODO how can I check if we're connected?

proc net_reset_display*(): cint {.exportc.} =
  echo "net_reset display"
  try:
    socket.send("R")
  except CatchableError:
    echo "error ", getCurrentExceptionMsg()
  result = 1

proc net_enable_and_reset_display*(): cint {.exportc.} =
  echo "net_enable_and_reset_display"
  try:
    socket.send("E")
  except CatchableError:
    echo "error ", getCurrentExceptionMsg()
    return 0
  result = net_reset_display()

proc net_disconnect*(): cint {.exportc.} =
  try:
    socket.close()
    result = 1
  except CatchableError:
    result = 0

  echo "net_disconnect ", result

proc net_read*(serial_buf: ptr uint8; count: cint): cint {.exportc.} =
  try:
    while result < count:
      result += socket.recv(cast[pointer](cast[int](serial_buf) + result), 1, timeout = 5).cint
  except CatchableError:
    discard

proc net_send_msg_controller*(input: uint8): cint {.exportc.} =
  let data: array[2, uint8] = ['C'.uint8, input]
  try:
    discard socket.send(data.addr, 2)
    echo "ok sent ", data
    result = 1
  except CatchableError:
    echo "send error ", getCurrentExceptionMsg()
    result = -1

proc net_send_msg_keyjazz*(note: uint8; velocity: uint8): cint {.exportc.} =
  let velocity = min(velocity, 0x7F)
  let data: array[3, uint8] = ['K'.uint8, note, velocity]
  try:
    discard socket.send(data.addr, 3)
    echo "ok sent ", data
    result = 1
  except CatchableError:
    echo "send error ", getCurrentExceptionMsg()
    result = -1


