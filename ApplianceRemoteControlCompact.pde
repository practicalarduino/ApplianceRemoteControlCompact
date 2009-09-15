/**
 * ApplianceRemoteControlCompact
 *
 * Waits for control values to be sent via the serial connection and
 * pulses digital outputs to trigger the buttons on an appliance remote
 * control. Outputs are pulsed for 250ms to simulate manually pressing
 * a button.
 *
 * The number of outputs can be trivially varied to suit your needs.
 *
 * This sketch is a very simple and useful building block for any
 * project where you need to use an Arduino as an intermediary to link
 * together a host computer and a physical device for automated
 * control.
 *
 * This version of the program has been written to demonstrate techniques
 * for reducing the program size using loops, arrays, and functions.
 *
 * Copyright 2009 Jonathan Oxer <jon@oxer.com.au>
 * http://www.practicalarduino.com/projects/easy/appliance-remote-control
 */

// Use pins 5 through 12 as the digital outputs
int outputArray[] = {5, 6, 7, 8, 9, 10, 11, 12};

//Number of milliseconds to hold the outputs on
int buttonPressTime = 250;


/**
 * Initial configuration
 */
void setup()
{
  // Open the serial connection to listen for commands from the host
  Serial.begin(38400);

  int count = 0;  // Variable to store current array position

  // Set up the pins as outputs and force them LOW
  for(count=0; count<8; count++) {
    pinMode(outputArray[count], OUTPUT);
    digitalWrite(outputArray[count], LOW);
  }
}

/**
 * Main program loop
 */
void loop()
{
  byte val;     // The raw character read from the serial port
  int channel;  // Integer version of channel ID

  // Check if a value has been sent by the host
  if(Serial.available()) {
    val = Serial.read();

    channel = (int)val - 48; // Convert ASCII value to digit
    if(channel > 0 && channel < 9) {
      pulseOutput(channel);  // Pulse the appropriate button
    }
  }
}

/**
 * Briefly pulse a nominated digital output high
 */
void pulseOutput(int channel)
{
  Serial.print("Output ");
  Serial.print(channel);
  Serial.println(" ON");
  digitalWrite(outputArray[channel - 1], HIGH); // Channel number is 1 higher than array position
  delay(buttonPressTime);
  digitalWrite(outputArray[channel - 1], LOW);
  Serial.print("Output ");
  Serial.print(channel);
  Serial.println(" OFF");
}
