/*
0 bit:
write high, delay for 350 ns = 25 nops
write low,  delay for 800 ns = 58 nops

1 bit:
write high, delay for 700 ns = 50 nops
write low,  delay for 600 ns = 43 nops
*/

int i, j, k;

void logicZERO(void)
{
    //digitalWrite(4, HIGH);
    // for(k=0;k<25;k++){asm("nop");}
    gpio_write_bit(GPIOA, 7, 1);
    //asm("nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n");
    //asm("nop\n nop\n nop\n ");
    //digitalWrite(4, LOW);
    // for(k=0;k<58;k++){asm("nop");}
    gpio_write_bit(GPIOA, 7, 0);
    //asm("nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n");
    //asm("nop\n");
  }

void logicONE(void)
{
    //digitalWrite(4, HIGH);
    //for(k=0;k<50;k++){asm("nop");}
    gpio_write_bit(GPIOA, 7, 1);
    //asm("nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n");
    //asm("nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n ");
    //digitalWrite(4, LOW);
    //for(k=0;k<43;k++){asm("nop");}
    gpio_write_bit(GPIOA, 7, 0);
    //asm("nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n nop\n");
    //asm("nop\n nop\n nop\n nop\n nop\n nop\n ");
  }

void writeRGB(unsigned char r, unsigned char g, unsigned char b)
{
  for(i=0;i<8;i++){
    if (g & (1<<i))
      {
        logicONE();
      }
    else
      {
        logicZERO();
      }
   }
 
  for(i=0;i<8;i++){
    if (r & (1<<i))
      {
        logicONE();
      }
    else
      {
        logicZERO();
      }
  }
      
  for(i=0;i<8;i++){
    if (b & (1<<i))
      {
        logicONE();
      }
    else
      {
        logicZERO();
      }
  }
}

void setup()
{
  pinMode(4, OUTPUT);
  pinMode(BOARD_LED_PIN, OUTPUT);
  i=0;
}

void loop()
{
  for(j=0;j<60;j++){
    writeRGB(i,0,0);
    //for(i=0;i<24;i++) logicONE();
    
  }
  delay(30);
  if(i==255)
  {
    i=0;
  }
  else
  {
    i++;
  }
}
