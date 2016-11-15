void setup() {
  // put your setup code here, to run once:
  pinMode(1, INPUT_PULLUP);
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:

  int down1 = digitalRead(1);
  int down2 = digitalRead(1);
  int down3 = digitalRead(1);
  int down4 = digitalRead(1);
  
  if(down1 == HIGH){
    Serial.println("1");
  }  
}
