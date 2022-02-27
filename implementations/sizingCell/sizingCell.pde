/*

CHANGES SIZE OF INNER CELL BASED ON DEPTH

*/

import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import deadpixel.keystone.*;

// DIMENSIONS FOR EACH PANEL
int rectWidth;
int rectHeight;
// DIMENSION BOUNDS FOR CELL
float maxcratio = 0.7;
float mincratio = 0.3;
// SPACING FOR getDepth()
int depthSkip = 700;
Boolean show_kinect = true;
// CALIBRATION FOR DEPTH
float dlow = 70;
float dhigh = 100;
// SPEED FOR COLOR CYCLING
float speed = 0.25;

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
CornerPinSurface kinectSurface;
PGraphics screen1;
PGraphics screen2;
PGraphics screen3;
PGraphics screen4;
PGraphics screen5;
PGraphics screen6;
PGraphics screen7;
PGraphics screen8;
PGraphics kinectScreen;

void setup() {
  background(0);
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100);
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

  kinectScreen = createGraphics(640, 480, P3D);
  kinectSurface = ks.createCornerPinSurface(640, 480, 20);

  center_surfaces();
}



void draw() {
  float dd = getMaximumDepth();
  float cratio = map(dd, dlow, dhigh, mincratio, maxcratio);
  drawPanels(70, 100, 3, cratio); // TODO adjust color
  background(0);
  render_surfaces();
}

/*
drawPanels - 
 draws panels to screen
 rdark - "darkness" of outer rectangle
 rbright - "brightness" of outer rectangle
 cdif - difference of brightness bewteen inner cell and outer rect
 cratio - ratio of size between inner cell and outer rect
 */
void drawPanels(float rdark, float rbright, float cdif, float cratio) {
  float cdark = rdark - cdif;
  float cbright = rbright;
  float cwidth = ceil(rectWidth * cratio);
  float cheight = ceil(rectHeight * cratio);
  float cx = ceil((rectWidth - cwidth) / 2);
  float cy = ceil((rectHeight - cheight) /2);
  int colorCycleL = ceil(speed*frameCount)%360;
  int colorCycleR = 360 - colorCycleL;

  screen1.beginDraw();
  screen1.fill(color(colorCycleL, rbright, rdark)); // -- TODO ADJUST PANEL COLORS/OPACITY--
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
getMaximumDepth -
 Iterates through every nth pixel and returns the value with the lowest depth (i.e. closest to the sensor).
 (From testing, it seems that 230 is the highest (close in proximity) value we can achieve,
 and 0 is the lowest (farthest in proximity) value)
 
 INPUTS:
 n - One in every n pixel will be compared
 display - selecting true displays the depth image from the kinect
 */
float getMaximumDepth() {
  PImage img = kinect.GetDepth();
  PImage mask = kinect.GetMask();
  float maxB = 0;
  for (int i = 0; i < img.pixels.length; i+=depthSkip) {
    if (alpha(mask.pixels[i]) == 0) continue;
    float b = brightness(img.pixels[i]);
    if (b > maxB) maxB = b;
  }
  return maxB;
}

/*
dispKinect -
draws what kinect sees
 */
void dispKinect() {
  PImage img = kinect.GetDepth();
  kinectScreen.beginDraw();
  kinectScreen.image(img, 0, 0);
  for (int i = 0; i < img.pixels.length; i += depthSkip) {
    kinectScreen.rect(i % 640, i/640, 4, 4);
  }
  kinectScreen.endDraw();
}

/*
move all surfaces to line up in the middle
 */
void center_surfaces() {
  int centAlign = (height - rectHeight)/2;
  surface1.moveTo(0, centAlign);
  surface2.moveTo(rectWidth, centAlign);
  surface3.moveTo(2*rectWidth, centAlign);
  surface4.moveTo(3*rectWidth, centAlign);
  surface5.moveTo(4*rectWidth, centAlign);
  surface6.moveTo(5*rectWidth, centAlign);
  surface7.moveTo(6*rectWidth, centAlign);
  surface8.moveTo(7*rectWidth, centAlign);
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
  if (show_kinect) dispKinect();
  if (show_kinect) kinectSurface.render(kinectScreen);
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
