#include "Keyboard.h"

#define redBtn 9
#define greenBtn 10
#define blueBtn 8
#define yellowBtn 11
#define startBtn 12

boolean red_prev_state = false;
boolean green_prev_state = false;
boolean blue_prev_state = false;
boolean yellow_prev_state = false;
boolean start_prev_state = false;

void setup() {
  pinMode( redBtn, INPUT_PULLUP );
  pinMode( greenBtn, INPUT_PULLUP );
  pinMode( blueBtn, INPUT_PULLUP );
  pinMode( yellowBtn, INPUT_PULLUP );
  pinMode( startBtn, INPUT_PULLUP );
  Keyboard.begin();
}

void loop() {
  boolean red_state = ! digitalRead( redBtn );
  boolean green_state = ! digitalRead( greenBtn );
  boolean blue_state = ! digitalRead( blueBtn );
  boolean yellow_state = ! digitalRead( yellowBtn );
  boolean start_state = ! digitalRead( startBtn );
  
  if ( red_state && ! red_prev_state ) {
    Keyboard.print( "0" );
    delay( 100 );
  }
  
  if ( green_state && ! green_prev_state ) {
    Keyboard.print( "1" );
    delay( 100 );
  }
  
  if ( blue_state && ! blue_prev_state ) {
    Keyboard.print( "2" );
    delay( 100 );
  }
  
  if ( yellow_state && ! yellow_prev_state ) {
    Keyboard.print( "3" );
    delay( 100 );
  }
  
  if ( start_state && ! start_prev_state ) {
    Keyboard.print( "d" );
    delay( 100 );
  }

  red_prev_state = red_state;
  green_prev_state = green_state;
  blue_prev_state = blue_state;
  yellow_prev_state = yellow_state;
  start_prev_state = start_state;
}
