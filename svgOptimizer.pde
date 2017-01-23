import processing.svg.*;

int canvasWidth = 600;
int canvasHeight = 600;

int canvasOriginX = 0;
int canvasOriginY = 0;

int newOriginLimitX = 100;
int newOriginLimitY = 100;

int newOriginWidth = 50;
int newOriginHeight = 50;

boolean showMaxOriginAreaFlag = true;
boolean showCurrOriginFlag = true;

int shapeXPos = 0;
int shapeYPos = 0;
int translateXPos = 0;
int translateYPos = 0;
int shapeWidth = 0;
int shapeHeight = 0;

float scaleVal = 1.0;

PShape frogs;

String homePoints;
boolean saveOneFrame = false;

void setup() {
  size(600, 600);
  //fullScreen();
  background(255);

  frogs = loadShape("SaurabhDatta.svg");

  translateXPos = canvasOriginX + newOriginWidth;
  translateYPos = (canvasOriginY+canvasHeight) - newOriginHeight;
  shapeWidth = int(frogs.width);
  shapeHeight = int(frogs.height);

  pushMatrix();
  translate(translateXPos, translateYPos);
  rotate(radians(270));
  shapeXPos = int(-frogs.width);
  shapeYPos = int(0);
  shape(frogs, shapeXPos, shapeYPos, frogs.width, frogs.height);
  popMatrix();
}

void draw() {
  if (saveOneFrame == true) {
    beginRecord(SVG, "sample.svg");
    //revrese();
  }

  g.background(255);

  if (showCurrOriginFlag == true && showMaxOriginAreaFlag == true) {
    showMaxOriginArea();
    showCurrOrigin();
  } else if (showCurrOriginFlag == false && showMaxOriginAreaFlag == true) {
    showMaxOriginArea();
  } else if (showCurrOriginFlag == false && showMaxOriginAreaFlag == false) {
  } else if (showCurrOriginFlag == true && showMaxOriginAreaFlag == false) {
    showCurrOrigin();
  } else {
  }

  translateXPos = canvasOriginX + newOriginWidth;
  translateYPos = (canvasOriginY+canvasHeight) - newOriginHeight;
  shapeWidth = int(frogs.width);
  shapeHeight = int(frogs.height);

  pushMatrix();
  translate(translateXPos, translateYPos);
  rotate(radians(270));
  scale(scaleVal);
  shape(frogs, shapeXPos, shapeYPos, frogs.width, frogs.height);
  popMatrix();

  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      shapeXPos++;
    }
    if (key == 's' || key == 's') {
      shapeXPos--;
    }
    if (key == 'a' || key == 'A') {
      shapeYPos--;
    }
    if (key == 'd' || key == 'D') {
      shapeYPos++;
    }
    if (key == '+' || key == '=') {
      scaleVal += 0.01;
    }
    if (key == '-' || key == '_') {
      scaleVal -= 0.01;
    }
  }

  if (saveOneFrame == true) {
    endRecord();
    saveOneFrame = false;
  }
}

void showCurrOrigin() {
  newOriginX();
  newOriginY();
  newOriginLabel();
}

void showMaxOriginArea() {
  xMaxOriginLimit();
  yMaxOriginLimit();
  maxNewOrigin();
}

void canvas() {
  noStroke();
  fill(255);
  canvasOriginX = (width - canvasWidth)/2;
  canvasOriginY = (height - canvasHeight)/2;
  rect(canvasOriginX, canvasOriginY, canvasWidth, canvasHeight);
}

void xMaxOriginLimit() {
  fill(180, 180, 180, 60);
  noStroke();
  rect(canvasOriginX, canvasOriginY+(canvasHeight - newOriginLimitY), canvasWidth, newOriginLimitY);
  //println(canvasOriginY+(canvasHeight - newOriginLimitY));
}

void yMaxOriginLimit() {
  fill(180, 180, 180, 60);
  noStroke();
  rect(canvasOriginX, canvasOriginY, newOriginLimitX, canvasHeight);
}

void maxNewOrigin() {
  noStroke();
  smooth();
  fill(255, 0, 0, 200);
  ellipse(canvasOriginX + newOriginLimitX, height - (newOriginLimitY), 10, 10);

  fill(80);
  String maxOriginLimitText = "[" + str(newOriginLimitX) + ", " + str(newOriginLimitY) + "]";
  text(maxOriginLimitText, canvasOriginX + newOriginLimitX + 10, height - (newOriginLimitY + 20));
}

void newOriginX() {
  stroke(51);
  strokeWeight(0.5);
  line(canvasOriginX + newOriginWidth, canvasOriginY, canvasOriginX + newOriginWidth, canvasOriginY + canvasHeight);
}

void newOriginY() {
  stroke(51);
  strokeWeight(0.5);
  line(canvasOriginX, (canvasOriginY+canvasHeight) - newOriginHeight, canvasOriginX + canvasWidth, (canvasOriginY+canvasHeight) - newOriginHeight);
}

void newOriginLabel() {
  noStroke();
  fill(#45887C);
  ellipse(canvasOriginX + newOriginWidth, (canvasOriginX + canvasHeight) - newOriginHeight, 10, 10);

  fill(80);
  String currOriginText = "[" + str(newOriginWidth) + ", " + str(newOriginHeight) + "]";
  text(currOriginText, canvasOriginX + newOriginWidth + 10, (canvasOriginX + canvasHeight) - (newOriginHeight + 10));
}

int counterM = 0;
int counterC = 0;

void keyPressed() {
  if (key == 'q' || key == 'Q') {
    homePoints = "X: " + str(newOriginWidth) + "," + "Y: " + str(newOriginHeight);
    String[] homePosition = split(homePoints, ',');
    saveStrings("homing_position.txt", homePosition);
    
    saveOneFrame = true;
    //reverse();
  }

  if (key == 'm' || key == 'M') {
    counterM++;
    if (counterM == 1) {
      showMaxOriginAreaFlag = true;
    }
    if (counterM >=2) {
      showMaxOriginAreaFlag = false;
      counterM = 0;
    }
  }

  if (key == 'c' || key == 'C') {
    counterC++;
    if (counterC == 1) {
      showCurrOriginFlag = true;
    }

    if (counterC >=2) {
      showCurrOriginFlag = false;
      counterC = 0;
    }
  }

  if (key == CODED) {
    if (keyCode == RIGHT) {
      newOriginWidth+=5;
      if (newOriginWidth > newOriginLimitX) {
        newOriginWidth = newOriginLimitX;
      }
    }

    if (keyCode == LEFT) {
      newOriginWidth-=5;
      if (newOriginWidth < 5) {
        newOriginWidth = 5;
      }
    }

    if (keyCode == UP) {
      newOriginHeight+=5;
      if (newOriginHeight > newOriginLimitY) {
        newOriginHeight = newOriginLimitY;
      }
    }

    if (keyCode == DOWN) {
      newOriginHeight-=5;
      if (newOriginHeight < 5) {
        newOriginHeight = 5;
      }
    }
  }
  
  if (key == 'l' || key == 'L') {
      selectInput("Select a file to process:", "fileSelected");
    }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    frogs = loadShape(selection.getAbsolutePath());
  }
}