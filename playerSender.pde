Player[] player;

class Player {
  float x; 
  float y;
  float objID;

  float idTopd;

  String uri;
  float rot;

  


  color col = color(0,0,255);


  boolean linked = false;

  float linkedToBall;

  boolean free = true;

  Player(float xIn, float yIn, float objIDin, float rotIn, float idTopdIn) {

    x=xIn;    
    y=yIn;
    objID = objIDin;

    uri=uri;
    rot = rotIn;
    idTopd=idTopdIn;
  }
  void cantch(String uriIn, float ballIdIn) {
    linkedToBall = ballIdIn;
    uri=uriIn;
    //println(uri);
    
    
  }

  void display() {
    if(free)
    {
      stroke(0,0,122,(frameCount%25*9));
      strokeWeight(1);
      noFill();
      ellipse(x,y,obj_lupa-(frameCount%25*2),obj_lupa-(frameCount%25*2));
    }
    strokeWeight(objStroke);
    stroke(0,0,230,255);
    if(linked)stroke(0,0,100,255);


    noFill();
    ellipse(x,y,obj_player,obj_player);
  }

//    void send(float rotIn) {
//      rot = rotIn;
//  
//      if(linked) {
//        ///URI DEL ARCHIVO QUE REPRESENTA LA CELDA
//        if(savedUri!=uri) { 
//          OscMessage myOscMessage =  new OscMessage("/celda");
//          myOscMessage.add(idTopd); //ID de CELDa
//          myOscMessage.add(0);// ID del mensaje/parametro 
//          myOscMessage.add(uri);//mensaje/parametro
//          oscP5.send(myOscMessage, myBroadcastLocation);
//          savedUri = uri;
//        }
//        ///ROTACION DEL OBJETO CONECTADO A LA CELDA
//        if(savedRot!=rot) {
//          OscMessage myOscMessage =  new OscMessage("/celda");
//          myOscMessage.add(idTopd); //ID de CELDa
//          myOscMessage.add(1); // ID del mensaje/parametro
//          myOscMessage.add(map(rot,0,360,-2,2));//mensaje/parametro
//          oscP5.send(myOscMessage, myBroadcastLocation);
//          savedRot = rot;
//        }
//        //DISTANCIA DEL OBJETO A LA CELDA
//        if(savedPlayStop!=playStop) { 
//          OscMessage myOscMessage =  new OscMessage("/celda");
//          myOscMessage.add(idTopd); //ID de CELDa
//          myOscMessage.add(2);//mensaje/parametro
//          myOscMessage.add(0.9);//mensaje/parametro
//          oscP5.send(myOscMessage, myBroadcastLocation);
//        }
//  
//        //PLAY STOP
//      }
//    }
}















