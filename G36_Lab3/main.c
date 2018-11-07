#include <stdio.h>

#include "./drivers/inc/leds.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"

int main() {
	/*Flood HEX4 and HEX5*/
	HEX_flood_ASM(HEX4|HEX5);
	/*We clear the remaining HEX displays to make sure they are cleared before we write to them*/
	HEX_clear_ASM(HEX0|HEX1|HEX2|HEX3);
	while(1){
		/*Slider states dictate the number we ultimately display on the screen*/
		int slider = read_slider_switches_ASM();
		/*512 maps to slider no.9 which simply clears every HEX display save for 4 and 5*/
		if(slider>=512){
			HEX_clear_ASM(HEX0|HEX1|HEX2|HEX3);	
			}
		else{
			/*Go HEX display by display in a switch statement*/
			HEX_t hex;
			switch(read_PB_data_ASM()){
				case 0x00000001:
					/*this means HEX0 is pressed, simply write the slider values to that display*/
					hex = HEX0;
					HEX_write_ASM(hex,slider);
					break;
				/*this means HEX1 is pressed, simply write the slider values to that display*/
				case 0x00000002:
					hex = HEX1;
					HEX_write_ASM(hex,slider);
					break;
				/*this means HEX2 is pressed, simply write the slider values to that display*/
				case 0x00000004:
					hex = HEX2;
					HEX_write_ASM(hex,slider);
					break;
				/*this means HEX3 is pressed, simply write the slider values to that display*/				
				case 0x00000008:
					hex = HEX3;
					HEX_write_ASM(hex,slider);
					break;
			}
		}
	}
	return 0;
}
