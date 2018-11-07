#include <stdlib.h>

#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"
void drawWelcome();
int i = 0;
//base colour we start off with
short colour = 255;
//an integer array that takes the keys that the user entered
int notesPlayed[8] = {};
//a char array that displays the notes played 
char displayNotes[8] = {};
//array holding the frequencies, index matched to the keys pressed
float frequencies[] = {130.813, 146.832, 164.814, 174.614, 195.998, 220.000, 246.942, 261.626};

void displayNotesPlayed(int xPos, char notes){
	int i = 0;
	VGA_write_char_ASM(xPos,59,notes);
}
// Get the sample based on the frequency and the "index"
// Returns double: signal
double getSample(float freq, int t) {
	double signal = 0.0;
	int index = ((int)freq*t)%48000;
	float difference  = (freq*t)-index;
	if(difference = 0){
		signal = sine[index];
	}else{
		signal = (1.0 - difference) * sine[index] + difference * sine[index + 1]; 
	}
	return signal;
}

//This generates the signal from the samples
double makeSignal(int* notePlayed, int t){
	int i;
	double sumOfSamples = 0.0;
	
	//cycle through the notes the user entered
	for(i = 0;i<8;i++){
		//check if user entered a note, if so, add it
		if(notePlayed[i] == 1){
			sumOfSamples += getSample(frequencies[i],t);
		}
	}
	return sumOfSamples;
}

// Write names at the top of the screen
void drawWelcome(){
	//Screen is 79 x 59
	VGA_write_char_ASM(34, 2, 'E');
	VGA_write_char_ASM(35, 2, 'C');
	VGA_write_char_ASM(36, 2, 'S');
	VGA_write_char_ASM(37, 2, 'E');

	VGA_write_char_ASM(38, 2, ' ');

	VGA_write_char_ASM(39, 2, '3');
	VGA_write_char_ASM(40, 2, '2');
	VGA_write_char_ASM(41, 2, '4');

	VGA_write_char_ASM(42, 2, ' ');

	VGA_write_char_ASM(43, 2, 'L');
	VGA_write_char_ASM(44, 2, 'A');
	VGA_write_char_ASM(45, 2, 'B');
	VGA_write_char_ASM(46, 2, '#');
	VGA_write_char_ASM(47, 2, '5');

}

