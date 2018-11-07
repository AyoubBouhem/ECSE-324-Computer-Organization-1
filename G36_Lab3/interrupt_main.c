#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/pushbuttons.h"

int main(){
	/*Set up which devices will send interrupts*/
	int device[] = {73, 199};
	int_setup(2, device);
	int count0 = 0, count1=0,count2=0,count3=0,count4=0,count5=0;
	
	/*Main timer t0, INT field set to 0 initially*/
	HPS_TIM_config_t t0;
	t0.tim = TIM0;
	t0.timeout = 10000;	
	t0.LD_en = 1;
	t0.INT_en = 0;
	t0.enable = 1;
	HPS_TIM_config_ASM(&t0);
	
	/*Enable interrupts for push buttons*/
	enable_PB_INT_ASM(PB0|PB2|PB1);
	/*Flag set to 4 initially*/
	/*PB_int_flag is the flag that sets the ISRs for the pushbuttons*/
	PB_int_flag = 4;

	while(1){
		/*Anytime the PB_int_flag is true, we execute the ISR for the respective push button*/
		if(PB_int_flag >= 0){
			/*If 0 we commence the timer*/
			if(PB_int_flag == 0){
					t0.LD_en = 1;
					t0.INT_en = 1;
					t0.enable = 1;
					HPS_TIM_config_ASM(&t0);
					PB_int_flag = 4; //4 resets the PB_int_flag
				}
				/*If 2, we simply kill the timer*/
				if(PB_int_flag == 2){
					t0.LD_en = 0;
					t0.INT_en = 0;
					t0.enable = 0;
					HPS_TIM_config_ASM(&t0);
					if(HPS_TIM_read_INT_ASM(t0.tim) == 0){
						HEX_flood_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);				
					}
					count0 = 0, count1=0,count2=0,count3=0,count4=0,count5=0;
					PB_int_flag = 4; //again we reset the PB_int_flag again
				}
				/*Pause*/
				if(PB_int_flag == 1){
					t0.LD_en = 0;
					t0.INT_en = 0;
					t0.enable = 0;
					HPS_TIM_config_ASM(&t0);
				}
			}		/*We set the timer for the hps_tim0_int_flag*/
					if(hps_tim0_int_flag){
					hps_tim0_int_flag = 0;
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
