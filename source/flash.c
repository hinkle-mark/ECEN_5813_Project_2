#include <flash.h>
#include <main.h>

#if defined(FB_DEBUG) || defined(FB_RUN)
#include "fsl_gpio.h"
#include "board.h"
#endif

void delayMS(uint16_t delay)
{
	for(uint32_t i = 0; i < MS_TO_TICKS(delay); i++)
	{
		__asm volatile ("nop");
	}
}

void ledShiftState(volatile led_color * color, volatile uint8_t * cycle_cnt, uint16_t delay_time)
{
	if((*cycle_cnt) == (CYCLE_PERIOD - 1))
	{
		*color = ((*color + 1) % 3);           //shift to next LED state
#ifdef FB
		LED_RED_OFF();
		LED_BLUE_OFF();
		LED_GREEN_OFF();
#endif
	}

	switch ((uint8_t)*color)
	{
	case red:
#ifdef FB
		LED_RED_TOGGLE();
#endif /* FB */

#ifdef PRINT_LED_STATUS
		if((*cycle_cnt) % 2)  printf("LED RED OFF");
		else                  printf("LED RED ON");
#ifdef PRINT_TIMESTAMP
		printf(" %d\n", delay_time);
#else
		printf("\n");
#endif /* PRINT_TIMESTAMP */
#endif /* PRINT_LED_STATUS */
		break;

	case blue:
#ifdef FB
		LED_BLUE_TOGGLE();
#endif /* FB */

#ifdef PRINT_LED_STATUS
		if((*cycle_cnt) % 2)  printf("LED BLUE OFF");
		else                  printf("LED BLUE ON");
#ifdef PRINT_TIMESTAMP
		printf(" %d\n", delay_time);
#else
		printf("\n");
#endif /* PRINT_TIMESTAMP */
#endif /* PRINT_LED_STATUS */
		break;

	case green:
#ifdef FB
		LED_GREEN_TOGGLE();
#endif /* FB */

#ifdef PRINT_LED_STATUS
		if((*cycle_cnt) % 2)  printf("LED GREEN OFF");
		else                  printf("LED GREEN ON");
#ifdef PRINT_TIMESTAMP
		printf(" %d\n", delay_time);
#else
		printf("\n");
#endif /* PRINT_TIMESTAMP */
#endif /* PRINT_LED_STATUS */
		break;
	}

	*cycle_cnt = (*cycle_cnt + 1) % CYCLE_PERIOD;

	/* Wait */
    delayMS(delay_time);
}

