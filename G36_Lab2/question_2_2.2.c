/*Macro to get the size of the array.*/
#define ARRAY_SIZE(X) (sizeof(X)/sizeof(X[0]))

/*Extern to call subroutine in another file*/
extern int MAX_2(int x, int y);

int main(){
	int a, b,c;
	int array[5] = {1,20,3,4,5};
	int i;
	int max_val = 0;
	for(i = 0; i<ARRAY_SIZE(array);i++){
		max_val = MAX_2(array[i],max_val);
	}
	return max_val;
}