void drawWords(){

	VGA_write_char_ASM(70, 59, 'V');
	VGA_write_char_ASM(71, 59, 'O');
	VGA_write_char_ASM(72, 59, 'L');
	VGA_write_char_ASM(73, 59, 'U');
	VGA_write_char_ASM(74, 59, 'M');
	VGA_write_char_ASM(75, 59, 'E');
	VGA_write_char_ASM(76, 59, ':');

}
int x;
int main() {
	// Setup timer
	VGA_clear_pixelbuff_ASM();
	int_setup(1, (int []){199});
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0; //microsecond timer
	hps_tim.timeout = 20; //1/48000 = 20.8
	hps_tim.LD_en = 1; // initial count value
	hps_tim.INT_en = 1; //enabling the interrupt
	hps_tim.enable = 1; //enable bit to 1

	HPS_TIM_config_ASM(&hps_tim);
	
	//These two variables act as flags
	//keyReleased checks if a key is not pressed
	//keyPressed checks if a key is pressed 	
	char keyPressed = 1;
	// counter for signal
	int t = 0;
	// to store the previous set of drawn points for quicker clearing
	double old_wave[320] = { 0 };
	//double valToDraw = 0;

	char value;

	char amplitude = 1;
	double signalSum = 0.0;
	drawWelcome();
	drawWords();
	while(1) {
			if(read_slider_switches_ASM()!=0){
				//we check keys
				if(read_ps2_data_ASM(&value)){
					switch(value){
						case 0x1C:
						if(keyPressed == 1){
							notesPlayed[0] = 1;
							displayNotes[0] = 'C';
							//colour += 500;
							//keyPressed = 0; //tester
						}else{
							notesPlayed[0] = 0;
							keyPressed = 1;
							displayNotes[0] = ' ';
						}break;
						case 0x1B:
						if(keyPressed == 1){
							notesPlayed[1] = 1;
							displayNotes[1] = 'D';
							//colour += 500;
							//keyPressed = 0;
						}else{
							notesPlayed[1] = 0;
							keyPressed = 1;
							displayNotes[1] = ' ';
						}break;
						case 0x23:
						if(keyPressed == 1){
							notesPlayed[2] = 1;
							displayNotes[2] = 'E';
							//colour += 500;
							//keyPressed = 0;
						}else{
							notesPlayed[2] = 0;
							keyPressed = 1;
							displayNotes[2] = ' ';
						}break;
						case 0x2B:
						if(keyPressed == 1){
							notesPlayed[3] = 1;
							displayNotes[3] = 'F';
							//colour += 500;
							//keyPressed = 0;
						}else{
							notesPlayed[3] = 0;
							keyPressed = 1;
							displayNotes[3] = ' ';
						}break;
						case 0x3B:
						if(keyPressed == 1){
							notesPlayed[4] = 1;
							displayNotes[4] = 'G';
							//colour += 500;
							//keyPressed = 0;
						}else{
							notesPlayed[4] = 0;
							keyPressed = 1;
							displayNotes[4] = ' ';
						}break;
						case 0x42:
						if(keyPressed == 1){
							notesPlayed[5] = 1;
							displayNotes[5] = 'A';
							//colour += 500;
							//keyPressed = 0;
						}else{
							notesPlayed[5] = 0;
							keyPressed = 1;
							displayNotes[5] = ' ';
						}break;
						case 0x4B:
						if(keyPressed == 1){
							notesPlayed[6] = 1;
							displayNotes[6] = 'B';
							//colour += 500;
							//keyPressed = 0;
						}else{
							notesPlayed[6] = 0;
							keyPressed = 1;
							displayNotes[6] = ' ';
						}break;
						case 0x4C:
						if(keyPressed == 1){
							notesPlayed[7] = 1;
							displayNotes[7] = 'C';
							//colour += 500;
							//keyPressed = 0;
						}else{
							notesPlayed[7] = 0;
							keyPressed = 1;
							displayNotes[7] = ' ';
						}break;
						case 0xF0:
							keyPressed = 0;
							break;
						case 0x43: //increase sound with key 'I'
						if(keyPressed ==1){
							if(amplitude <10){
								amplitude++;
							}
						}break;
						case 0x2D: //Decrease sound with key 'R'
						if(keyPressed == 1){
							if(amplitude !=0){
								amplitude--;
							}
						}
						default:
							keyPressed = 0;
					}
				}
			}
			signalSum = makeSignal(notesPlayed, t); //generate the signal at this t based on what keys were pressed

			signalSum = amplitude * signalSum; //this is volume control
			/*int i = 0;*/
			/*for(i=0;i<8;i++){
				displayNotesPlayed(i,displayNotes[i]);
			}*/
			// Every 20 microseconds this flag goes high
			if(hps_tim0_int_flag == 1) {
				hps_tim0_int_flag = 0;
				audio_write_data_ASM(signalSum, signalSum);
				t++;
			}

			int drawIndex = 0;
			double valToDraw = 0;
			// To reduce the number of drawing operations
			if((t%10 == 0)){
				//draw volume number in bottom right
				if(amplitude == 10){
					VGA_write_byte_ASM(78, 59, 16);
				} else {
					//volume = 0-9
					VGA_write_byte_ASM(78, 59, amplitude);
				}

				drawIndex = (t/10)%320;
				//clear drawn points
				VGA_draw_point_ASM(drawIndex, old_wave[drawIndex], 0);
				//120 centers the signal on the screen, 500000 is abitrary to make it fit
				valToDraw = 120 + signalSum/500000;
				//add new points to history array
				old_wave[drawIndex] = valToDraw;
				//draw new points
				VGA_draw_point_ASM(drawIndex, valToDraw, colour);
				colour += 500;
			}
			
			// Reset the signal
			signalSum = 0;
			// Reset the counter
			if(t==48000){
				t=0;
			}
		
	}

	return 0;
}
