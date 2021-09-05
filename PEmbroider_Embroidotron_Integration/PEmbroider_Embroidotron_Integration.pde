import processing.serial.*;
Serial arduino; 
int s1 = 0;
int s2 = 0;
int totalSteps = 0;
PVector zeroPoint;

/// DEBUGGING BOOLEANS ////
boolean doSend = true; // for testing without actually sending points set to false (motors will not move if false)
boolean serialConnected = true; // for testing without connection to arduino set to false 





//-----------------------------------------------------
import processing.embroider.*;
PEmbroiderGraphics E;
int stitchPlaybackCount = 0;
int lastStitchTime = 0;


//-----------------------------------------------------





void setup() {
  size(800, 800);

  //// DEFINE EMBROIDERY DESIGN HERE ////////////////// <------------------------------------------------ CHANGE HERE ----------------------
  E = new PEmbroiderGraphics(this, width, height);
  E.beginDraw();

  // set this to false if you don't want
  // PEmbroider to calculate intermediate stitch points for you
  E.toggleResample(true);

  E.setStitch(10, 30, 0);
  E.hatchSpacing(20);
  E.hatchMode(PEmbroiderGraphics.SPIRAL);  
  
  E.scale(.8);
  E.noStroke();
  E.fill(0, 0, 0);
  E.ellipse(width/2, height/2, 500, 500);
  
  E.visualize();
  //// END EMBROIDERY DESIGN //////////////////////////////

  // SETUP EMBROIDERY COMMUNICATIONS
  zeroPoint = getNeedleDown(E, 0); //get the first point so we can work away from there
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
  } else {
    doSend = false;
  }
}



void draw() {
  // we draw a green circle on top of the current needle down
  fill(0, 255, 0);
  PVector needleDown = getNeedleDown(E, totalSteps);
  ellipse(needleDown.x, needleDown.y, 3, 3);
  
  if(serialConnected==false){
    updatePoints();
    delay(500);
  }
}



////////////////////// SERIAL COMS HELPERS ///////////////////////////////////////////

void serialEvent(Serial myPort) {
  if (serialConnected) {
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
  PVector needleDown = getNeedleDown(E, totalSteps);
  
  if (currentKey == "UP"){
    println("up");
    println(currentKey);
    //this goes up
    s1 +=5;//= //int((needleDown.x-zeroPoint.x));
    s2 -=5;//= //int((needleDown.y-zeroPoint.y));
  } else if (currentKey == "LEFT"){
    println("left");
    println(currentKey);
    //goes left
    s1 +=5;//= //int((needleDown.x-zeroPoint.x));
    s2 +=5;//= //int((needleDown.y-zeroPoint.y));
  } else if (currentKey == "RIGHT"){
    println("right");
    println(currentKey);
    //right
    s1 -=5;//= //int((needleDown.x-zeroPoint.x));
    s2 -=5;//= //int((needleDown.y-zeroPoint.y));
  } else if (currentKey == "DOWN"){
    println("down");
    println(currentKey);
    //down
    s1 -=5;//= //int((needleDown.x-zeroPoint.x));
    s2 +=5;//= //int((needleDown.y-zeroPoint.y));
  }
  
  totalSteps++; //current step
  
  
}


void write(int s1, int s2) {
  String writeMe = str(s1) + " " + str(s2) + "\n";
  if (doSend) {
    arduino.write(writeMe);
    println("Sent s1: " + str(s1));
    println("Sent s2: " + str(s2));
  } else {
    println("would have sent:");
    println(writeMe);
  }
}

////////////////////// END SERIAL COMS HELPERS /////////////////////////////////////////////////////////



////////////////////// NEEDLE DOWN HELPERS /////////////////////////////////////////////////////////

PVector getNeedleDown(PEmbroiderGraphics E, int ndIndex) {
  //get the ith needle down
  int n = 0;
  for (int i=0; i<E.polylines.size(); i++) {
    for (int j=0; j<E.polylines.get(i).size(); j++) {
      PVector needleLoc = E.polylines.get(i).get(j).copy();
      if (n >= ndIndex) {
        return needleLoc;
      }
      n++;
    }
  }
  return null; //will return null if the index is outside the needle down list
}

int ndLength(PEmbroiderGraphics E) {
  //return the total number of needle downs in the job
  int n = 0;
  for (int i=0; i<E.polylines.size(); i++) {
    for (int j=0; j<E.polylines.get(i).size(); j++) {
      n++;
    }
  }
  return n;
}


void CheckNeedleDowns(PEmbroiderGraphics E) {
  // run various checks on the needle downs to prevent any errors 
  // basic error checks:
  // 1) travel length check (check for any excessive travels)
  // 2) stitch density check (check the number of stitches per unit area, would be great to provide this as a heat map)
}
////////////////////// END NEEDLE DOWN HELPERS /////////////////////////////////////////////////////////
