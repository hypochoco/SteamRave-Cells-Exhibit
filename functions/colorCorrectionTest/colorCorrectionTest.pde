float speed = 1;

void setup() {
  background(0);
  fullScreen(P3D);
  
}

void draw() {
  float cratio = 0.5;
  int colorCycleL = ceil(speed*frameCount)%360;
  float saturation = map(mouseX, 0, width, 0, 100);
  float brightness = map(mouseY, 0, height, 0, 100);
  int cwidth = ceil(width * cratio);
  int cheight = ceil(height * cratio);
  int cx = ceil((width - cwidth) / 2);
  int cy = ceil((height - cheight) /2);
  fill(color(colorCycleL, 70, 40));
  rect(0,0,width,height);
  fill(color((colorCycleL+10)%360, 77, 39));
  noStroke();
  rect(cx, cy, cwidth, cheight);
  println(saturation, brightness);
}
