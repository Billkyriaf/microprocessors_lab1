#include <stdio.h>
                                        
extern int* hash_function(int *hash_table, char *string, int *has_res);
int hash(int *hash_table, char *string);

int main(){
		// This is the hash table the function uses to convert the table
		int hash_table[26] = {10, 42, 12, 21, 7, 5, 67, 48, 69, 2, 36, 3, 19, 1, 14, 51, 71, 8, 26, 54, 75, 15, 6, 59, 13, 25};
		
		// This is the string to caclulate the hash from
		char string[] = {'V', 'L', 'a', 'B', ' ', '1', 'c', '@', 'D', '9', '!', 's', 'a', 'T', 'Y', 'O', 'p', '^', '.', 'A', 'Z', '\0'};
		
		int has_res;
		hash_function(hash_table, string, &has_res);
		printf("Ass function res: %d\n", has_res);
			
		printf("C function res: %d\n", hash(hash_table, string));		


    return (0);
}

int hash(int *hash_table, char *string){
		int i = 0;
		char c;
		int h = 0;
		do{
				c = string[i];
				if (c >= 65 && c <= 90){
					h = h + hash_table[c - 65];  // The hash table goes from 0 to 25. A is 65 in ascii so c - 65 gives the index of the lettern in the table
					
				} else if (c >= 48 && c <= 57){
					h = h - (c - 48);
				}
				
				i = i + 1;
		} while(c != '\0');
		
		return h;
}
