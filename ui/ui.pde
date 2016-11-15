import java.util.*;

int colour1 = color(255, 0, 0);
int colour2 = color(0, 255, 0);
int colour3 = color(255, 0, 255);
int colour4 = color(255, 255, 0);
color[] colours = {colour1, colour2, colour3, colour4};

boolean isDemoing = false;
boolean isCapturing = false;
int round = 0;
int demoStep = 0;
int countdown = 0;
int timer = 500;

int currentRead;

// Clockwise from top right
//int[][] sequences = { {0, 1, 2, 3}, {3, 2, 1, 0}, {3, 2, 2, 1}, {3, 2, 3, 1} };
IntList round1 = new IntList(0, 1, 2, 3);
IntList round2 = new IntList(0, 1, 2, 1);
IntList attempt = new IntList();
ArrayList<IntList> sequences = new ArrayList<IntList>(4);

void setup() {
  size(400, 400);
  //fullScreen();
  sequences.add(round1);
  sequences.add(round2);
}

void draw() {
  background(0);
  IntList sequence = sequences.get(round);

  if (isDemoing == true) {

    if (demoStep >= sequence.size()) {
      isDemoing = false;
      reset();
    } else {
      drawSquare(sequence.get(demoStep));
    }

    if (millis() > countdown) {
      countdown = millis()+timer;
      demoStep++;
    }
    
  } else if (isCapturing) {
    int r = readSerial();
    if (r >= 0 && attempt.size() < 4) {
      attempt.append(r);
    } else if (attempt.size() == 4) {
      boolean result = Arrays.equals(sequence.array(), attempt.array());
      println(attempt);
      println(result);
    }
  }
}

int readSerial() {
  int read = key;
  int c = Character.getNumericValue(read);
  
  if(c < 4 && c >= 0){
    drawSquare(c);  
  }
  // Only return value if it is different
  // from the previous. 
  if (c != currentRead) {
    currentRead = c;
    return c;
  } else {
    return -1;
  }
}

void startDemo() {
  countdown = millis()+timer;
  reset();
  isDemoing = true;
  isCapturing = false;
}

void startCapture() {
  isCapturing = true;
  isDemoing = false;
  currentRead = Character.getNumericValue(key);
  //delay(1000);
}

void reset() {
  demoStep = 0;
  round = 0;
}

void keyPressed() {
  //println(keyCode);
  if (keyCode == 68) { // 49 is "1" & 68 is "d"
    startDemo();
  } else if (keyCode == 67) { // 49 is "2" & 68 is "c"
    startCapture();
  }
}

// Clockwise from top left
void drawSquare(int index) {
  fill(colours[index]);
  switch(index) {
  case 0:
    rect(0, 0, width/2, height/2);
    //println("top left");
    break;
  case 1:
    rect(width/2, 0, width/2, height/2);
    //println("top right");
    break;
  case 2:
    //println("bottom left");
    rect(0, height/2, width/2, height/2);
    break;
  case 3:
    //println("bottom right");
    rect(width/2, height/2, width/2, height/2);
    break;
  }
}