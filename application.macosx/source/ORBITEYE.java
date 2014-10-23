import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ORBITEYE extends PApplet {



OscP5 oscP5;
NetAddress myRemoteLocation;
int x;
int y;
float outsideRadius1 = 300;
float insideRadius1 = 240;
float outsideRadius2 = 240;
float insideRadius2 = 180;
float outsideRadius3 = 240;
float insideRadius3 = 90;
float value1;
float r;

public void setup() {
  size(1024, 768);
  frameRate(20);
  /* start oscP5, listening for incoming messages at port 8080 */
  oscP5 = new OscP5(this,8080);
  noStroke();
  x = 0;
  y = 0;
}

public void draw() {
  background(0);
  fill(85,97,257,150);
  int numPoints = PApplet.parseInt(map(value1*4, 0, width, 6, 60));
  float angle = 0;
  float angleStep = 180.0f/numPoints;
    

  beginShape(TRIANGLE_STRIP); 
  for (int i = 0; i <= numPoints; i++) {
    pushMatrix();
    translate(width/2, height/2);
    float px = x + cos(radians(angle)) * outsideRadius1;
    float py = y + sin(radians(angle)) * outsideRadius1;
    angle += angleStep;
    vertex(px, py);
    px = x + cos(radians(angle)) * insideRadius1;
    py = y + sin(radians(angle)) * insideRadius1;
    vertex(px, py); 
    angle += angleStep;
    popMatrix();
  }
  endShape();
  beginShape(TRIANGLE_STRIP); 
  for (int i = 0; i <= numPoints; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(r));
    float px = x + cos(radians(angle)) * outsideRadius2;
    float py = y + sin(radians(angle)) * outsideRadius2;
    angle += angleStep;
    vertex(px, py);
    px = x + cos(radians(angle)) * insideRadius2;
    py = y + sin(radians(angle)) * insideRadius2;
    vertex(px, py); 
    angle += angleStep;
    r++;
    popMatrix();
  }
  endShape();
   beginShape(TRIANGLE_STRIP); 
  for (int i = 0; i <= numPoints; i++) {
    pushMatrix();
    translate(width/2, height/2);
    float px = x + cos(radians(angle)) * outsideRadius3;
    float py = y + sin(radians(angle)) * outsideRadius3;
    angle += angleStep;
    vertex(px, py);
    px = x + cos(radians(angle)) * insideRadius3;
    py = y + sin(radians(angle)) * insideRadius3;
    vertex(px, py); 
    angle += angleStep;
    popMatrix();
  }
  endShape();
  
  fill(0);
  ellipse (width/2,height/2,(200+(value1*4)),(200+(value1*4)));
  textAlign(CENTER, TOP);
  textSize(126);
//  text("ORBIT",width/2, 0);
//  text("EYES",width/2, 620);
  
}

public void oscEvent(OscMessage theOscMessage){ 
  if(theOscMessage.checkAddrPattern("/varX1") == true){
    value1 = theOscMessage.get(0).floatValue();
    println(value1);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "ORBITEYE" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
