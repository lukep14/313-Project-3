#include <stdio.h> // IO library
#include <stdlib.h> //for exit
#include <stdint.h> //for integer types

int main(void){

  char *filepath = "binary.out"; //file that we are opening
  char buffer[1024 * 500] = {};        //create a 500kb buffer

  FILE *f = fopen(filepath, "r");   //open the file
  if (f == NULL){                   //file doesnt exist? throw error and exit
    fprintf(stderr, "[ERROR]: could not open the file '%s'!\n", filepath);
    exit(1);
  }

  size_t file_size;        //create file size variable
  fseek(f, 0L, SEEK_END);  //advance pointer to EOF
  file_size = ftell(f);    //get position and store into file_size
  fseek(f, 0L, SEEK_SET);  //return pointer to beginning for processing

  fread(buffer, sizeof(char), file_size, f); //fill the buffer with data! 
  fclose(f);  //close file because data is already stored into buffer

  uint8_t *data = buffer; //cast buffer to uint8_t so printf can print out ascii
  size_t i;  //outer loop index
  size_t j; //inner loop index

  for (i = 0; i < file_size; i++){
    uint8_t byte = data[i]; //grab the data at i's position

    if ((i % 16) == 0){     //display register per row 
      printf("%08x  ", i);  
    }

    printf("%02x ", byte); //print actual data as hex
    if ((i == file_size - 1) || ((i % 16) == 15)){ //if we've reached EOF or end of row
      printf(" |");
      for (j = (i - (i % 16)); j <= i; j++){   //mini loop to print out ascii conversions
	uint8_t ascii = data[j];

	if (((ascii) > 31) && ((ascii) < 127)){ //determining if its printable or not
	  printf("%c", ascii);
	} else{
	  printf("."); //print this if its not convertible to ascii
	}
      }
      printf("|\n"); //end hex row
    }
  }
  printf("\n");
  return 0;
}
