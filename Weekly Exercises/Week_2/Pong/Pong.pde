// TO DO:
// ADJUST LINE 39 OF PADDLE
// FIX DECLARATIONS
// CLEAN UP CODE
// MAP


import java.lang.Math.*;
final int START_SCREEN = 1;
final int PLAY_SCREEN = 2;
final int USER_WON_SCREEN = 3;
final int USER_LOST_SCREEN = 4;
final float VELOCITY_MULTIPLIER = 0.025;
final float MAXIMUM_VELOCITY = 10;
final float MINIMUM_VELOCITY = -10;

PFont normalFont, gameOver, gameTitle;
Ball ball;
Bat user;
Bat computer;
float totalSpeed = 0;
int baseSpeed = 0;
int numberOfHits = 0;
int currentScreen = 1;
int currentDifficulty = 1;
int previousSecond = 0;
int startFlashTime = 0;
boolean showGameOverText = false;
boolean showStartText = false;
String speedText = "Normal";

void setup() {
  size(800, 600);
  normalFont = loadFont("Game-Over-48.vlw");
  gameOver = loadFont("Game-Over-200.vlw");
  gameTitle = loadFont("Game-Over-256.vlw");
  user = new Bat(true);
  computer = new Bat(false);
  ball = new Ball();
  textFont(normalFont);
  textAlign(CENTER);
  textSize(64);
  startFlashTime = millis();
}

void draw() {
  background(0);
  switch(currentScreen) {
  case 1:
    textFont(gameTitle);
    textSize(512);
    text("PONG", width/2, height/2 - 25);
    textFont(normalFont);
    if (millis() > startFlashTime) {
      startFlashTime = millis() + 500;
      showStartText = !showStartText;
    }
    if (showStartText) {
      fill(100);
      text("CLICK MOUSE TO START", width/2, height/2 + 50);
      fill(255);
    }

    break;

  case 2:
    textFont(normalFont);
    ball.checkComputer(computer);
    ball.checkUser(user);
    ball.update();
    ball.screenEdgeHitCheck();
    ball.draw();
    user.draw();
    computer.computerMove();
    computer.draw();
    fill(0, 255, 50);
    text("BASE SPEED: " + speedText, width/2, 40);
    text(String.format("Current Speed: %.2f", totalSpeed), width/2, 60);
    break;

  case 3:
    textFont(gameOver, 200);
    if (second() != previousSecond)
      showGameOverText = !showGameOverText;
    fill(0, 255, 50);
    if (showGameOverText)
      text("YOU WIN!", width/2, height/2);
    previousSecond = second();
    break;
  case 4:
    textFont(gameOver, 200);
    if (second() != previousSecond)
      showGameOverText = !showGameOverText;
    fill(0, 255, 50);
    if (showGameOverText)
      text("GAME OVER", width/2, height/2);
    previousSecond = second();
    break;
  }
  if (currentScreen != 1) {
    textSize(64);
    text(user.score, 32, 40);
    text(computer.score, width-32, 40);
  }
}

void endGameCheck() {
  if (user.score == 3)
    currentScreen = 3;
  else if (computer.score == 3)
    currentScreen = 4;
}
void mouseMoved() {
  user.setYCoordinate(mouseY);
}
void mouseClicked() {
  if (currentScreen == 1)
    currentScreen++;
  if (ball.ballOffScreen) {
    ball.ballOffScreen = false;
    ball.reset();
    if (user.score == 3)
      currentScreen = 3;
    else if (computer.score == 3)
      currentScreen = 4;
    else currentScreen = 2;
  }
}
