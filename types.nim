type
  m8_init* = proc (verbose: cint): cint
  m8_check_connection* = proc (): cint
  m8_reset_display* = proc (): cint
  m8_enable_and_reset_display* = proc (): cint
  m8_disconnect* = proc (): cint
  m8_read* = proc (serial_buf: ptr uint8; count: cint): cint
  m8_send_msg_controller* = proc (input: uint8): cint
  m8_send_msg_keyjazz* = proc (note: uint8; velocity: uint8): cint
  M8* {.importc: "M8", header: "types.h", bycopy.} = object
    init* {.importc: "init".}: m8_init
    check_connection* {.importc: "check_connection".}: m8_check_connection
    reset_display* {.importc: "reset_display".}: m8_reset_display
    enable_and_reset_display* {.importc: "enable_and_reset_display".}: m8_enable_and_reset_display
    disconnect* {.importc: "disconnect".}: m8_disconnect
    read* {.importc: "read".}: m8_read
    send_msg_controller* {.importc: "send_msg_controller".}: m8_send_msg_controller
    send_msg_keyjazz* {.importc: "send_msg_keyjazz".}: m8_send_msg_keyjazz

