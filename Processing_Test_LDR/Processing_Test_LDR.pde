// Graphing sketch
 // This program takes ASCII-encoded strings
 // from the serial port at 115200 baud and graphs them. It expects values in the
 // range 0 to 1023, followed by a newline, or newline and carriage return
 
 // Based on:
 // Created 20 Apr 2005
 // Updated 18 Jan 2008
 // by Tom Igoe
 // This example code is in the public domain.
 
 // New version:
 // Created 27 Nov 2014
 // Updated ...
 // by fmendes
 // <
 
 import processing.serial.*;
 PFont f;                          // STEP 2 Declare PFont variable
 int[][] buf = new int[2][300];
 int buf_start=0;
 int buf_end=0;
 int buf_size = 300;
 bool state=0;
 
 String serialPort = "/dev/tty.usbmodem411";
 
 Serial myPort;        // The serial port
 int xPos = 1;         // horizontal position of the graph
 
 // Save Data on circular buffer
 void save_value(int[] inByte){
   if (buf_end == buf_size-1){  //Buffer cheio
     buf_end=0;   
   }else{
     buf_end++;
   }
   buf[0][buf_end] = inByte[0];
   buf[1][buf_end] = inByte[1];
/*   print(buf[0][buf_end]);
   print("-");
   print(buf[1][buf_end]);
   println(":");*/
 }
 
 // Draw graph
 void draw_graph(){
   background(0);
   
   //Plot gride
   stroke(155);
   for(int x=0; x<buf_size*4; x+=30){
      for(int y=0; y<height; y+=30){
       point(x , y);
     }
   }
   
   stroke(255);    //White
   //Plot graph using lines connecting dots
   for(int i=0, x=0; i<buf_size-1; i++, x+=4){
     //point(i , height - buf[i]);
     stroke(255);    //White
     line(x+1, height-buf[0][i+1]-10, x, height-buf[0][i]-10);
     stroke(100);    //White
     line(x+1, height/2-buf[1][i+1]-10, x, height/2-buf[1][i]-10);
   }
 }
 
 void setup () {
   size(buf_size*4, 300);                    // set the window size:
   background(0);                      // set inital background:
   f = createFont("Arial",16,true);   // STEP 3 Create Font
 
   // List all the available serial ports
   println(Serial.list());
   myPort = new Serial(this, serialPort, 115200);
   // don't generate a serialEvent() unless you get a newline character:
   myPort.bufferUntil('\n');
 }

void draw() {
  textFont(f,16);                 // STEP 4 Specify font to be used
  fill(255);                        // STEP 5 Specify font color 
}    
     
 void serialEvent (Serial myPort) {
   //String[] inString2 = new String[2];
   String[] inString2 = {"0000000000" ,"0000000000"};
   //int[] inByte = new int[2];
   int[] inByte={0, 0};
   int inByte1, inByte2;
   
   String inString = myPort.readStringUntil('\n');    // get the ASCII string:
   ///String inString = myPort.readStringUntil('.');    // get the ASCII string:
   println("Start");
   ///print(inString);
   
   if (inString != null && inString.indexOf(';')!=-1) {
     ///if ((inString != null) && (inString.indexOf(".") != 0)) {
     ///println("#");
     ///print(inString);    //Debug
     // trim off any whitespace:
     ///inString = trim(inString);
     inString2 = split(inString, ';');     
     
     inString2[0] = trim(inString2[0]);
     inByte[0] = int(inString2[0]);
     inByte[0] = (int)map(inByte[0], 0, 1023, 0, height);

     inString2[1] = trim(inString2[1]);
     inByte[1] = int(inString2[1]); 
     inByte[1] = (int)map(inByte[1], 0, 1023, 0, height);

     print("S");    //Debug
     print(inString2[0]);      
     print(";");               
     println(inString2[1]);
     
     print("i");    
     print(inByte[0]);
     print(";");
     println(inByte[1]); 
     
     //Detection algorithm
     if(state == 0 && inByte[1] > 5 )  //If state is Low and derivative is higher then threshold -> State transite to Hight
       
       
     //Print on screen
     save_value(inByte);
     draw_graph();
     text(inString2[0], 10, 100);  // STEP 6 Display Text
     
     // draw the line:
     //stroke(255);
     //line(xPos, height, xPos, height - inByte2);
     //point(xPos , height - inByte2);
     /*// at the edge of the screen, go back to the beginning:
     if (xPos >= width) {
       xPos = 0;
       background(0); 
     } 
     else {
       // increment the horizontal position:
       xPos++;
     }*/
   }
 }
