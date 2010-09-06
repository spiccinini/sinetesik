Player[] player;

class Player {
  float x; 
  float y;
  float objID;
  
  String uri;
  
  color col = color(0,0,255);

  
  boolean linked = false;
  
  Player(float xIn, float yIn, float objIDin) {

    x=xIn;    
    y=yIn;
    objID = objIDin;
    
    uri=uri;

   
   
 
    
   }
   void cantch(String uri){
    println(uri);
    
   }
   void update(color colIn){
     
   }
   void display(){
    if(linked)stroke(0,0,122,255);
    fill(col);
    ellipse(x,y,obj_player,obj_player);
   }
   

}
















