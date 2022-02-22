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
  end = map(getMaxDepth(),depthMin,depthMax,start,100);
  if (getMaxDepth() == 0){end = 100;}
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


// 255 (closer) - 0 (farther)
float getMaxDepth()
{
  PImage img = kinect.GetDepth();
  float maxB = 0;
  int skip = 30;
  for (int i = 0; i < img.pixels.length; i+=skip) {
    float b = brightness(img.pixels[i]);
    if (b > maxB) maxB = b;
  }
  println(maxB);
  return(maxB);
}
