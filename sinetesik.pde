import processing.opengl.*;

int numBalls;

Ball[] balls;

void setup() {
  size(1024,768);
  colorMode(HSB,11,255,255,255);
  noStroke();
  smooth();

  initTableClass();  //levanta valores del tsv
  numBalls = 1000;
  ballMemoryPos = new PVector [rowCount];

  balls =  new Ball[numBalls];
  ///crate balls!

  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(0, 0, random(5, 9), i, balls, locationTable.getString(i, 0), locationTable.getFloat(i, 1), ((locationTable.getFloat(i, 2))*7)%11);
  }

  for (int i = 0; i < numBalls; i++) {
    float bpmCorrect = 1;
    if(balls[i].bpm < 20)bpmCorrect=3;
    float radio = (balls[i].bpm)*(exp(0.4000))*bpmCorrect;
    float angle = radians(360*(balls[i].tonica/11)+bpmCorrect);
    balls[i].update(radio * cos(angle) + width/2, radio * sin(angle) + height/2);
  }

  initTUIO();
}

void draw() {
  //frame.setLocation(1024,0);
  background(0,0,255);

  updateTUIOcursr();



  for (int i = 0; i < numBalls; i++) {
    balls[i].calculos();
    balls[i].collide();
   
    //balls[i].borders(); 
    balls[i].display();

  }



  updateTUIOobjts();

  if(bordersReference) bordes();
    
  


  if((frameCount==16)||(keyPressed && key=='r'))recPoss();
    //println(frameRate);
}

///invocadas en  tuio 
void tuioCursorsToBalls(PVector cur) {  
  for (int i = 0; i < numBalls; i++) {
    balls[i].on(cur);
    if(cur.z == balls[i].curId && balls[i].ON == true)balls[i].update(cur.x,cur.y);
  }
}


void tuioObjetsToBalls(PVector obj) {  
 
}

