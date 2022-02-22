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
  
  PImage img = kinect.GetDepth();
  image(img,0,0);
  float maxB = 0;
  int skip = 30;
  for (int i = 0; i < img.pixels.length; i+=skip) {
    float b = brightness(img.pixels[i]);
    if (b > maxB) maxB = b;
  }
  System.out.println(maxB);
}
