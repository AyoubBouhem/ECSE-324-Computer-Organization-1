//#include <stdio.h>

//Macro to get the size of the array
#define ARRAY_SIZE(X) (sizeof(X)/sizeof(X[0]))

//Prototyping our function
int maxValOfArray(int array[], int n);

int main()
{
	int a[5] = {1,20,3,4,5};
	int size = ARRAY_SIZE(a);	
	int max_val = maxValOfArray(a,size);
	return max_val;
}


int maxValOfArray(int array[], int n)
{
	//We implement a simple bubble sort to get the maximum value of the array
	int a, b, temp;
	//Outer loop
	for(a=0;a<n-1;a++)
	{
		//Inner loop
		for(b=a;b<n;b++)
		{	
			//if current value greater
			if(array[a]>array[b])
			{
				//do swap
				temp = array[b];
				array[b] = array[a];
				array[a] = temp;
			}
		}
	}
	//last element of the array
	return array[n-1];
}
