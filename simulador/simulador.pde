import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;
PShape modelo;
String data="";
float roll, pitch;
PShape woman;

void setup() {
  size (960, 640, P3D);
  myPort = new Serial(this, "COM4", 9600); // starts the serial communication
  myPort.bufferUntil('\n');
  woman = loadShape("woman.obj");
}

void draw() {
  
  translate(width/2, height/2, 0);
  background(33);
  textSize(42);
  text("Roll: " + int(pitch) + "     Pitch: " + int(roll), -100, 265);

  // Rotate the object
  rotateX(radians(roll+PI));
  rotateZ(radians(pitch)+PI);
  rotateY(PI);
  
  // 3D 0bject
  shape(woman);
 // textSize(30);  
  //fill(0, 76, 153);
  //box (386, 40, 200); // Draw box
  //textSize(25);
  //fill(255, 255, 255);
  //text("www.HowToMechatronics.com", -183, 10, 101);

  //delay(10);
  //println("ypr:\t" + angleX + "\t" + angleY); // Print the values to check whether we are getting proper values
}

// Read data from the Serial Port
void serialEvent (Serial myPort) { 
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil('\n');

  // if you got any bytes other than the linefeed:
  if (data != null) {
    data = trim(data);
    // split the string at "/"
    String items[] = split(data, '/');
    if (items.length > 1) {

      //--- Roll,Pitch in degrees
      roll = float(items[4]);
      pitch = float(items[2]);
    }
  }
}
