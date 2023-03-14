class Alien {
  PVector location = new PVector(0, 0);
  PImage alienAlive;
  PImage alienDead;
  float speedIncrement = 2;
  float yPositionBeforeMoveDown;
  boolean isAlive, moveDown = false, draw = true, bombDropped = false;
  Bomb bomb;
  int random;
  Alien(float x, float y, PImage alienAlive, PImage alienDead, boolean isAlive)
  {
    location.x = x;
    location.y = y;
    this.alienAlive = alienAlive;
    this.alienDead = alienDead;
    this.isAlive = isAlive;
  }

  void draw() {
    if (draw) {
      if (isAlive) {
        dropBombCheck();
        updateLocation();
        image(alienAlive, location.x, location.y);
      } else
        image(alienDead, location.x, location.y);
    }
  }

  void updateLocation()
  {
    if ((location.x >= height - ALIEN_WIDTH || location.x <= 0) && !moveDown) {
      speedIncrement = speedIncrement * -1;
      yPositionBeforeMoveDown = location.y;
      moveDown = true;
    }
    if (moveDown) {
      if (yPositionBeforeMoveDown + ALIEN_HEIGHT == location.y)
        moveDown = false;
      else
        location.y += abs(speedIncrement);
    }
    if (!moveDown) {
      location.x += speedIncrement;
    }
  }

  void setAlienStatePortrayal(PImage invader, PImage explosion) {
    alienAlive = invader;
    alienDead = explosion;
  }

  boolean dropPowerUpOnDeath()
  {
    isAlive = false;
    random = randomNumberPicker.nextInt((CHANCE_OF_DROPPING_POWER_UP - 1) + 1) + 1;
    return (random == 1) ? true : false;
  }
  
  void dropBombCheck() {
    if (isAlive && !bombDropped) {
      random = randomNumberPicker.nextInt((CHANCE_OF_DROPPING_BOMB - 1) + 1) + 1;
      if (random == 1) {
        bombDropped = true;
        bomb = new Bomb(location.x + ALIEN_WIDTH/2, location.y + ALIEN_HEIGHT/2);
        bombAddQueue.add(bomb);
      }
    }
  }
}
