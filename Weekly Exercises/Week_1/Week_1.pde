import java.util.*;
final int MAXIMUM_COLOR_PARAMETER_VALUE = 255;
final float INCREMENT_IN_RADS = TWO_PI/90;
float angleInRadians = 0;
int currentExercise = 1;
int ex5HueDecider = 0;
Square square1, square2, square3, square4, square5, square6, square7, square8, square9, square10, square11, square12, square13;
ArrayList<Square> exercise1Squares = new ArrayList<Square>();
ArrayList<Square> exercise4Squares = new ArrayList<Square>();
ArrayList<Square> exercise5Squares = new ArrayList<Square>();
boolean incrementColor = false;

void setup() {
  size(300, 300);
  square1 = new Square (0, 0, 1, 1, 50, 50, 255, 0, 0);
  square2 = new Square (0, 250, 1, -1, 50, 50, 0, 255, 0);
  square3 = new Square (250, 250, -1, -1, 50, 50, 0, 0, 255);
  square4 = new Square (250, 0, -1, 1, 50, 50, 255, 255, 0);
  square5 = new Square (0, 50, 1, 0, 50, 50, 255, 255, 0);
  square6 = new Square (0, 50, 1, 0, 50, 50, 255, 255, 0);
  square7 = new Square (300, 50, 1, 0, 50, 50, 255, 255, 0);
  square8 = new Square (450, 200, -1, 0, 50, 50, 0, 255, 0);
  square9 = new Square (150, 200, -1, 0, 50, 50, 0, 255, 0);
  square10 = new Square (0, 0, 0, 0, 50, 50, 255, 255, 255);
  square11 = new Square (0, 0, 0, 0, 50, 50, 255, 255, 255);
  square12 = new Square (0, 0, 0, 0, 50, 50, 255, 255, 255);
  square13 = new Square (0, 0, 0, 0, 50, 50, 255, 255, 255);
  exercise1Squares.addAll(Arrays.asList(square1, square2, square3, square4));
  exercise4Squares.addAll(Arrays.asList(square6, square7, square8, square9));
  exercise5Squares.addAll(Arrays.asList(square10, square11, square12, square13));
  noStroke();
}

void draw() {
  background(0);
  switch(currentExercise)
  {

  case 1:
    for (Square i : exercise1Squares) {
      i.drawSquare();
      i.moveSquare();
    }
    break;

  case 2:
    square5.drawSquare();
    square5.moveSquare();
    if (square5.x == width - square5.width) {
      square5.setLocation(0, square5.height);
    }
    break;

  case 3:
    square6.drawSquare();
    square7.drawSquare();
    square6.moveSquare();
    square7.moveSquare();
    if (square7.x == width - square7.width) square6.setLocation(-50, 50);
    else if (square6.x == width - square6.width) square7.setLocation(-50, 50);
    break;

  case 4:
    for (Square i : exercise4Squares) {
      i.drawSquare();
      i.moveSquare();
    }
    if (square7.x == width - square7.width) square6.setLocation(-50, 50);
    else if (square6.x == width - square6.width) square7.setLocation(-50, 50);
    else if (square8.x == square8.width) square9.setLocation(350, 200);
    else if (square9.x == square9.width) square8.setLocation(350, 200);
    break;

  case 5:
    if (!incrementColor && ex5HueDecider !=  0)
      ex5HueDecider--;
    else if (incrementColor && ex5HueDecider != MAXIMUM_COLOR_PARAMETER_VALUE)
      ex5HueDecider++;
    else
      incrementColor = !incrementColor;
      
    square10.setColour(ex5HueDecider, MAXIMUM_COLOR_PARAMETER_VALUE, MAXIMUM_COLOR_PARAMETER_VALUE);
    square11.setColour(MAXIMUM_COLOR_PARAMETER_VALUE - ex5HueDecider, MAXIMUM_COLOR_PARAMETER_VALUE, MAXIMUM_COLOR_PARAMETER_VALUE);
    square12.setColour(ex5HueDecider, MAXIMUM_COLOR_PARAMETER_VALUE, MAXIMUM_COLOR_PARAMETER_VALUE);
    square13.setColour(MAXIMUM_COLOR_PARAMETER_VALUE - ex5HueDecider, MAXIMUM_COLOR_PARAMETER_VALUE, MAXIMUM_COLOR_PARAMETER_VALUE);

    if (square10.x == width - square10.width) 
      square12.setLocation(-square12.width, square12.y);
    else if (square11.x == square11.width) 
      square13.setLocation(width + square13.width, square13.y);
    if (square12.x == width - square12.width)
      square10.setLocation(-square10.width, square10.y);
    else if (square13.x == square13.width)
      square11.setLocation(width + square11.width, square11.y);
      
    if (square10.x > width)
      square10.x = 0;

    square11.x = (width - square11.width)-square10.x;
    square12.x = square10.x - width;
    square13.x = square11.x + width;
    square10.y = (sin(angleInRadians) * 100) + 120;
    square11.y = -square10.y + 240;
    square12.y = square10.y;
    square13.y = square11.y;
    for (Square i : exercise5Squares) {
      i.drawSquare();
    }
    angleInRadians += INCREMENT_IN_RADS;
    square10.x++;
    break;
  }
}

void keyPressed() {
  switch(key) {
  case '1':
    square1.setLocation(0, 0);
    square2.setLocation(0, height - square2.height);
    square3.setLocation(width - square3.width, height - square3.height);
    square4.setLocation(width - square4.width, 0);
  case '2':
  case '3':
  case '4':
    colorMode(RGB);
    currentExercise = Character.getNumericValue(key);
    break;
  case '5':
    colorMode(HSB);
    currentExercise = Character.getNumericValue(key);
  default:
    break;
  }
}
