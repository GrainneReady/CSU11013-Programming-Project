class Bullet {
  PVector location = new PVector(0, 0);
  int typeOfBullet;
  PVector velocity = new PVector(0, -3);
  Bullet(float X, float Y, int typeOfBullet) {
    location.x = X;
    location.y = Y;
    this.typeOfBullet = typeOfBullet;
  }

  Bullet(float X, float Y, int typeOfBullet, float velocityX, float velocityY) {
    location.x = X;
    location.y = Y;
    this.typeOfBullet = typeOfBullet;
    velocity.x = velocityX;
    velocity.y = velocityY;
  }

  void move() {
    location.x += velocity.x;
    location.y += velocity.y;
  }

  void draw() {
    switch(typeOfBullet) {
    case 1:
      fill(#00FF00);
      break;
    case 2:
      fill(#33FFFF);
      break;
    case 3:
      fill(#FF0000);
      break;
    case 0:
      fill (#FDFF18);
      break;
    }
    rectMode(CENTER);
    rect(location.x, location.y, BULLET_WIDTH, BULLET_HEIGHT);
  }

  void setVelocityX(float x) {
    velocity.x = x;
  }
  
  boolean offScreen() {
    if (location.y < 0)
      return true;
    return false;
  }
  
  void checkCollisionShield(Shield shield) {
    if ((location.x + BULLET_WIDTH/2 >= shield.location.x) && (location.x - BULLET_WIDTH/2 <= shield.location.x + shield.dimensions.x) && (location.y - BULLET_HEIGHT/2 - 4 <= shield.location.y + (55 - shield.dimensions.y) + shield.dimensions.y) && (location.y + 4 + BULLET_HEIGHT/2 >= shield.location.y + (55 - shield.dimensions.y))) {
      if (shield.collidedBullet != null) {
        if (this != shield.collidedBullet) {
          shield.adjustStage(shield.stage+1);
          shield.collidedBullet = this;
        }
      }
      else {
        shield.adjustStage(shield.stage+1);
        shield.collidedBullet = this;
      }
      bulletRemoveQueue.add(this);
    }
  }

  void checkCollisionPowerUp(PowerUps powerup) {
    if ((millis() > (powerup.timeCreated + 1000)) && !powerUpObtained(thePowerUps)) {
      if ((location.x + BULLET_WIDTH/2 > powerup.location.x - POWER_UP_WIDTH/2) && (location.x - BULLET_WIDTH/2 < powerup.location.x + POWER_UP_WIDTH/2) && (location.y + BULLET_HEIGHT/2 > powerup.location.y - POWER_UP_HEIGHT/2) && (location.y - BULLET_HEIGHT/2 < powerup.location.y + POWER_UP_HEIGHT/2)) {
        powerup.obtained = true;
        powerUpObtained = true;
        powerUpsObtained++;
      }
    }
  }

  boolean collide(AdvancedAlien alien) {
    if (alien != null && alien.isAlive)
      if ((ALIEN_WIDTH + alien.location.x > location.x + BULLET_HEIGHT/2) && (alien.location.x < location.x + BULLET_WIDTH/2) && (ALIEN_HEIGHT + alien.location.y > location.y + BULLET_HEIGHT/2) && (alien.location.y < location.y + BULLET_HEIGHT/2)) {
        return true;
      }
    return false;
  }
}
