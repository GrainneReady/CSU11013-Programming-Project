class Bomb {
  PVector location = new PVector(0, 0);
  PVector velocity = new PVector(0, 2);
  int previousMillis = millis();
  PImage currentImage;
  boolean useBomb1 = true;
  Bomb(float x, float y) {
    location.x = x;
    location.y = y;
  }

  void move() {
    location.y += velocity.y;
  }

  void draw() {
    updateImage();
    if (useBomb1)
      image(bomb1, location.x, location.y);
    else
      image(bomb2, location.x, location.y);
  }

  boolean offScreen() {
    if (location.y > height)
      return true;
    return false;
  }

  void updateImage() {
    if (millis() > previousMillis + 750) {
      previousMillis = millis();
      useBomb1 = !useBomb1;
    }
  }

  void checkCollisionShield(Shield shield) {
    if ((location.y + BOMB_HEIGHT >= shield.location.y) && (location.y <= shield.location.y + shield.dimensions.y) && (location.x + BOMB_WIDTH >= shield.location.x) && (location.x <= shield.location.x + shield.dimensions.x)) {
      if (shield.collidedBomb != null) {
        if (this != shield.collidedBomb) {
        shield.adjustStage(shield.stage+1);
        shield.collidedBomb = this;
        }
      }
      else {
        shield.collidedBomb = this;
        shield.adjustStage(shield.stage+1);
      }
      location.y = height*2;
    }
  }
  boolean collide(Player player) {
    if ((location.y + BOMB_HEIGHT >= player.location.y - PLAYER_HEIGHT/2) && (location.y <= player.location.y + PLAYER_HEIGHT/2) && (location.x + BOMB_WIDTH >= player.location.x - PLAYER_WIDTH/2) && (location.x <= player.location.x + PLAYER_WIDTH/2)) {
      return true;
    }
    return false;
  }
}
