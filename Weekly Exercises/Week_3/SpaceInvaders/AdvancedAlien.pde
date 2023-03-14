class AdvancedAlien extends Alien {
  float incrementRads = (float)(Math.random() * (TWO_PI/40 - TWO_PI/60)) + TWO_PI/60, angleInRadians = 0;
  int timesMovedDown = 0;
  AdvancedAlien(float x, float y, PImage alienAlive, PImage alienDead, boolean isAlive) {
    super(x, y, alienAlive, alienDead, isAlive);
  }
  
  @Override
  void updateLocation(){
      {
    if ((location.x >= width - ALIEN_WIDTH || location.x <= 0) && !moveDown) {
      speedIncrement = speedIncrement * -1;
      yPositionBeforeMoveDown = location.y;
      moveDown = true;
    }
    if (moveDown) {
      if (yPositionBeforeMoveDown + 46 <= location.y) {
        moveDown = false;
        timesMovedDown++;
      }
      else
        location.y += abs(speedIncrement);
    }
    if (!moveDown) {
      location.x += speedIncrement;
      location.y = ((sin(angleInRadians) * 5) + 120) + (timesMovedDown * 46);
      
      angleInRadians += incrementRads;
    }
  }
  speedIncrement *= 1.0004;
  }
  
}
