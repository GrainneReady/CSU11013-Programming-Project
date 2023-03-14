class Ball {
  PVector location = new PVector(width/2, height/2);
  PVector velocity = new PVector(0, 0);
  float ballRadius = 12, angle, differenceFromTopToY, previousPaddleLocationY;
  boolean ballOffScreen = false;
  boolean BatScored = false;
  boolean firstCompCheck = true;
  boolean firstUserCheck = true;
  int currentRadians;

  Ball() {
    reset();
  }
  void draw() {
    fill(255);
    ellipse(location.x, location.y, ballRadius*2, ballRadius*2);
  }

  void updateSpeed(int numberOfHits, boolean ballOffScreen) {
    if (numberOfHits < 4 || ballOffScreen) {
      baseSpeed = 7;
      totalSpeed = baseSpeed;
      speedText = "Normal (7)";
      currentDifficulty = 1;
    } else if (numberOfHits >= 4 && numberOfHits < 12) {
      baseSpeed = 10;
      totalSpeed = baseSpeed;
      speedText = "Little Faster... (10)";
      currentDifficulty = 2;
    } else {
      baseSpeed = 15;
      totalSpeed = baseSpeed;
      speedText = "FASTEST (15)";
      currentDifficulty = 3;
    }
  }
  int updateCurrentRadians(float totalSpeed, boolean leftBat) {
    if (totalSpeed == 7)
      return (leftBat)? 45 : 135;
    else if (totalSpeed == 10)
      return (leftBat)? 55 : 125;
    else
    return (leftBat)? 65 : 115;
  }

  void checkUser(Bat Bat) {
    if (location.y - ballRadius < Bat.location.y + Bat.batHeight/2 && location.y + ballRadius > Bat.location.y - Bat.batHeight/2 && location.x - ballRadius < Bat.location.x + Bat.batWidth/2) {
      if (location.x >= Bat.location.x) {
        numberOfHits++;
        differenceFromTopToY = location.y - (Bat.location.y - Bat.batHeight/2);
        updateSpeed(numberOfHits, false);
        if (abs(previousPaddleLocationY - Bat.location.y) > 3)
          totalSpeed += constrain((abs(previousPaddleLocationY - Bat.location.y) * .0023) * totalSpeed, -3, 3);
        currentRadians = updateCurrentRadians(totalSpeed, true);
        angle = map(differenceFromTopToY, 0, Bat.batHeight, -radians(currentRadians), radians(currentRadians));
        velocity.x = totalSpeed * cos(angle);
        velocity.y = totalSpeed * sin(angle);
        location.x = Bat.location.x + Bat.batWidth/2 + ballRadius;
      }
    }
    previousPaddleLocationY = Bat.location.y;
  }
  void checkComputer(Bat Bat) {
    if (firstCompCheck) {
      previousPaddleLocationY = Bat.location.y;
      firstCompCheck = false;
    }
    if (location.y - ballRadius < Bat.location.y + Bat.batHeight/2 && location.y + ballRadius > Bat.location.y - Bat.batHeight/2 && location.x + ballRadius > Bat.location.x - Bat.batWidth/2) {
      if (location.x <= Bat.location.x) {
        numberOfHits++;
        differenceFromTopToY = location.y - (Bat.location.y - Bat.batHeight/2);
        updateSpeed(numberOfHits, false);
        if (abs(previousPaddleLocationY - Bat.location.y) > 3)
          totalSpeed += constrain((abs(previousPaddleLocationY - Bat.location.y) * 0.0023) * baseSpeed, -3, 3);
        currentRadians = updateCurrentRadians(totalSpeed, false);
        angle = map(differenceFromTopToY, 0, Bat.batHeight, radians(90+currentRadians), radians(currentRadians));
        velocity.x = totalSpeed * cos(angle);
        velocity.y = totalSpeed * sin(angle);
        location.x = Bat.location.x - Bat.batWidth/2 - ballRadius;
      }
    }
    previousPaddleLocationY = Bat.location.y;
  }




  void update() {
    location.x = location.x + velocity.x;
    location.y = constrain(location.y + velocity.y, 0, 800-ballRadius-1);
  }

  void reset() {
    endGameCheck();
    totalSpeed = 0;
    numberOfHits = 0;
    location.x = width/2;
    location.y = height/2;
    velocity.x = 0;
    velocity.y = 0;
    if (!ballOffScreen) {
      updateSpeed(numberOfHits, true);
      angle = random(radians(-30), radians(30));
      velocity.x = (BatScored) ? (totalSpeed * cos(angle)) : (totalSpeed * cos(angle)) * -1;
      velocity.y = (BatScored) ? (totalSpeed * sin(angle)) : (totalSpeed * sin(angle)) * -1;
      ballOffScreen = false;
      BatScored = false;
    }
  }

  void screenEdgeHitCheck() {
    if (location.y < 0 + ballRadius || location.y > height - ballRadius) {
      velocity.y *= -1;
    }
    if (location.x - ballRadius > width) {
      user.score++;
      BatScored = true;
      ballOffScreen = true;
      reset();
    }

    if (location.x + ballRadius < 0) {
      computer.score++;
      ballOffScreen = true;
      reset();
    }
  }
}
