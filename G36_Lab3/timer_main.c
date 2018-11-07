/*This is the main function for our polling based stopwatch*/

#include <stdio.h>
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/pushbuttons.h"


int main(){
	/*count variables map to the seconds, milliseconds, hours and mins etc that we ultimately display on the HEX displays*/
	int count0 = 0, count1=0,count2=0,count3=0,count4=0,count5=0;
	
	/*Setting our HPS_TIM_config_t struct t0 which is our main timer*/
	/*We give it a timeout of 10 ms, and set all of its field to 0 initially because we do not start it until PB0 is pressed*/
	HPS_TIM_config_t t0;
	t0.tim = TIM0;
	t0.timeout = 10000;	
	t0.LD_en = 0;
	t0.INT_en = 0;
	t0.enable = 0;
	HPS_TIM_config_ASM(&t0);
	
	/*Setting our HPS_TIM_config_t struct poll which is used to poll the edgecapture registers*/
	/*We give it a value of 5ms to poll the edgecapture registers*/
	HPS_TIM_config_t poll;
	poll.tim = TIM1;
	poll.timeout = 5000;	
	poll.LD_en = 1;
	poll.INT_en = 1;
	poll.enable = 1;
	HPS_TIM_config_ASM(&poll);

	while(1){
		/*Begin polling the edgcapture registers*/
		if(HPS_TIM_read_INT_ASM(poll.tim)){
			HPS_TIM_clear_INT_ASM(poll.tim);
				/*Take whatever the user has pressed and check which specific button it is*/
				int button = read_PB_edgecap_ASM();
				/*If button greater than 1, check which button it specifically is*/
				if(button >=1){
					/*PB0, than begin timer and enable everything*/
					if(PB_edgecap_is_pressed_ASM(PB0)){
						t0.LD_en = 1;
						t0.INT_en = 1;
						t0.enable = 1;
						HPS_TIM_config_ASM(&t0);
					}
					/*PB2, basically kill the stopwatch, flood everything and reset all counts to 0*/
					if(PB_edgecap_is_pressed_ASM(PB2)){
						t0.LD_en = 0;
						t0.INT_en = 0;
						t0.enable = 0;
						HPS_TIM_config_ASM(&t0);
						if(HPS_TIM_read_INT_ASM(t0.tim) == 0){
							HEX_flood_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);				
						}
						count0 = 0, count1=0,count2=0,count3=0,count4=0,count5=0;
					}
					/*PB1, pause, do not clear*/
					if(PB_edgecap_is_pressed_ASM(PB1)){
						t0.LD_en = 0;
						t0.INT_en = 0;
						t0.enable = 0;
						HPS_TIM_config_ASM(&t0);
					}
					PB_clear_edgecp_ASM(15);
				}
			}	//Begin stop watch and write time values to specific HEX displays
				if(HPS_TIM_read_INT_ASM(t0.tim)){
					HPS_TIM_clear_INT_ASM(t0.tim);
					if(++count0 == 10){
						count0 = 0;
						if(++count1==10){
							count1=0;
							if(++count2==10){
								count2=0;
								if(++count3==6){
									count3=0;
									if(++count4==10){
										count4 = 0;
										if(++count5==6){
											count5=0;
										}
									}
								}
							}
						}
					}
					HEX_write_ASM(HEX5,count5);
					HEX_write_ASM(HEX4,count4);
					HEX_write_ASM(HEX3,count3);
					HEX_write_ASM(HEX2,count2);
					HEX_write_ASM(HEX1,count1);
					HEX_write_ASM(HEX0,count0);
				}
			}
	return 0;
}
