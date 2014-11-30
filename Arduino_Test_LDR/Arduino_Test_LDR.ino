/* Simple test of the functionality of the photo resistor

Connect the photoresistor one leg to pin 0, and pin to +5V
Connect a resistor (around 10k is a good value, higher
values gives higher readings) from pin 0 to GND. (see appendix of arduino notebook page 37 for schematics).

----------------------------------------------------

           PhotoR     10K
 +5    o---/\/\/--.--/\/\/---o GND
                  |
 Pin 0 o-----------

----------------------------------------------------
*/

int lightPin = 0;  //define a pin for Photo resistor
int ledPin=13;     //define a pin for LED
float t_a = 0;
float t_b = 1;
int   adc_LDR[2];
int  LDR_diff;
bool  detect_LDR;  //State of detection
int i; 
    
void setup()
{
    Serial.begin(115200);  //Begin serial communcation
    pinMode( ledPin, OUTPUT );
}

void backspace_n(int n){
int i;  
 
  for(i=0; i<n; i++)
    Serial.write(8);  //8d - ASCII backspace
}

// versao #3 para trabalhar com programa em Processing (Test_Graph2)
void loop()
{ 
    /* Teste valor incremental
    Serial.print(i);           //Write the value of the photoresistor to the serial monitor.
    Serial.print(" ; ");           //Write the value of the photoresistor to the serial monitor.
    Serial.println(i+1);           //Write the value of the photoresistor to the serial monitor.
    
    if(i++ == 1023)
      i=0;
    */
    
    // Read Sensor
    adc_LDR[0] = adc_LDR[1];
    adc_LDR[1] = analogRead(lightPin);
    //Calculate diferential value
    LDR_diff = adc_LDR[1] - adc_LDR[0];
    
    //Serial.print(".");           //Write the value of the photoresistor to the serial monitor.
    Serial.print(adc_LDR[1]);           //Write the value of the photoresistor to the serial monitor.
    Serial.print(" ; ");           //Write the value of the photoresistor to the serial monitor.
    Serial.println(LDR_diff);           //Write the value of the photoresistor to the serial monitor.
    //Serial.println(" :");           //Write the value of the photoresistor to the serial monitor.
    
    analogWrite(ledPin, adc_LDR[1]/4);  //send the value to the ledPin. Depending on value of resistor 
                                                //you have  to divide the value. for example, 
                                                //with a 10k resistor divide the value by 2, for 100k resistor divide by 4.
   
 
   delay(250); //short delay for faster response to light.
}

/* versao para trabalhar com programa Python(iBW_test1.py)
void loop()
{
    adc_LDR = analogRead(lightPin);
    Serial.print(adc_LDR); //Write the value of the photoresistor to the serial monitor.
    Serial.print(" , ");
    Serial.println(detect_LDR);
    
    analogWrite(ledPin, adc_LDR/4);  //send the value to the ledPin. Depending on value of resistor 
                                                //you have  to divide the value. for example, 
                                                //with a 10k resistor divide the value by 2, for 100k resistor divide by 4.
   
   delay(250); //short delay for faster response to light.
}*/
