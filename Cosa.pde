PVector[] ballMemoryPos;

class Ball {
  float x, y;
  float diameter;
  Ball[] others;
  int id;

  String uri;
  float bpm;
  float tonica;
  float distanceT;
  boolean ON = false;
  boolean moving=false;

  boolean colide = true;
  float lupaSize;
  color col;

  //BPM convertion
  float pulse;
  float pulseUpDown;
  float pulseSpeed;
  ///----
  float z = 1;
  ///variacion tamaño on/off
  float sizeOnOff = 1;
  float realDiameter=diameter*sizeOnOff;

  //id del cursor vinculado al objeto
  float curId;

  //

  boolean linked = false;
  float linkedTo;


  ////funciones para OSC
  float rot;
  float savedRot;

  float playStop;
  float savedPlayStop;
  float idToPd;
  
  float distance = 0;
  float savedDistance;
  
 
 String savedUri;


  Ball(float xin, float yin, float din, int idin, Ball[] oin, String uriIn, float bpmIn, float tonicaIn) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;

    uri=uriIn;
    bpm=bpmIn;
    tonica=tonicaIn;
    lupaSize=1;

    //BPM 
    pulse = 0;
    pulseSpeed = (bpm/60)*2;
    pulseUpDown = 0.01;
  } 



  void collide() {
    realDiameter = diameter*sizeOnOff;
    if(colide) {
      for (int i = 0; i < numBalls; i++) {
        if (i == id)
          {continue;}
        float dx = others[i].x - x;
        float dy = others[i].y - y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = others[i].realDiameter/2 + realDiameter/2; ///con others[i].realDiameter/2 + realDiameter/2 funciana mal... revisar esto
        if (distance < minDist) {
          
          float angle = atan2(dy, dx);
          float moveX = cos(angle) * minDist;
          float moveY = sin(angle) * minDist;
          if(ON){
            others[i].x = x + moveX;
            others[i].y = y + moveY;
            continue;
          }
          else if(!others[i].ON){
            others[i].x = others[i].x + moveX/4 + minDist/100;
            others[i].y = others[i].y + moveY/4 + minDist/100;
            x =  x - cos(angle) * moveX/4 - minDist/100;
            y = y - sin(angle) * moveY/4 - minDist/100;
          }

        }
        
        if(curId == others[i].curId && ON && others[i].ON)others[i].ON=false;///MMM maomeno
      }
    }
  }

  void on(PVector cur) {

    distanceT = dist(cur.x,cur.y,x,y);
    float minDist = realDiameter/2;

    if (distanceT < minDist) {
      ON=true;
      curId = cur.z;
    }
  }   ///los objetos se apagan al remover el cursor anclado a ellos 

  void update(float xIn, float yIn) {
    float pastX = x;
    float pastY = y;
    x=xIn;
    y=yIn;
    if(x != pastX && y !=pastY)moving=true;
    ///
  }

  void calculos() {
    pulse = pulse+(pulseUpDown*pulseSpeed);

    if (pulse<=0.0)pulseUpDown=0.01;
    if (pulse>=1.0)pulseUpDown=-0.01;

    float satuCorrect = 1; /// para representar grises los archivos "sin tonica"
    if(tonica == -7)satuCorrect=0;
    if(tonica != -7)satuCorrect=1;

    if(!ON) {
      lupaSize=1;

      if(linked)lupaSize=obj_player/diameter;
      if(!linked)lupaSize=1;
      sizeOnOff=lupaSize;
      col=color(tonica, 160*satuCorrect, 110,75+(pulse*100));
    }
    if(ON) {
      if(!linked)lupaSize=1;
      sizeOnOff=4;
      col=color(tonica, 200*satuCorrect, 140,(150+pulse*105));
    }
  }

  void display() {
    noStroke();
    fill(col);
    ellipse(x, y, realDiameter, realDiameter);
  }

  ///por ahora no lo vamos a usar, pero lo dejamos por aca
  void borders() {
    if (x + realDiameter/2 > width) {
      x = width - realDiameter/2;
    }
    else if (x - diameter/2 < 0) {
      x = realDiameter/2;
    }
    if (y + realDiameter/2 > height) {
      y = height - realDiameter/2;
    } 
    else if (y - diameter/2 < 0) {
      y = realDiameter/2;
    }
  }

  void send() {
    if(!linked)playStop=0;

    if(linked)playStop= 1;

   
    ///URI DEL ARCHIVO QUE REPRESENTA LA CELDA
    if(savedUri!=uri && playStop==1) { 
      OscMessage myOscMessage =  new OscMessage("/celda");
      myOscMessage.add(idToPd); //ID de CELDa
      myOscMessage.add(0);// ID del mensaje/parametro 
      myOscMessage.add(uri);//mensaje/parametro
      oscP5.send(myOscMessage, myBroadcastLocation);
      savedUri = uri;
    }
    if(savedRot!=rot && playStop==1) {
      OscMessage myOscMessage =  new OscMessage("/celda");
      myOscMessage.add(idToPd); //ID de CELDa
      myOscMessage.add(1); // ID del mensaje/parametro
      myOscMessage.add(map(degrees(rot),0,360,-2,2));//mensaje/parametro
      oscP5.send(myOscMessage, myBroadcastLocation);
      savedRot = rot;
    }
            //DISTANCIA DEL OBJETO A LA CELDA
        if(savedDistance!=distance && playStop==1) { 
          distance = 0.5;
          OscMessage myOscMessage =  new OscMessage("/celda");
          myOscMessage.add(idToPd); //ID de CELDa
          myOscMessage.add(2);//mensaje/parametro
          myOscMessage.add(distance);//mensaje/parametro
          oscP5.send(myOscMessage, myBroadcastLocation);
          savedDistance=distance;
        }
  
     if(playStop!=savedPlayStop) {
      OscMessage myOscMessage =  new OscMessage("/celda");
      myOscMessage.add(idToPd); //ID de CELDa
      myOscMessage.add(3);// ID del mensaje/parametro 
      myOscMessage.add(playStop);//mensaje/parametro APAGADO!
      oscP5.send(myOscMessage, myBroadcastLocation);
      savedPlayStop=playStop;
    }
  }
}

/******************************
 TO DO list
 BPM, bien echo.
 consideracion, que no se queden como locas!!!
 
 revisar esto:
 con others[i].realDiameter/2 + realDiameter/2 funciana mal
 
 
 
 *******************************/
