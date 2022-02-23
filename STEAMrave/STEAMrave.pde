import kinect4WinSDK.Kinect;
import deadpixel.keystone.*;

int start = 30;
float end = 100;
int iteration = 10;
int rectWidth = 700;
int rectHeight = 700;
int depthMax = 90;
int depthMin = 60;
int numScreen = 1;

Kinect kinect;
Keystone ks;
CornerPinSurface surface1;
CornerPinSurface surface2;
CornerPinSurface surface3;
CornerPinSurface surface4;
CornerPinSurface surface5;
CornerPinSurface surface6;
CornerPinSurface surface7;
CornerPinSurface surface8;
PGraphics screen1;
PGraphics screen2;
PGraphics screen3;
PGraphics screen4;
PGraphics screen5;
PGraphics screen6;
PGraphics screen7;
PGraphics screen8;

void setup(){
  background(0);
  size(1920,1080,P3D);
  colorMode(HSB,360,100,100);
  fill(0,start,100);
  rect(0,0,800,800);
   
  background(0);
  kinect = new Kinect(this);
  ks = new Keystone(this);
  
  screen1 = createGraphics(100, 100, P3D);
  screen2 = createGraphics(100, 100, P3D);
  screen3 = createGraphics(100, 100, P3D);
  screen4 = createGraphics(100, 100, P3D);
  screen5 = createGraphics(100, 100, P3D);
  screen6 = createGraphics(100, 100, P3D);
  screen7 = createGraphics(100, 100, P3D);
  screen8 = createGraphics(100, 100, P3D);
  
  surface1 = ks.createCornerPinSurface(100, 100, 20);
  surface2 = ks.createCornerPinSurface(100, 100, 20);
  surface3 = ks.createCornerPinSurface(100, 100, 20);
  surface4 = ks.createCornerPinSurface(100, 100, 20);
  surface5 = ks.createCornerPinSurface(100, 100, 20);
  surface6 = ks.createCornerPinSurface(100, 100, 20);
  surface7 = ks.createCornerPinSurface(100, 100, 20);
  surface8 = ks.createCornerPinSurface(100, 100, 20);
}



void draw(){
  float halfWidth = width/2;
  float halfHeight = height/2;
  float maxDepth = getMaximumDepth(20, true);
  end = map(maxDepth,depthMin,depthMax,start,100);
  if (maxDepth == 0){end = 100;} // in case too close
  for (int i=0; i<iteration; i++){
    float s = map(i, 0, iteration, start, end);
    float w = map(i, 0, iteration, width, rectWidth);
    float h = map(i, 0, iteration, height, rectHeight);    
    drawRect(halfWidth, halfHeight, w, h, s);
  }
  
  background(0);
  surface1.render(screen1);
  surface2.render(screen2);
  surface3.render(screen3);
  surface4.render(screen4);
  surface5.render(screen5);
  surface6.render(screen6);
  surface7.render(screen7);
  surface8.render(screen8);
}

/*
drawRect - 
draws panel to screen
*/
void drawRect(float centerX, float centerY, float w, float h, float saturation){
  float halfWidth = w/2;
  float halfHeight = h/2;
  screen1.beginDraw();
  screen1.fill(0,saturation,100);
  screen1.noStroke();
  screen1.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen1.endDraw();
  screen2.beginDraw();
  screen2.fill(0,saturation,100);
  screen2.noStroke();
  screen2.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen2.endDraw();
  screen3.beginDraw();
  screen3.fill(0,saturation,100);
  screen3.noStroke();
  screen3.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen3.endDraw();
  screen4.beginDraw();
  screen4.fill(0,saturation,100);
  screen4.noStroke();
  screen4.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen4.endDraw();
  screen5.beginDraw();
  screen5.fill(0,saturation,100);
  screen5.noStroke();
  screen5.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen5.endDraw();
  screen6.beginDraw();
  screen6.fill(0,saturation,100);
  screen6.noStroke();
  screen6.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen6.endDraw();
  screen7.beginDraw();
  screen7.fill(0,saturation,100);
  screen7.noStroke();
  screen7.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen7.endDraw();
  screen8.beginDraw();
  screen8.fill(0,saturation,100);
  screen8.noStroke();
  screen8.rect(centerX-halfWidth,centerY-halfHeight,w,h);
  screen8.endDraw();
}

/*
getMaximumDepth -
Iterates through every nth pixel and returns the value with the lowest depth (i.e. closest to the sensor).
(From testing, it seems that 230 is the highest (close in proximity) value we can achieve,
and 0 is the lowest (farthest in proximity) value)

INPUTS:
  n - One in every n pixel will be compared
  display - selecting true displays the depth image from the kinect
*/
float getMaximumDepth(int n, Boolean display) {
  PImage img = kinect.GetDepth();
  if (display) image(img,0,0);
  float maxB = 0;
  for (int i = 0; i < img.pixels.length; i+=n) {
    float b = brightness(img.pixels[i]);
    if (b > maxB) maxB = b;
  }
  return maxB;
}

/*
keyPressed -
toggle to adjust projections
*/
void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}
