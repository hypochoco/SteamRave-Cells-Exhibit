import kinect4WinSDK.Kinect;

int start = 30;
float end = 100;
int iteration = 10;
int rectWidth = 700;
int rectHeight = 700;
int depthMax = 90;
int depthMin = 60;

Kinect kinect;

void setup(){
  background(0);
  size(800,800);
  colorMode(HSB,360,100,100);
  fill(0,start,100);
  rect(0,0,800,800);
   
  background(0);
  kinect = new Kinect(this);
  smooth();
  
  //float halfWidth = width/2;
  //float halfHeight = height/2;
  
  //drawRect(halfWidth, halfHeight, 400, 400, end);
  
  //for (int i=0; i<iteration; i++){
  //  float s = map(i, 0, iteration, start, end);
  //  float w = map(i, 0, iteration, 800, 800);
  //  float h = map(i, 0, iteration, 800, 100);
  //  drawRect(halfWidth, halfHeight, w, h, s);
  //}
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
}

void drawRect(float centerX, float centerY, float w, float h, float saturation){
  float halfWidth = w/2;
  float halfHeight = h/2;
  fill(0,saturation,100);
  noStroke();
  rect(centerX-halfWidth,centerY-halfHeight,w,h);
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
