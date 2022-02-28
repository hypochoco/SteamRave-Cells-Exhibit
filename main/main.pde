/*

CHANGES SIZE OF INNER CELL BASED ON DEPTH

*/

//import kinect4WinSDK.Kinect;
//import kinect4WinSDK.SkeletonData;
import deadpixel.keystone.*;

// DIMENSIONS FOR EACH PANEL
int rectWidth;
int rectHeight;
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
float speed = 1;
int panelNum = 8;

//Kinect kinect;
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
  
  //kinect = new Kinect(this);
  ks = new Keystone(this);
  screens = new ArrayList<PGraphics>();
  surfaces = new ArrayList<CornerPinSurface>();
  for (int i=0; i<panelNum; i++){
    screens.add(createGraphics(rectWidth, rectHeight, P3D));
    surfaces.add(ks.createCornerPinSurface(rectWidth, rectHeight, 20));
  }
  
  center_surfaces();
}



void draw() {
  //float dd = getMaximumDepth();
  float cratio = 0.5;
  drawPanels(65, 45, 65, 45, cratio, 5);
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
void drawPanels(float rSaturation, float rBrightness, float cSaturation, float cBrightness, float cratio, float cdif) {
  float cwidth = ceil(rectWidth * cratio);
  float cheight = ceil(rectHeight * cratio);
  float cx = ceil((rectWidth - cwidth) / 2);
  float cy = ceil((rectHeight - cheight) /2);
  int colorCycleL = ceil(speed*frameCount)%360;
  int colorCycleR = 360 - colorCycleL;
  int c;
  for (int i=0; i<panelNum; i++){
    if (i%2==0){c = colorCycleL;}
    else {c = colorCycleR;}
    screens.get(i).beginDraw();
    screens.get(i).noStroke();
    screens.get(i).fill(color(c, rSaturation, rBrightness));
    screens.get(i).rect(0, 0, rectWidth, rectHeight);
    screens.get(i).fill(color(c + cdif, cSaturation, cBrightness));
    screens.get(i).rect(cx, cy, cwidth, cheight);
    screens.get(i).endDraw();
    //drawRect(screens.get(i),rectWidth, rectHeight, color(c, cSaturation, cBrightness), 5);
  }
}

// -- TODO: IMPLEMENT GRADIENT -- //
void drawRect(PGraphics screen, float rectWidth, float rectHeight, color c, int iteration) {
  screen.beginDraw();
  for (int i=0; i<iteration; i++){
    screen.fill(c);
    screen.noStroke();
    screen.rect(i, i, rectWidth, rectHeight);
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
//float getMaximumDepth() {
//  PImage img = kinect.GetDepth();
//  PImage mask = kinect.GetMask();
//  float maxB = 0;
//  for (int i = 0; i < img.pixels.length; i+=depthSkip) {
//    if (alpha(mask.pixels[i]) == 0) continue;
//    float b = brightness(img.pixels[i]);
//    if (b > maxB) maxB = b;
//  }
//  return maxB;
//}

/*
dispKinect -
draws what kinect sees
 */
//void dispKinect() {
//  PImage img = kinect.GetDepth();
//  kinectScreen.beginDraw();
//  kinectScreen.image(img, 0, 0);
//  for (int i = 0; i < img.pixels.length; i += depthSkip) {
//    kinectScreen.rect(i % 640, i/640, 4, 4);
//  }
//  kinectScreen.endDraw();
//}

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

///*
//functions to dodge warning from kinect4WinSDK
// */
//void appearEvent(SkeletonData _s) {
//  return;
//}

//void disappearEvent(SkeletonData _s) {
//  return;
//}

//void moveEvent(SkeletonData _b, SkeletonData _a) {
//  return;
//}