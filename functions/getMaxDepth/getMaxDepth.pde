import kinect4WinSDK.Kinect;

Kinect kinect;

void setup()
{
  size(640, 480, P3D);
  background(0);
  kinect = new Kinect(this);
  smooth();
}

void draw()
{
  background(0);
  println(getMaximumDepth(700, true));
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
  PImage mask = kinect.GetMask();
  if (display) image(img,0,0);
  float maxB = 0;
  for (int i = 0; i < img.pixels.length; i+=n) {
    if (display) rect(i%width, floor(i/width),4,4);
    if (alpha(mask.pixels[i]) == 0) continue;
    float b = brightness(img.pixels[i]);
    if (b > maxB) maxB = b;
  }
  return maxB;
}
