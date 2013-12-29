/*
Stolen from user robodude666 on this thread:
 http://forums.leaflabs.com/topic.php?id=1075#post-6618
 */

#define SPI_DMA_DEV DMA1
#define SPI_RX_DMA_CHANNEL DMA_CH2
#define SPI_TX_DMA_CHANNEL DMA_CH3
#define SPI_BUFF_SIZE 1500 // NLEDS*3*8+60

#include <dma.h>

int i, j;
HardwareSPI spi(1); // Use SPI port number 1
static uint8 dma_tx_spi_buffer[SPI_BUFF_SIZE];


void setup() {
  
  // set all 60 leds to full red
  for (i=0;i<180;i++)
  {
    if (i%3==0)
    {
      for (j=0;j<8;j++)
      {
        dma_tx_spi_buffer[3*i+j] = 0b11111000;
      }
    }
    else
    {
      for (j=0;j<8;j++)
      {
        dma_tx_spi_buffer[3*i+j] = 0b11100000;
      }
    }
  }

  // set the tail to zeros for the reset signal
  for (i=0;i<60;i++)
  {
    dma_tx_spi_buffer[1440+i] = 0;
  }

  noInterrupts();
  spi.begin(SPI_4_5MHZ, MSBFIRST, SPI_MODE_0); // 1.8 us period
  dma_init(SPI_DMA_DEV);
  spi_tx_dma_enable(SPI1); // Enables TX DMA on SPI 1
  dma_setup_transfer(SPI_DMA_DEV, SPI_TX_DMA_CHANNEL,
  &SPI1->regs->DR, DMA_SIZE_8BITS,
  dma_tx_spi_buffer,  DMA_SIZE_8BITS,
  (DMA_MINC_MODE | DMA_CIRC_MODE| DMA_FROM_MEM)
    );
  dma_set_num_transfers(SPI_DMA_DEV, SPI_TX_DMA_CHANNEL, SPI_BUFF_SIZE);
  dma_enable(SPI_DMA_DEV, SPI_TX_DMA_CHANNEL);

}

void loop() {


}





