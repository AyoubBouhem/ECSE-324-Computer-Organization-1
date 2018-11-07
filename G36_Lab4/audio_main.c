#include <stdio.h>
#include "./drivers/inc/audio.h"

/*Number of 1's and 0's to write
48000/(2*100)*/
int main() {
	int i = 0; //counter for 1's
	//int j = 0; //counter for 0's
	while(1) {
		while(i<240) {
			//if i has not hit 240,
			//we keep on writing 1
			if(audio(0x00FFFFFF)) {
				i++;
			}
		}
		//if j has not hit 240,
		//we keep on writing 0
		i = 0; //test1
		while(i<240) {
			if(audio(0x00000000)) {
				i++;
			}
		}
		//reset i and j, and cycle
		i = 0; //reset again
		/*if(i == 240){
			i = 0;
		}*/
	}
	return 0;
}
