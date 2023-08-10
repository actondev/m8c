#pragma once

int net_init(int verbose);
int net_check_connection();
int net_reset_display();
int net_enable_and_reset_display();
int net_disconnect();
int net_read(uint8_t *buf, int count);
int net_send_msg_controller(uint8_t input);
int net_send_msg_keyjazz(uint8_t note, uint8_t velocity);
