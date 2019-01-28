#include<stdint.h>

uint32_t toto = 0xDEADBEEF;

void essai(uint8_t val)
{
	toto += val;
}

void main(void)
{
	
	toto = 0x42;
	essai(5);
	while(1) {};
}