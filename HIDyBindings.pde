
boolean bordersReference = true;



void keyPressed() {
  if (key == 'b' || key == 'B') {
bordersReference = !bordersReference;
  } 
}


void mousePressed(){
  PVector mouse=new PVector(mouseX,mouseY,666);
for (int i = 0; i < numBalls; i++) {
  balls[i].on(mouse);
  }  

  
}

void mouseDragged(){
  PVector mouse=new PVector(mouseX,mouseY,666);
  for (int i = 0; i < numBalls; i++) {
    if(mouse.z == balls[i].curId && balls[i].ON == true)balls[i].update(mouse.x,mouse.y);
  }  

  
}

void mouseReleased(){
  for (int i = 0; i < numBalls; i++) {
    if(balls[i].curId == 666)balls[i].ON=false;
  }
  
}


