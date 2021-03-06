/*

CHANGES SIZE OF INNER CELL BASED ON DEPTH

*/

/* --- INPUT PARAMS --- */
// DIMENSION BOUNDS FOR CELL
float maxcratio = 0.7;
float mincratio = 0.3;
// SPACING FOR getDepth()
int depthSkip = 700;
Boolean show_kinect = false;
// CALIBRATION FOR DEPTH
float dlow = 70;
float dhigh = 90;
// SPEED FOR COLOR CYCLING
float speed = 0.2;
int panelNum = 8;
/* --------------------- */

import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import deadpixel.keystone.*;

// DIMENSIONS FOR EACH PANEL
int rectWidth;
int rectHeight;

Kinect kinect;
Keystone ks;
CornerPinSurface kinectSurface;
PGraphics kinectScreen;
ArrayList<PGraphics> screens;
ArrayList<CornerPinSurface> surfaces;

void setup() {
  background(0);
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100);
  rectWidth = width / 8;
  rectHeight = ceil(1.618 * rectWidth);
  
  kinect = new Kinect(this);
  ks = new Keystone(this);
  screens = new ArrayList<PGraphics>();
  surfaces = new ArrayList<CornerPinSurface>();
  for (int i=0; i<panelNum; i++){
    screens.add(createGraphics(rectWidth, rectHeight, P3D));
    surfaces.add(ks.createCornerPinSurface(rectWidth, rectHeight, 20));
  }
  if (show_kinect) {
    kinectScreen = createGraphics(640, 480, P3D);
    kinectSurface = ks.createCornerPinSurface(640, 480, 20);
  }
  
  center_surfaces();
}



void draw() {
  float dd = getMaximumDepth();
  if (dd < dlow) dd = dlow;
  
  /* --- PARAMETERS --- */
  float panelSaturation = 70;
  float panelBrightness = 40;
  float cellSaturation = 70;
  float cellBrightness = 40;
  float cellRatio = 0.5;             // size of cell compared to panel  
  float cellHardness = map(dd, dlow, dhigh, 0.5, 0);          // width of the "blur"
  float cellColorDifference = -50;    // how ahead the cell hue will be
  /* ------------------ */
  
  drawPanels(panelSaturation, panelBrightness, cellSaturation, cellBrightness,
    cellRatio, cellHardness, cellColorDifference);
  background(0);
  render_surfaces();
}

/*
drawPanels - 
 draws panels to screen
 rBrightness - "darkness" of outer rectangle
 rSaturation - "brightness" of outer rectangle
 cdif - difference of brightness bewteen inner cell and outer rect
 cratio - ratio of size between inner cell and outer rect
 */
void drawPanels(float rSaturation, float rBrightness, float cSaturation, float cBrightness, float cratio, float feather, float cdif) {
  int colorCycleL = ceil(speed*frameCount)%360;
  int colorCycleR = 360 - colorCycleL;
  int c;
  float roundness = map(feather, 0, 0.5, 0, 100);
  for (int i=0; i<panelNum; i++){
    if (i%2==0){c = colorCycleL;}
    else {c = colorCycleR;}
    screens.get(i).beginDraw();
    screens.get(i).noStroke();
    screens.get(i).fill(color(c, rSaturation, rBrightness));
    screens.get(i).rect(0, 0, rectWidth, rectHeight);
    screens.get(i).endDraw();
    drawGradient(screens.get(i), rectWidth, rectHeight, cratio-feather, cratio+feather, c+cdif, c, 
    cSaturation, cSaturation, cBrightness, cBrightness, 100, roundness);
  }
}

void drawGradient(PGraphics screen, float rectWidth, float rectHeight, float minratio, float maxratio, float hue0, float hue, float saturation0, float saturation, float brightness0, float brightness, int iteration, float roundness) {
  screen.beginDraw();
  screen.noStroke();
  for (int i=iteration; i>0; i--){
    float ratio = map(i, 0, iteration, minratio, maxratio);
    float nwidth = rectWidth * ratio;
    float nheight = rectHeight * ratio;
    float nx = (rectWidth - nwidth) / 2;
    float ny = (rectHeight - nheight) /2;
    float nhue = (360 + map(i, 0, iteration, hue0, hue)) % 360;         // + 360 to account for negative cdif
    float nsaturation = map(i, 0, iteration, saturation0, saturation);
    float nbrightness = map(i, 0, iteration, brightness0, brightness);
    int c = color(nhue, nsaturation, nbrightness);
    screen.fill(c);
    screen.rect(nx, ny, nwidth, nheight, roundness);
  }
  screen.endDraw();
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
  for (int i=0; i<panelNum; i++){
    surfaces.get(i).moveTo(i*rectWidth, centAlign);
  }
}

/*
render all surfaces
 */
void render_surfaces() {
  for (int i=0; i<panelNum; i++){
    surfaces.get(i).render(screens.get(i));
  }
  if (show_kinect) {
    dispKinect();
    kinectSurface.render(kinectScreen);
  }
}

/*
keyPressed -
 toggle to adjust projections
 */
void keyPressed() {
  switch(key) {
  case 'c':
    ks.toggleCalibration();
    break;
  case 'l':
    ks.load();
    break;
  case 's':
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
