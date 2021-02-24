protogasm_layout.png shows how I build my boards - the wire goes into the hole
next to a component's leg and is then bent down to meet the leg.

Cut the mounting tabs off of the rotary encoder and install it at the center of
the board.  The center pin should point at Arduino pin 12.  Squeeze the pins
together slightly so they go into columns 8 and 13.

The trimpot goes with its center leg directly connected to the AREF hole.

The MOSFET goes on the back of the board on column 12.  The center pin should be
aligned with VIN.

The pressure sensor is installed with the pins bent the wrong way.  If you
install it the right way there isn't enough clearance for the hose barb.  Pin 1
(notched) goes in column 9, two holes up from the SCL pin.

Install the remaining passives and wiring.

Push the pin headers into the Arudino, then set the perfboard on top.  Solder a
couple pins from each strip.  Do it quickly and just use a dab of solder to tack
it in place or you'll risk damaging the Arduino's connectors.  Remove the
perfboard from the Arduino, solder the remaining pins, then go back and clean up
the ones you tacked.

The Neopixel Ring is installed on three .100 breakaway header pins for PWR, GND,
and OUT.  Do not install a pin on IN because it will short against the USB port.
The pins need to tilt slightly so place the Neopixel Ring on them to hold them
in the correct orientation before soldering them to the board.

The power out to the motor is taken from either side of the diode.  I made a
short cable with a connector and soldered it to the pins.
