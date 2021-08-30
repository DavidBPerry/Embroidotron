
#include <AccelStepper.h>
#include <MultiStepper.h>
#define xStepPin 2
#define xDirPin 5
#define yStepPin 4            // Really Z Step
#define yDirPin 7             // Really Z Dir
#define MotorEnable 8
#define motorInterfaceType 1
AccelStepper stepper1;
AccelStepper stepper2;
MultiStepper steppers;

int s1 = 0;
int s2 = 0;

int s1Prev = 0;
int s2Prev = 0;

const byte interruptPin = 3;
volatile bool needleUp = false;
volatile long millisTime = 0;

const byte indicatorPin = 13;

int threshold = 8;





void setup() {
  Serial.begin(115200);
  Serial.setTimeout(1);

  // Setup interrupt pin
  pinMode(interruptPin, INPUT);
  attachInterrupt(digitalPinToInterrupt(interruptPin), needleInterrupt, FALLING);

  /////// Setup Motors here ///////////////////////////////

  stepper1 = AccelStepper(motorInterfaceType, xStepPin, xDirPin);
  stepper2 = AccelStepper(motorInterfaceType, yStepPin, yDirPin);
  stepper1.setMaxSpeed(400);
  stepper2.setMaxSpeed(400);
  steppers.addStepper(stepper1);
  steppers.addStepper(stepper2);
  pinMode(MotorEnable, OUTPUT); //setup enable pin

  ///////////////////////////////////

  pinMode(indicatorPin, OUTPUT);
  delay(1000);
  Serial.println("Arduino Ready");
  enableMotors();
}




void loop() {
  if (needleUp) {
    // we do some work to prevent bouncing
    delay(5);
    if (digitalRead(interruptPin) == LOW) {
      setActuators(s1, s2);               // run motors
      getNewPosition();                  // get new needle down position
    }
    needleUp = false;                  // set Needle Up state to false TODO: Consider changing this variable name, bc it could be confusing, maybe change to doMove, doStep, moveMotor -- this variable is more tide to motor movement than the needle state
  }
}







/////////////////////////////// HELPER FUNCTIONS /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void getNewPosition() {
  Serial.println('U');               // Notify computer that needle is up
  delay(10);                          // Wait a moment for reply
  if (Serial.available() > 0) {      // If data comes in store the new values
    s1Prev = s1;
    s2Prev = s2;

    int s1Temp = Serial.parseInt();          // get stepper 1 value
    int s2Temp = Serial.parseInt();          // get stepper 2 value

    if (Serial.read() == '\n') {
      s1 =  s1Temp;
      s2 =  s2Temp;
    }
  }

}



void setActuators(int s1, int s2) {
  digitalWrite(indicatorPin, HIGH); // set indicator

  ////////////// CHANGE ACTUATOR RUN HERE ////////////////////

  long positions[2] = {s1, s2};
  steppers.moveTo(positions);
  steppers.runSpeedToPosition(); // Blocks until all steppers are in position
  //Serial.println(String(stepper1.currentPosition()) + " , " + String(stepper2.currentPosition()));

  ///////////////////////////////////////////////////////////
  digitalWrite(indicatorPin, LOW);
}

void needleInterrupt() {
  // Interrupt function
  needleUp = true;
  millisTime = millis();
}


void enableMotors() {
  // Turn on motors (helper for readability)
  digitalWrite(MotorEnable, LOW);
}

void disableMotors() {
  // Turn off motors (helper for readability)
  digitalWrite(MotorEnable, HIGH);
}
