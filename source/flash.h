#include <stdint.h>
#include <stdio.h>

#define CYCLE_PERIOD     6

typedef enum {
	red,
	blue,
	green
} led_color;

void delayMS(uint16_t delay);
void initLEDs(void);
void ledShiftState(volatile led_color * color, volatile uint8_t * cycle_cnt, uint16_t delay_time);

