class Shield {
  int stage = 1;
  Bullet collidedBullet;
  Bomb collidedBomb;
  PVector dimensions = new PVector(75, 55);
  PVector location = new PVector(0, 0);
  Shield(float x, float y) {
    location.x = x;
    location.y = y;
  }

  void draw() {
    switch(stage) {
    case 1:
      image(shield1, location.x, location.y);
      break;
    case 2:
      image(shield2, location.x, location.y);
      break;
    case 3:
      image(shield3, location.x, location.y);
      break;
    case 4:
      image(shield4, location.x, location.y);
      break;
    default:
      break;
    }
  }

  void adjustStage(int stage) {
    if (stage <= 5 && stage >= 1)
      this.stage = stage;
    switch(stage) {
    case 1:
      dimensions.x = 75;
      dimensions.y = 55;
      break;
    case 2:
      dimensions.x = 75;
      dimensions.y = 48;
      break;
    case 3:
      dimensions.x = 75;
      dimensions.y = 37;
      break;
    case 4:
      dimensions.x = 75;
      dimensions.y = 26;
      break;
    default:
      location.x = -200;
      location.y = -200;

    }
  }
}
