class Player {
  PVector location = new PVector(0, height/2);
  float velocityX = 0;
  Player(boolean up) {
    if (up)
      location.y = PLAYER_HEIGHT/2;
    else
      location.y = height - PLAYER_HEIGHT/2;
  }

  void setXCoordinate(float x) {
    location.x = constrain(x, PLAYER_WIDTH/2, width - PLAYER_WIDTH/2);
  }

  void draw() {
    imageMode(CENTER);
    image(playerImg, location.x, location.y);
    imageMode(CORNER);
  }
}
