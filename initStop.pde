boolean otherWindow = true; 

void init(){
  if(otherWindow){
    frame.setAlwaysOnTop(false); 
    ///for full screen en 2da pantalla
    ///poner esto en el draw loop: frame.setLocation(1280,0);
    frame.dispose();  
    frame.setUndecorated(true);
  }
  
 
     
   
  super.init();  

 
}
public void stop() {


  super.stop();
}



/**************************
algunas funciones mas
****************************/


boolean recorded = false;
//grabar posicciones de objetos
void recPoss(){
  for (int i = 0; i < numBalls; i++) {
    
    ballMemoryPos[i] = new PVector(balls[i].x,balls[i].y);
    println("grabando posiciones de objeto nº"+i);
    if(i==numBalls-1)recorded=true;
    
   }
  if(recorded)println("grabacion de posiciones terminada");
  
}

void bordes(){
noFill();
    strokeWeight(3);  
    stroke(7,255,255);
    rect(1,1,width-2,height-2);
    poligono(width/2,height/2,60,440);
  
}



///POLOIGono REGULAR
void poligono(float posX, float posY, float rot, int rad) {

  float radio = rad;
  int nNodos = 6;
  PVector[] nodos = new PVector[nNodos];
  PVector pos = new PVector(width/2,height/2);

  float rotacion = radians(0);

  float angle = radians(360/nNodos);

  pos = new PVector(posX,posY,0);
  rotacion = radians(rot); //
  for(int i=0;i<nodos.length;i++) { //graba los nodos en pvectors
    nodos[i] = new PVector(pos.x+(cos((angle*i)+rotacion)*radio),pos.y+(sin((angle*i)+rotacion)*radio));
  }
  noFill();
  strokeWeight(3);
  stroke(3,255,255);
  beginShape();
  for(int i=0;i<nodos.length;i++) {
    vertex(nodos[i].x,nodos[i].y);
  }
  endShape(CLOSE);
}

