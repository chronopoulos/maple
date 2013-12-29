/*
Stolen and modified from user anthrolume on:
 http://forums.leaflabs.com/topic.php?id=74191
 */

// These values were determined empirically
#define	kSpinCountZeroBitHigh 4   // these give 330ns high and 800ns low
#define	kSpinCountZeroBitLow	9
#define	kSpinCountOneBitHigh	9   // these give 750 high and 360 low
#define	kSpinCountOneBitLow 	4
#define kNumLEDs 60

static inline void spinDelay(unsigned int) __attribute__((always_inline, unused));
static inline void spinDelay(unsigned int count)
{
  asm volatile(
  "L_%=_loop:\n\t"
    "subs %0, #1\n\t"
    "bne  L_%=_loop\n"
: 
    "+r" (count) :
  );
}

// WS2812 chip - NeoPixel, etc.
void pixel(byte r, byte g, byte b)
{
  byte mask;

  // Turn off interrupts until we're done with our loop
  noInterrupts();

  // Our frame buffers are RGB, but WS2812s want colors in GRB order, so we
  // do that reording here.

  // Emit green
  for (mask = 0x80; mask; mask >>= 1)
  {
    gpio_write_bit(GPIOA, 7, 1);
    if (g & mask)
    {
      spinDelay(kSpinCountOneBitHigh);
      gpio_write_bit(GPIOA, 7, 0);
      spinDelay(kSpinCountOneBitLow);
    }
    else
    {
      spinDelay(kSpinCountZeroBitHigh);
      gpio_write_bit(GPIOA, 7, 0);
      spinDelay(kSpinCountZeroBitLow);
    }
  }

  // Emit red
  for (mask = 0x80; mask; mask >>= 1)
  {
    gpio_write_bit(GPIOA, 7, 1);
    if (r & mask)
    {
      spinDelay(kSpinCountOneBitHigh);
      gpio_write_bit(GPIOA, 7, 0);
      spinDelay(kSpinCountOneBitLow);
    }
    else
    {
      spinDelay(kSpinCountZeroBitHigh);
      gpio_write_bit(GPIOA, 7, 0);
      spinDelay(kSpinCountZeroBitLow);
    }
  }

  // Emit blue
  for (mask = 0x80; mask; mask >>= 1)
  {
    gpio_write_bit(GPIOA, 7, 1);
    if (b & mask)
    {
      spinDelay(kSpinCountOneBitHigh);
      gpio_write_bit(GPIOA, 7, 0);
      spinDelay(kSpinCountOneBitLow);
    }
    else
    {
      spinDelay(kSpinCountZeroBitHigh);
      gpio_write_bit(GPIOA, 7, 0);
      spinDelay(kSpinCountZeroBitLow);
    }
  }

  interrupts();
}

void setup()
{

}

void loop()
{
  pixel(255,0,255);
  delayMicroseconds(50);
}



