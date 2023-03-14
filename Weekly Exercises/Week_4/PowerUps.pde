class PowerUps {
  // Powerup 1 = Width (3 bullets next to each other on same y level) red
  // Powerup 2 = Speed Bullets (faster bullet) blue
  // Powerup 3 = Burst (3 vertical bullets at same x after each other) green
  int typeOfPowerUp, usesLeft = 5, powerUpColor;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  boolean obtained = false, draw = true;
  PVector location = new PVector(0, 0);
  float timeCreated;
  PowerUps(int typeOfPowerUp, float x, float y, float timeCreated) {
    this.typeOfPowerUp = typeOfPowerUp;
    if (typeOfPowerUp == 1) {
      powerUpColor = 90;
    } else if (typeOfPowerUp == 2) {
      powerUpColor =  120;
    } else {
      powerUpColor = 0;
    }
    location.x = x;
    location.y = y;
    this.timeCreated = timeCreated;
  }

  boolean use(Player player) {
    if (usesLeft > 0) {
      if (typeOfPowerUp == 1) {
        Bullet bullet1 = new Bullet(player.location.x - BULLET_WIDTH - 4, player.location.y, 1, 0, -4);
        Bullet bullet2 = new Bullet(player.location.x, player.location.y, 1, 0, -4);
        Bullet bullet3 = new Bullet(player.location.x + BULLET_WIDTH + 4, player.location.y, 1, 0, -4);
        bullets.addAll(Arrays.asList(bullet1, bullet2, bullet3));
        theBullets.addAll(Arrays.asList(bullet1, bullet2, bullet3));
      } else if (typeOfPowerUp == 2) {
        Bullet bullet4 = new Bullet(player.location.x, player.location.y, 2, 0, -6);
        bullets.add(bullet4);
        theBullets.add(bullet4);
      } else {
        Bullet bullet5 = new Bullet(player.location.x, player.location.y, 3, 0, -4);
        Bullet bullet6 = new Bullet(player.location.x, player.location.y + BULLET_HEIGHT + 4, 3, 0, -4);
        Bullet bullet7 = new Bullet(player.location.x, player.location.y + 2 * (BULLET_HEIGHT + 4), 3, 0, -4);
        bullets.addAll(Arrays.asList(bullet5, bullet6, bullet7));
        theBullets.addAll(Arrays.asList(bullet5, bullet6, bullet7));
      }
      usesLeft--;
      return true;
    }
    return false;
  }

  void draw() {
    if (obtained && usesLeft > 0) {
      location.x = width - POWER_UP_WIDTH;
      location.y = height - POWER_UP_HEIGHT;
    } else if (obtained && usesLeft <= 0) {
      location.x = -300;
      location.y = -300;
    }
    if (draw) {
      fill (powerUpColor, 255, 255);
      rectMode(CENTER);
      rect(location.x, location.y, POWER_UP_WIDTH, POWER_UP_HEIGHT);
    }
  }
  boolean checkOffScreen() {
    for (Bullet bullet : bullets) {
      if (bullet.location.y > 0)
        return false;
    }
    return true;
  }
}
