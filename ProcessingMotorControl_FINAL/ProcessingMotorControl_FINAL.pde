import processing.serial.*;
Serial arduino; 
int s1 = 0;
int s2 = 0;
int totalSteps = 0;
boolean doSend = true;


void setup() {
  size(256, 256);

  //// CHANGE PORT NAME TO UNO PORT //////
  String portName = "COM7";
  ////////////////////////////////////////
  
  //setup serial communication
  arduino = new Serial(this, portName, 115200);
  arduino.bufferUntil(10);
} 


void draw() {
  ;
}


void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  println("\n\nNew Serial Event");
  String inBytes = arduino.readString();
  if (inBytes.charAt(0) == 'U') {
    // send new coordinates to stepper motor
    write(s1, s2);

    //update coordinates for next send
    updatePoints();
  } else {
    println(inBytes);
  }
}


void updatePoints() {
  ///// CHANGE HERE FOR MODIFYING THE STITHCHING PATH IN RUN TIME //////
  if(totalSteps<50){
    s1+=5;
  } else if(totalSteps<100){
    s2+=5;
  } else {
    s1 += cos(noise(totalSteps/5)*2*PI)*8;
    s2 += sin(noise(totalSteps/5)*2*PI)*8;
  }
  totalSteps++;
  
  ////////////////////////////////////////////////////////////////
}

void write(int s1, int s2) {
  String writeMe = str(s1) + " " + str(s2) + "\n";
  if(doSend){
    arduino.write(writeMe);
    println("Sent s1: " + str(s1));
    println("Sent s2: " + str(s2));
  } else {
    println("would have sent:");
    println(writeMe);
  }
}
