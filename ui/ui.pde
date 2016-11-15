import java.util.*;

int colour1 = color( 255, 0, 0 );
int colour2 = color( 0, 255, 0 );
int colour3 = color( 0, 0, 255 );
int colour4 = color( 255, 255, 0 );
color[] colours = { colour1, colour2, colour3, colour4 };

boolean isDemoing = false;
boolean isCapturing = false;
boolean isWaiting = true;
boolean isWinner = true;
boolean isSuccess = false;
boolean isFailed = false;
int round = 0;
int demoStep = 0;
int countdown = 0;
int timer = 500;
int textTimer = 0;
int boxTimer = 0;

// Clockwise from top right
IntList round1 = new IntList( 0, 1, 2, 3 );
IntList round2 = new IntList( 0, 1, 2, 3, 2 );
IntList round3 = new IntList( 0, 1, 2, 3, 2, 1 );
IntList round4 = new IntList( 0, 1, 2, 3, 2, 1, 0 );
int lastSquare = -1;
IntList attempt = new IntList();
IntList sequence = new IntList();
ArrayList<IntList> sequences = new ArrayList<IntList>(4);

void setup() {
 //size(500, 500);
 fullScreen();
 sequences.add( round1 );
 sequences.add( round2 );
 sequences.add( round3 );
 sequences.add( round4 );
 noStroke();
 noCursor();
 setRound( 0 );
}

void draw() {
 background( 0 );

 // Mode: Demoing sequence
 if ( isWaiting ) {
   drawText( "Ready?" );
 } else if ( isDemoing ) {
   // If we've done all the steps go back to waiting mode
   if ( demoStep >= sequence.size() ) {
     reset();
     startCapture();
   // Otherwise draw the square
   } else {
     drawSquare( sequence.get( demoStep ) );
   }

   // Set timeout until step counter increments
   if ( millis() > countdown ) {
     countdown = millis() + timer;
     demoStep++;
   }

 // Mode: Capturing sequence
 } else if ( isCapturing ) {
   if ( boxTimer > millis() ) maintainSquare();

   if ( attempt.size() == 0 )
     drawText( "Round: " + ( round + 1 ) + "\nMake your move..." );

   if ( attempt.size() == sequence.size() ) {
     boolean result = Arrays.equals( sequence.array(), attempt.array() );

     // Clear attempt list
     attempt = new IntList();

     if ( result ) {
       if ( round == sequences.size() - 1 ) {
         isCapturing = false;
         isWinner = true;
         textTimer = millis() + 5000;
       } else {
         isCapturing = false;
         isSuccess = true;
         textTimer = millis() + 2500;
         setRound( round + 1 );
       }
     } else {
       setRound( 0 );
       isCapturing = false;
       isFailed = true;
       textTimer = millis() + 2500;
     }
   } 
 } else if ( isWinner ) {
   if ( boxTimer > millis() ) {
     maintainSquare();
   } else {
     drawText( "Congratulations!" );
   }

   if ( millis() > textTimer ) {
     reset();
     setRound( 0 );
     textTimer = 0;
   }
 } else if ( isSuccess ) {
   if ( boxTimer > millis() ) {
     maintainSquare();
   } else {
     drawText( "Way to go!" );
   }

   if ( millis() > textTimer ) {
     isSuccess = false;
     startDemo();
     textTimer = 0;
   }
 } else if ( isFailed ) {
   if ( boxTimer > millis() ) {
     maintainSquare();
   } else {
     drawText( "Try harder next time" );
   }

   if ( millis() > textTimer ) {
     reset();
     textTimer = 0;
   }
 }
}

void setRound( int r ) {
 if ( r < 0 || r >= sequences.size() ) {
   r = 0;
 }
 round = r;
 sequence = sequences.get( round );
}

void maintainSquare() {
 if ( lastSquare != -1 )
   drawSquare( lastSquare );
}

void drawRound() {
 drawText( "Round " + ( round + 1 ) );
}

void drawText( String text ) {
 fill( 255 );
 textSize( 48 );
 textAlign( CENTER, CENTER );
 text( text, width / 2, height / 2 );
}

void startDemo() {
 countdown = millis() + timer;
 reset();
 isWaiting = false;
 isDemoing = true;
 isCapturing = false;
 isWinner = false;
 isSuccess = false;
 isFailed = false;
}

void startCapture() {
 isWaiting = false;
 isCapturing = true;
 isDemoing = false;
 isWinner = false;
 isSuccess = false;
 isFailed = false;
}

void reset() {
 isDemoing = false;
 isCapturing = false;
 isWaiting = true;
 isWinner = false;
 isSuccess = false;
 isFailed = false;
 demoStep = 0;
}

void keyPressed() {
 switch ( key ) {
   case 'd':
     startDemo();
     break;
   case '=':
     setRound( round + 1 );
     break;
 }

 if ( isCapturing ) {
   int c = Character.getNumericValue( keyCode );

   if( c < 4 && c >= 0 ){
     drawSquare( c );
     boxTimer = millis() + 500;
     if ( attempt.size() < sequence.size() ) {
       attempt.append( c );
     }
   }
 }
}

// Clockwise from top left
void drawSquare( int index ) {
 lastSquare = index;
 fill( colours[index] );
 switch( index ) {
 case 0:
   rect( 0, 0, width/2, height/2 );
   break;
 case 1:
   rect( width/2, 0, width/2, height/2 );
   break;
 case 2:
   rect( 0, height/2, width/2, height/2 );
   break;
 case 3:
   rect( width/2, height/2, width/2, height/2 );
   break;
 }
}
