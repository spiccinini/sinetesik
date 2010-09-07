import TUIO.*;
TuioProcessing tuioClient;

float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;

float obj_size; 
float cur_size;
float objStroke = 3;

float obj_lupa; 
float obj_player; 

void initTUIO() {
  scale_factor = height/table_size;
  tuioClient  = new TuioProcessing(this);

  obj_size = object_size*scale_factor; 
  cur_size = cursor_size*scale_factor;

  obj_lupa =  obj_size*2.3;

  obj_player = obj_lupa*0.65;
}


void updateTUIOcursr() {
  Vector tuioCursorList = tuioClient.getTuioCursors();

  PVector[] cur = new PVector[tuioCursorList.size()];
  if(tuioCursorList.size() > 0) {
    for (int i=0;i<tuioCursorList.size();i++) {

      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);

      cur[i] = new PVector(tcur.getScreenX(width),tcur.getScreenY(height),tcur.getCursorID());

      tuioCursorsToBalls(cur[i]);
      strokeWeight(3);
      point(cur[i].x,cur[i].y);
    }
  }
}

void updateTUIOobjts() {

  Vector tuioObjectList = tuioClient.getTuioObjects();
  PVector[] obj = new PVector[tuioObjectList.size()];
  player =  new Player[tuioObjectList.size()];

  if(tuioObjectList.size() > 0) {

    for (int j=0;j<tuioObjectList.size();j++) {

      TuioObject tobj = (TuioObject)tuioObjectList.elementAt(j);

      obj[j] = new PVector(tobj.getScreenX(width),tobj.getScreenY(height),tobj.getSymbolID());

      player[j] = new Player(obj[j].x,obj[j].y,obj[j].z,tobj.getAngle(),j);
     
      //      tuioObjetsToBalls(obj[i]); //////////////////////////
      for (int i = 0; i < numBalls; i++) {
        float dx = balls[i].x - player[j].x;
        float dy = balls[i].y - player[j].y;
        float distance = sqrt(dx*dx + dy*dy);

        float minDist = balls[i].realDiameter/2 + obj_lupa/2;
        float minDist2 = balls[i].realDiameter/2 + (obj_player+objStroke)/2;
///LUPA FUNCIONA MAL Y TRABA TODO
//        if (distance < minDist && distance > minDist2+3 ) { 
//
//          balls[i].lupaSize=2;
//
//          float angle = atan2(dy, dx);
//          float targetX = obj[j].x + cos(angle) * minDist2;
//          float targetY = obj[j].y + sin(angle) * minDist2;
//
//          balls[i].x = targetX;
//          balls[i].y = targetY;
//        }
        
       
        ///////CATCHHHH BALLL 
        if (distance < minDist2 && player[j].free) {
         balls[i].linkedTo=player[j].objID;
         balls[i].idToPd=player[j].idTopd;
         balls[i].rot=player[j].rot;
         println(tobj.getAngle());
         player[j].free=false;
         balls[i].linked=true;
         player[j].linked=true;
        
         player[j].cantch(balls[i].uri,balls[i].id);
         player[j].linkedToBall= balls[i].id;
        }
        
        
        if(player[j].objID == balls[i].linkedTo && distance > minDist2)balls[i].linked=false;

        
        if(player[j].linkedToBall==balls[i].id && balls[i].linked && player[j].linked){
        balls[i].update(player[j].x,player[j].y);
        }
      }
       //player[j].send(tobj.getAngle());
       player[j].display();
     
      /////////////////////////////////////////////////////////////////////////

      ///TUIO display
      strokeWeight(objStroke);
      //float a = atan2(width/2-tobj.getScreenX(width),height/2-tobj.getScreenY(height));

      noFill();
      stroke(0,0,0,50);

      ellipse(obj[j].x,obj[j].y,obj_lupa,obj_lupa);
    
      noStroke();
      fill(0,100);
      ellipse(obj[j].x,obj[j].y,obj_size,obj_size);
    }
  }
}

void addTuioObject(TuioObject tobj) {
}
void updateTuioObject(TuioObject tobj) {
//  for (int i = 0; i < player.length; i++) {
//  if(tobj.getSymbolID()==player[i].objID)player[i].updateFromTuio(tobj.getAngle());
//  
//  }
}
void removeTuioObject(TuioObject tobj) {
}
void addTuioCursor(TuioCursor tcur) {
}
void updateTuioCursor(TuioCursor tcur) {
  
}
void removeTuioCursor(TuioCursor tcur) {

  for (int i = 0; i < numBalls; i++) {
    if(balls[i].curId == tcur.getCursorID())balls[i].ON=false;
  }
}
void refresh(TuioTime bundleTime) {
}

/*****************
 
 hace bien esa lupa mocha
 
 *******************/
