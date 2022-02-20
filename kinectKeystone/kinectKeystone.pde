import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import deadpixel.keystone.*;

Kinect kinect;

Keystone ks; // the Keystone object
CornerPinSurface surfaceOne; // our first surface
CornerPinSurface surfaceTwo; // the second surface

PGraphics offscreenOne; // offscreen buffer one
PGraphics offscreenTwo; // offscreen buffer two

// this is just for having something on the surfaces
int x = 0;
int y = 150;

void setup() {
  kinect = new Kinect(this);
  
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  size(800, 600, P3D);

  ks = new Keystone(this); // init the Keystone library
  surfaceOne = ks.createCornerPinSurface(400, 300, 20); // create the first surface
  surfaceTwo = ks.createCornerPinSurface(400, 300, 20); // and the second
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  offscreenOne = createGraphics(400, 300, P3D); 
  offscreenTwo = createGraphics(400, 300, P3D);
}

void draw() {
 
  offscreenOne.beginDraw();
  offscreenOne.background(0);
  offscreenOne.image(kinect.GetImage(), 0, 0, 320, 240);
  offscreenOne.endDraw();
  
  offscreenTwo.beginDraw();
  offscreenTwo.background(0);
  offscreenTwo.image(kinect.GetDepth(), 0, 0, 320, 240);
  offscreenTwo.endDraw();
  
  background(255);

  // render the scene, transformed using the corner pin surface
  surfaceOne.render(offscreenOne);
  surfaceTwo.render(offscreenTwo);
}

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
