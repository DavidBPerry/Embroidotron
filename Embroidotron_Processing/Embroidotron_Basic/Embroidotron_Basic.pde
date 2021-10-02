/// EMBROIDOTRON SETUP ///
import processing.serial.*;
Serial arduino; 
int s1 = 0;
int s2 = 0;

/// DEBUGGING BOOLEANS ////
boolean serialConnected = false; // for testing without connection to arduino set to false 

void setup() {
  size(800, 800);

  // SETUP EMBROIDERY COMMUNICATIONS
  if (serialConnected) {
    try {
      //// CHANGE PORT NAME TO UNO PORT ////// <------------------------------------------------ CHANGE HERE ----------------------
      String portName = "COM9";
      ////////////////////////////////////////

      //// SERIAL COMMUNICATION SETUP/////////////
      arduino = new Serial(this, portName, 115200);
      arduino.bufferUntil(10);
    }
    catch(Exception e) {
      println("ERROR WITH SERIAL CONNECTION: check that the device is connected properly and that you are using the correct port name");
      println("See the portName variable (~line 55) to update port name");
      exit();
    }
  }
}



void draw() {
  // we draw a green circle on top of the current needle down
  fill(0, 255, 0);

  pushMatrix();
  translate(width/2, height/2);
  ellipse(s1, s2, 3, 3);
  popMatrix();

  if (serialConnected==false) {
    updatePoints();
    delay(500);
  }
}



////////////////////// SERIAL COMS HELPERS ///////////////////////////////////////////

void serialEvent(Serial myPort) {
  if (serialConnected) {
    // read a byte from the serial port:
    String inBytes = arduino.readString();
    if (inBytes.charAt(0) == 'U') {
      write(s1, s2); // send new coordinates to stepper motor
      updatePoints(); //update coordinates for next send
    } else {
      println(inBytes);
    }
  }
}


void updatePoints() {
  if (s1 < 600) {
    s1 += 4;
  }
  if (s1 < 600) {
    s2 += 4;
  }
}


void write(int s1, int s2) {
  String message = str(s1) + " " + str(s2) + "\n";
  arduino.write(message);
}
////////////////////// END SERIAL COMS HELPERS /////////////////////////////////////////////////////////
