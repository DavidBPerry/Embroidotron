/// EMBROIDOTRON SETUP ///
import processing.serial.*;
Serial arduino; 
int s1 = 0;
int s2 = 0;
int totalSteps = 0;
PVector zeroPoint;

/// DEBUGGING BOOLEANS ////
boolean doSend = false; // for testing without actually sending points set to false (motors will not move if false)
boolean serialConnected = false; // for testing without connection to arduino set to false 



float dx;
float dy;

//int boxX = 100;
//int boxY = 100;
int boxW = 600;
int boxH = 600;
void setup() {
  size(800, 800);
  
  int boxX = (width - boxW)/2;
  int boxY = (height - boxH)/2;
  
  rect( boxX, boxY, boxW, boxH);

  dx = random(-5,5);
  dy = random(-5,5);

  // SETUP EMBROIDERY COMMUNICATIONS
  zeroPoint = new PVector(width/2,height/2);
  if (serialConnected) {
    try {
      //// CHANGE PORT NAME TO UNO PORT ////// <------------------------------------------------ CHANGE HERE ----------------------
      String portName = "COM3";
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
  } else {
    doSend = false;
  }
}



void draw() {
  // we draw a green circle on top of the current needle down
  fill(0, 255, 0);
  
  pushMatrix();
  translate(width/2,height/2);
  ellipse(s1, s2, 3, 3);
  popMatrix();
  
  if(serialConnected==false){
    updatePoints();
    delay(500);
  }
}



////////////////////// SERIAL COMS HELPERS ///////////////////////////////////////////

void serialEvent(Serial myPort) {
  if (serialConnected) {
    // read a byte from the serial port:
    //println("\n\nNew Serial Event");
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
}

String currentKey;

void keyPressed(){
  println("keycode : " + keyCode);
 if (keyCode == UP) {
   currentKey = "UP";
 } else if (keyCode == DOWN){
   currentKey = "DOWN";
 } else if (keyCode == LEFT){
   currentKey = "LEFT";
 } else if (keyCode == RIGHT){
   currentKey = "RIGHT";
 }
  
}


void updatePoints() {
  int offset = 5;
  
  if( (  (s1 + dx*offset) > boxW/2)  ||  (  (s1 + dx*offset) < (0-boxW/2))) {
    dx *= -1;
  }  
  if( (  (s2 + dy*offset) > boxH/2)  ||  (  (s2 + dy*offset) < (0-boxH/2))) {
    dy *= -1;
  }
  
  
  s1 += dx*offset;
  s2 += dy*offset;
  
  
  if (currentKey == "UP"){
    println("up");
    println(currentKey);
    //this goes up
    //s2 -=offset;//= //int((needleDown.y-zeroPoint.y));
    dy *= -1;
  } else if (currentKey == "LEFT"){
    println("left");
    println(currentKey);
    //goes left
    //s1-=offset;
    dx *= -1;
  } else if (currentKey == "RIGHT"){
    println("right");
    println(currentKey);
    //right
    //s1+=offset;
    dx *= -1;
  } else if (currentKey == "DOWN"){
    println("down");
    println(currentKey);
    //down
    //s2 +=offset;//= //int((needleDown.y-zeroPoint.y));
    dy *= -1;
  }
  
  currentKey = "NONE";
  
  totalSteps++; //current step
}


void write(int s1, int s2) {
  PVector P = new PVector(s1,s2);
  P.rotate(PI/4);
  String writeMe = str(int(P.x)) + " " + str(int(P.y)) + "\n";
  if (doSend) {
    arduino.write(writeMe);
    //println("Sent s1: " + str(s1));
    //println("Sent s2: " + str(s2));
  } else {
    println("would have sent:");
    println(writeMe);
  }
}
////////////////////// END SERIAL COMS HELPERS /////////////////////////////////////////////////////////
