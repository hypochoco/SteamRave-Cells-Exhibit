import deadpixel.keystone.*;

int rectWidth;
int rectHeight;
Keystone ks;
PGraphics screen;
CornerPinSurface surface;

void setup() {
  background(0);
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100);
  rectWidth = width;
  rectHeight = height;
  
  ks = new Keystone(this);
  screen = createGraphics(rectWidth, rectHeight, P3D);
  surface = ks.createCornerPinSurface(rectWidth, rectHeight, 20);
}

void draw() {
  float x = map(mouseX, 0, width, 0, 360);
  float y = map(mouseY, 0, height, 0, 100);
  drawRect(screen, rectWidth, rectHeight, 0.7, 1, x, (x+50)%360, 40, 40, 70, 70, 100);
  surface.render(screen);
}

void drawRect(PGraphics screen, float rectWidth, float rectHeight, float minratio, float maxratio, float hue0, float hue, float saturation0, float saturation, float brightness0, float brightness, int iteration) {
  screen.beginDraw();
  screen.noStroke();
  for (int i=iteration; i>0; i--){
    float ratio = map(i, 0, iteration, minratio, maxratio);
    float nwidth = rectWidth * ratio;
    float nheight = rectHeight * ratio;
    float nx = (rectWidth - nwidth) / 2;
    float ny = (rectHeight - nheight) /2;
    float nhue = map(i, 0, iteration, hue0, hue);
    float nsaturation = map(i, 0, iteration, saturation0, saturation);
    float nbrightness = map(i, 0, iteration, brightness0, brightness);
    int c = color(nhue, nsaturation, nbrightness);
    screen.fill(c);
    screen.rect(nx, ny, nwidth, nheight, 100);
  }
  screen.endDraw();
}
