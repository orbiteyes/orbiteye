import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
int x;
int y;
int drumMidiNote1;
int bassMidiNote = 20;
int snareMidiNote = 21;
float outsideRadius1 = 320;
float insideRadius1 = 240;
float outsideRadius2 = 240;
float insideRadius2 = 180;
float outsideRadius3 = 240;
float insideRadius3 = 90;
float drumAmpL1;
float r1;
float r2;
float r3;

void setup() {
  size(1024, 768);
  frameRate(20);
  /* start oscP5, listening for incoming messages at port 8080 */
  oscP5 = new OscP5(this,8080);
  noStroke();
  x = 0;
  y = 0;
}

void draw() {
  background(0);
  int numPoints = int(map(drumAmpL1, 0, 100, 6, 100));
  float angle = 0;
  float angleStep1 = 180.0/6.1;
  float angleStep = 180.0/numPoints;
    

  beginShape(TRIANGLE_STRIP);
  fill(85,97,257,150); 
  for (int i = 0; i <= numPoints; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(r1));
    float px = x + cos(radians(angle)) * outsideRadius1;
    float py = y + sin(radians(angle)) * outsideRadius1;
    angle += angleStep1;
    vertex(px, py);
    px = x + cos(radians(angle)) * insideRadius1;
    py = y + sin(radians(angle)) * insideRadius1;
    vertex(px, py); 
    angle += angleStep1;
    r1++;
    popMatrix();
  }
  endShape();
  beginShape(TRIANGLE_STRIP); 
  fill(85,97,257,150);
  for (int i = 0; i <= numPoints; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(r2));
    float px = x + cos(radians(angle)) * outsideRadius2;
    float py = y + sin(radians(angle)) * outsideRadius2;
    angle += angleStep;
    vertex(px, py);
    px = x + cos(radians(angle)) * insideRadius2;
    py = y + sin(radians(angle)) * insideRadius2;
    vertex(px, py); 
    angle += angleStep;
    if(drumMidiNote1 == bassMidiNote) {
      r2++;
    }
    popMatrix();
  }
  endShape();
   beginShape(TRIANGLE_STRIP); 
   fill(85,97,257,150);
  for (int i = 0; i <= numPoints; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(r3));
    float px = x + cos(radians(angle)) * outsideRadius3;
    float py = y + sin(radians(angle)) * outsideRadius3;
    angle += angleStep;
    vertex(px, py);
    px = x + cos(radians(angle)) * insideRadius3;
    py = y + sin(radians(angle)) * insideRadius3;
    vertex(px, py); 
    angle += angleStep;
    if(drumMidiNote1 == snareMidiNote) {
      r3++;
    }
    else {
      r3--;
    }
    popMatrix();
  }
  endShape();
  
  fill(0);
  ellipse (width/2,height/2,(200+(drumAmpL1*2)),(200+(drumAmpL1*2)));
  textAlign(CENTER, TOP);
  textSize(126);
//  text("ORBIT",width/2, 0);
//  text("EYES",width/2, 620);
  
}

void oscEvent(OscMessage theOscMessage){ 
  if(theOscMessage.checkAddrPattern("/drumAmpL1") == true){
    drumAmpL1 = theOscMessage.get(0).floatValue();
    println(drumAmpL1);
  }
  if(theOscMessage.checkAddrPattern("/drumMidiNote1") == true){
    drumMidiNote1 = theOscMessage.get(0).intValue();
    println(drumMidiNote1);
  }
}
