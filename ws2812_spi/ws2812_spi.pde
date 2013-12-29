#define nleds 60

HardwareSPI spi(1); // Use SPI port number 1

void setup() {
  spi.begin(SPI_2_25MHZ, MSBFIRST, SPI_MODE_0);
  // might have to play around with these parameters
  noInterrupts();
}

//static byte datastring[nleds*3];

void loop() {
  //waitForButtonPress();
  //spi.write(0b11001010);
  spi.write(0b11110000);
}


