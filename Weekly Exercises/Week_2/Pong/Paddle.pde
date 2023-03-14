class Bat {
  PVector location = new PVector(0, height/2);
  float batWidth = 20;
  float batHeight = 150;
  float velocityY = 0;
  float previousLocationY = location.y;
  boolean moveTowardsCorner = false;
  int previousNumberOfHits;
  int score = 0;
  int hitCornerOrCenterCheck = 0;
  boolean hitLowerSide = false;

  Bat(boolean left) {
    if (left) {
      location.x = batWidth;
    } else {
      location.x = width - batWidth;
    }
  }

  void setYCoordinate(float y) {
    location.y = constrain(y, batHeight/2, height-batHeight/2);
  }

  void computerMove() {
    velocityY = (ball.location.y - location.y) * (currentDifficulty * VELOCITY_MULTIPLIER);
    if (ball.velocity.x > 0 && numberOfHits != previousNumberOfHits) {
      if (currentDifficulty == 1) {
        moveTowardsCorner = false;
      } else if ((currentDifficulty == 3) || (currentDifficulty == 2 && (Math.random() <= 0.5) ? 1 : 2) % 2 == 0) {
        moveTowardsCorner = true;
        if (ball.location.y >= location.y) { // to move down
          hitLowerSide = true;
        } else if (ball.location.y < location.y) { // to move up
          hitLowerSide = false;
        }
      }
    }
    if (moveTowardsCorner && (hitLowerSide && ball.location.y < location.y - batHeight/3) || ball.velocity.y > 0)
      velocityY++;
    else if (moveTowardsCorner && (!hitLowerSide && ball.location.y > location.y + batHeight/3) || ball.velocity.y <= 0)
      velocityY--;
    location.y += constrain(velocityY, MINIMUM_VELOCITY, MAXIMUM_VELOCITY);
    location.y = constrain(location.y, batHeight/2, height - batHeight/2);
    previousNumberOfHits = numberOfHits;
  }


  void draw() {
    fill(255);
    rectMode(CENTER);
    rect(location.x, location.y, batWidth, batHeight);
  }
}
