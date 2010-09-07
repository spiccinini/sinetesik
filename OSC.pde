import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myBroadcastLocation;

//CAL THIS FUNC on SETUP
void initOSC(){
  oscP5 = new OscP5(this,12000);
  myBroadcastLocation = new NetAddress("127.0.0.1",32000);
  }
///---------


//RESERVA OSC recive
// void oscEvent(OscMessage theOscMessage) {
//  /* print the address pattern and the typetag of the received OscMessage */
//  print("### received an osc message.");
//  print(" addrpattern: "+theOscMessage.addrPattern());
//  println(" typetag: "+theOscMessage.typetag());
//  
//}
