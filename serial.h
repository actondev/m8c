// Copyright 2021 Jonne Kokkonen
// Released under the MIT licence, https://opensource.org/licenses/MIT

#ifndef _SERIAL_H_
#define _SERIAL_H_

#ifdef USE_LIBUSB
int init_serial_with_file_descriptor(int file_descriptor);
#else
#endif

int serial_init(int verbose);
int serial_check_connection();
int serial_reset_display();
int serial_enable_and_reset_display();
int serial_disconnect();
int serial_read(uint8_t *serial_buf, int count);
int serial_send_msg_controller(uint8_t input);
int serial_send_msg_keyjazz(uint8_t note, uint8_t velocity);

#endif
