import serial
import time
import warnings
s1 = 0
s2 = 0
portName = 'COM9'

arduino = serial.Serial(port=portName, baudrate=115200, timeout=.1)



### Corresponds to serialEvent in processing ###

while True:
    while(arduino.in_waiting == 0):
        # we hang out in this loop till we get a ping from arduino
        True
    char = arduino.readline();
    if(char == 'U'):
        
    if(s1 < 600):
        s1 += 4
    if (s2 < 600):
        s2 += 4
    write(x, y)
    print("Arduino:" + str(char))
    print("running to: " + str((x,y)))







def write(s1, s2):
    # x should be a string formatted like "x y/n"
    xy = str(s1) + " " + str(s1) + "/n"
    # message = bytes(xy, 'utf-8')
    arduino.write(message)
    print("Sent:")
    print(message)



##################### NOTES #########################
# 1) It seems as though a value is being sent immediately upon run:
#### C:\Users\david\Desktop\Embroidotron\June Updates\NeedleCallResponse2>python pythonSide.py
#### (4, 0)
# 2) Maybe moving to Gcode string format could be better for developing further commands
# 2.1) Possible Commands:
# 2.1.1) motors engage : turn on motors
# 2.1.2) activate stitch mode
# 2.1.3) activate travel mode, move to
# 3) I touched one of the cables/ plugged in a cord close to the signal wires and system stepped -- i.e. false run
