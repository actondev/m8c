#pragma once

typedef int (m8_init)(int verbose);
typedef int (m8_check_connection)();
typedef int (m8_reset_display)();
typedef int (m8_enable_and_reset_display)();
typedef int (m8_disconnect)();
typedef int (m8_read)(uint8_t *serial_buf, int count);
typedef int (m8_send_msg_controller)(uint8_t input);
typedef int (m8_send_msg_keyjazz)(uint8_t note, uint8_t velocity);

typedef struct {
  m8_init *init;
  m8_check_connection *check_connection;
  m8_reset_display *reset_display;
  m8_enable_and_reset_display *enable_and_reset_display;
  m8_disconnect *disconnect;
  m8_read *read;
  m8_send_msg_controller *send_msg_controller;
  m8_send_msg_keyjazz *send_msg_keyjazz;
} M8;

