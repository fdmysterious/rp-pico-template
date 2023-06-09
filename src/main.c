#include <stdio.h>

#include "pico/stdlib.h"
#include "pico/time.h"


/* -------------- main program */

int main()
{
	const uint LED_PIN = 15;

	stdio_init_all();

	gpio_init(LED_PIN);
	gpio_set_dir(LED_PIN, GPIO_OUT);

    while (true) {
		printf("Hello, world!\r\n");

		gpio_put(LED_PIN, 1);
		sleep_ms(100);
		gpio_put(LED_PIN, 0);
		sleep_ms(100);
	}

	return 0;
}
