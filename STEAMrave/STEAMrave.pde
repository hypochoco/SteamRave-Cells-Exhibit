import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import deadpixel.keystone.*;

int rectWidth;
int rectHeight;
int start = 30;
float end = 100;
int iteration = 10;
int depthMax = 90;
int depthMin = 60;

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
  fullScreen(P3D);
  colorMode(HSB,360,100,100);
  rectWidth = width / 8;
  rectHeight = ceil(1.618 * rectWidth); // golden ratio
  
  background(0);
  kinect = new Kinect(this);
  ks = new Keystone(this);
  
  screen1 = createGraphics(rectWidth, rectHeight, P3D);
  screen2 = createGraphics(rectWidth, rectHeight, P3D);
  screen3 = createGraphics(rectWidth, rectHeight, P3D);
  screen4 = createGraphics(rectWidth, rectHeight, P3D);
  screen5 = createGraphics(rectWidth, rectHeight, P3D);
  screen6 = createGraphics(rectWidth, rectHeight, P3D);
  screen7 = createGraphics(rectWidth, rectHeight, P3D);
  screen8 = createGraphics(rectWidth, rectHeight, P3D);
  
  surface1 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  surface2 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  surface3 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  surface4 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  surface5 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  surface6 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  surface7 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  surface8 = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
  move_surfaces();
}



void draw(){
  //float halfWidth = width/2;
  //float halfHeight = height/2;
  float maxDepth = getMaximumDepth(20, true);
  //end = map(maxDepth,depthMin,depthMax,start,100);
  //if (maxDepth == 0){end = 100;} // in case too close
  //for (int i=0; i<iteration; i++){
  //  float s = map(i, 0, iteration, start, end);
  //  float w = map(i, 0, iteration, width, rectWidth);
  //  float h = map(i, 0, iteration, height, rectHeight);    
  //  drawRect(90, 90, 25, 0.7);
  //}
  //drawRect(90, 90, 25, getMaximumDepth(20, true));
  //background(0);
  //render_surfaces();
}

/*
drawRect - 
draws panel to screen
rdark - "darkness" of outer rectangle
rbright - "brightness" of outer rectangle
cdif - difference of brightness bewteen inner cell and outer rect
cratio - ratio of size between inner cell and outer rect
*/
void drawRect(float rdark, float rbright, float cdif, float cratio){
  float cdark = rdark;
  float cbright = rbright - cdif;
  float cwidth = ceil(rectWidth * cratio);
  float cheight = ceil(rectHeight * cratio);
  float cx = ceil((rectWidth - cwidth) / 2);
  float cy = ceil((rectHeight - cheight) /2);
  int colorCycleL = frameCount%360;
  int colorCycleR = 360 - colorCycleL;
  
  screen1.beginDraw();
  screen1.fill(color(colorCycleL, rbright, rdark));
  screen1.noStroke();
  screen1.rect(0, 0, rectWidth, rectHeight);
  screen1.fill(color(colorCycleL, cbright, cdark));
  screen1.rect(cx, cy, cwidth, cheight);
  screen1.endDraw();
  
  screen2.beginDraw();
  screen2.fill(color(colorCycleR, rbright, rdark));
  screen2.noStroke();
  screen2.rect(0, 0, rectWidth, rectHeight);
  screen2.fill(color(colorCycleR, cbright, cdark));
  screen2.rect(cx, cy, cwidth, cheight);
  screen2.endDraw();
  
  screen3.beginDraw();
  screen3.fill(color(colorCycleL, rbright, rdark));
  screen3.noStroke();
  screen3.rect(0, 0, rectWidth, rectHeight);
  screen3.fill(color(colorCycleL, cbright, cdark));
  screen3.rect(cx, cy, cwidth, cheight);
  screen3.endDraw();
  
  screen4.beginDraw();
  screen4.fill(color(colorCycleR, rbright, rdark));
  screen4.noStroke();
  screen4.rect(0, 0, rectWidth, rectHeight);
  screen4.fill(color(colorCycleR, cbright, cdark));
  screen4.rect(cx, cy, cwidth, cheight);
  screen4.endDraw();
  
  screen5.beginDraw();
  screen5.fill(color(colorCycleL, rbright, rdark));
  screen5.noStroke();
  screen5.rect(0, 0, rectWidth, rectHeight);
  screen5.fill(color(colorCycleL, cbright, cdark));
  screen5.rect(cx, cy, cwidth, cheight);
  screen5.endDraw();
  
  screen6.beginDraw();
  screen6.fill(color(colorCycleR, rbright, rdark));
  screen6.noStroke();
  screen6.rect(0, 0, rectWidth, rectHeight);
  screen6.fill(color(colorCycleR, cbright, cdark));
  screen6.rect(cx, cy, cwidth, cheight);
  screen6.endDraw();
  
  screen7.beginDraw();
  screen7.fill(color(colorCycleL, rbright, rdark));
  screen7.noStroke();
  screen7.rect(0, 0, rectWidth, rectHeight);
  screen7.fill(color(colorCycleL, cbright, cdark));
  screen7.rect(cx, cy, cwidth, cheight);
  screen7.endDraw();
  
  screen8.beginDraw();
  screen8.fill(color(colorCycleR, rbright, rdark));
  screen8.noStroke();
  screen8.rect(0, 0, rectWidth, rectHeight);
  screen8.fill(color(colorCycleR, cbright, cdark));
  screen8.rect(cx, cy, cwidth, cheight);
  screen8.endDraw();
}

/*
move all surfaces to line up in the middle
*/
void move_surfaces() {
  int centAlign = (height - rectHeight)/2;
  surface1.moveTo(0,centAlign);
  surface2.moveTo(rectWidth,centAlign);
  surface3.moveTo(2*rectWidth,centAlign);
  surface4.moveTo(3*rectWidth,centAlign);
  surface5.moveTo(4*rectWidth,centAlign);
  surface6.moveTo(5*rectWidth,centAlign);
  surface7.moveTo(6*rectWidth,centAlign);
  surface8.moveTo(7*rectWidth,centAlign);
}

/*
render all surfaces
*/
void render_surfaces() {
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
  println(maxB);
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

/*
functions to dodge warning from kinect4WinSDK
*/
void appearEvent(SkeletonData _s) {
  return;
}

void disappearEvent(SkeletonData _s) {
  return;
}

void moveEvent(SkeletonData _b, SkeletonData _a) {
  return;
}
