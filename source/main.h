//#define FB_RUN
//#define FB_DEBUG
//#define PC_RUN
//#define PC_DEBUG

#ifdef FB_RUN
#define FB
#endif /* FB_RUN */

#ifdef FB_DEBUG
#define FB
#define PRINT_LED_STATUS
#define PRINT_TIMESTAMP
#endif /* FB_DEBUG */

#ifdef PC_RUN
#define PRINT_LED_STATUS
#endif /* PC_RUN */

#ifdef PC_DEBUG
#define PRINT_LED_STATUS
#define PRINT_TIMESTAMP
#endif /* PC_DEBUG */

#ifdef FB
#define CLK_FREQ 2000000
#else
#define CLK_FREQ 4000000000
#endif /* FB */

#define MAX_CYCLES 1
#define DELAY_CNT  20                    //number of states
#define MS_TO_TICKS(x) (uint32_t)((CLK_FREQ / 1000) * x)
