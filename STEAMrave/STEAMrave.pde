int start = 30;
int end = 100;
int iteration = 100;
int rectWidth = 200;
int rectHeight = 200;


void setup(){
  background(0);
  size(800,800);
  colorMode(HSB,360,100,100);
  fill(0,start,100);
  rect(0,0,800,800);
  
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
