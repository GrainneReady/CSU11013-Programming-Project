import java.lang.Math.*; //<>//
import java.util.*;

final int ALIEN_WIDTH = 30, ALIEN_HEIGHT = 25, CHANCE_OF_EXPLOSION = 1500, CHANCE_OF_DROPPING_POWER_UP = 2, CHANCE_OF_DROPPING_BOMB = 400, NUMBER_OF_POWER_UPS = 3, BULLET_HEIGHT = 16, BULLET_WIDTH = 4, POWER_UP_WIDTH = 15, POWER_UP_HEIGHT = 15, BOMB_WIDTH = 9, BOMB_HEIGHT = 21, PLAYER_WIDTH = 40, PLAYER_HEIGHT = 25;
PImage invader, invaderBlue, invaderGreen, invaderOrange, invaderPurple, invaderRed, invaderYellow;
PImage exploding, explodingBlue, explodingGreen, explodingOrange, explodingPurple, explodingRed, explodingYellow, logo, alienImg, alienJumpImg, alienWin, alienWinJump;
PImage shield1, shield2, shield3, shield4;
PImage bomb1, bomb2;
PImage playerImg;
PFont gameFont48, gameFont36, gameFont18;
ArrayList<Bullet> theBullets, bulletRemoveQueue;
ArrayList<PowerUps> thePowerUps, powerUpsAddQueue, powerUpsRemoveQueue;
ArrayList<Bomb> theBombs, bombAddQueue, bombRemoveQueue;
AdvancedAlien theAdvancedAliens[];
Player player;
Random randomNumberPicker = new Random();
int randomNumber, randomNumber2, randomNumber3, currentScreen = 1, startFlashTime, enemiesKilled = 0, bombsEvaded = 0, powerUpsObtained = 0;
boolean initializeArrayNeeded = true, usedPowerUp = false, showFlashText = true, powerUpAvailable = false, powerUpTypeGiven = false, powerUpObtained = false;
float previousAlienXValue = 0;
String powerUpTypeAvailable = "";
float currentPowerUpColor = 0;
Shield theShields[];
Shield shield;
void setup() {
  noStroke();
  size(500, 700);
  colorMode(HSB);
  textAlign(CENTER);
  gameFont48 = loadFont("Space-Invaders-48.vlw");
  gameFont36 = loadFont("Space-Invaders-36.vlw");
  gameFont18 = loadFont("Space-Invaders-18.vlw");
  invader = loadImage("invader.gif");
  invaderBlue = loadImage("invaderBlue.gif");
  invaderGreen = loadImage("invaderGreen.gif");
  invaderOrange = loadImage("invaderOrange.gif");
  invaderPurple = loadImage("invaderPurple.gif");
  invaderRed = loadImage("invaderRed.gif");
  invaderYellow = loadImage("invaderYellow.gif");
  exploding = loadImage("exploding.gif");
  explodingBlue = loadImage("explodingBlue.gif");
  explodingGreen = loadImage("explodingGreen.gif");
  explodingOrange = loadImage("explodingOrange.gif");
  explodingPurple = loadImage("explodingPurple.gif");
  explodingRed = loadImage("explodingRed.gif");
  explodingYellow = loadImage("explodingYellow.gif");
  shield1 = loadImage("shield1.gif");
  shield2 = loadImage("shield2.gif");
  shield3 = loadImage("shield3.gif");
  shield4 = loadImage("shield4.gif");
  bomb1 = loadImage("bomb1.gif");
  bomb2 = loadImage("bomb2.gif");
  playerImg = loadImage("player.gif");
  logo = loadImage("logo.gif");
  alienImg = loadImage("alien.gif");
  alienJumpImg = loadImage("alienJump.gif");
  alienWin = loadImage("alienWin.gif");
  alienWinJump = loadImage("alienWinJump.gif");
  theAdvancedAliens = new AdvancedAlien[10];
  theShields = new Shield[3];
  player = new Player(false);
  theBullets = new ArrayList<Bullet>();
  bulletRemoveQueue = new ArrayList<Bullet>();
  thePowerUps = new ArrayList<PowerUps>();
  powerUpsAddQueue = new ArrayList<PowerUps>();
  powerUpsRemoveQueue = new ArrayList<PowerUps>();
  theBombs = new ArrayList<Bomb>();
  bombAddQueue = new ArrayList<Bomb>();
  bombRemoveQueue = new ArrayList<Bomb>();
  textFont(gameFont36);
  startFlashTime = millis();
}

void draw() {
  background(0);
  switch(currentScreen) {
  case 1:
    imageMode(CENTER);
    image(logo, width/2, height/2 - 200);
    if (millis() > startFlashTime) {
      startFlashTime = millis() + 500;
      showFlashText = !showFlashText;
    }
    if (showFlashText) {
      image(alienJumpImg, width/2, height/2 + 100);
      fill(255);
      textFont(gameFont18);
      text("CLICK TO START", width/2, height/2 + 60);
    } else
      image(alienImg, width/2, height/2 + 100);
    break;
  case 2:
    imageMode(CORNER);
    //shield.draw();
    if (initializeArrayNeeded) {
      init_adv_aliens(theAdvancedAliens);
      initShields(theShields);
    } else {
      for (Shield i : theShields) {
        i.draw();
      }
      shieldCollisionChecker(theBullets, theBombs, theShields);
      bulletChecker(theBullets, theAdvancedAliens);
      for (AdvancedAlien i : theAdvancedAliens) {
        i.draw();
      }
      if (theBullets != null)
        if (!theBullets.isEmpty()) {
          theBullets.removeAll(bulletRemoveQueue);
          for (PowerUps p : thePowerUps) {
            if (!Collections.disjoint(bulletRemoveQueue, p.bullets))
              p.bullets.removeAll(bulletRemoveQueue);
          }
          bulletRemoveQueue.clear();
        }
      if (theBombs != null) {
        if (!theBombs.isEmpty()) {
          if (bombChecker(theAdvancedAliens, player))
            currentScreen = 3;
          theBombs.removeAll(bombRemoveQueue);
          bombRemoveQueue.clear();
        }
      }
      if (bombAddQueue != null)
        if (!bombAddQueue.isEmpty()) {
          theBombs.addAll(bombAddQueue);
          bombAddQueue.clear();
        }
      if (bombRemoveQueue != null)
        if (!bombRemoveQueue.isEmpty()) {
          theBombs.removeAll(bombRemoveQueue);
          bombRemoveQueue.clear();
        }


      if (thePowerUps != null)
        if (!thePowerUps.isEmpty()) {
          powerUpCollisionChecker(theBullets, thePowerUps);
          powerUpObtained = powerUpObtained(thePowerUps);
          for (PowerUps i : thePowerUps) {
            i.draw = true;
            i.draw();
            bulletChecker(i.bullets, theAdvancedAliens);
          }
          if (powerUpObtained) {
            fill(currentPowerUpColor, 255, 255);
            textFont(gameFont18);
            text(powerUpTypeAvailable, width/2, 60);
          }
        }

      if (powerUpsAddQueue != null) {
        if (!powerUpsAddQueue.isEmpty()) {
          thePowerUps.addAll(powerUpsAddQueue);
          powerUpsAddQueue.clear();
        }
      }

      if (powerUpsRemoveQueue != null) {
        if (!powerUpsRemoveQueue.isEmpty()) {
          thePowerUps.removeAll(powerUpsRemoveQueue);
          powerUpsRemoveQueue.clear();
        }
      }
      player.draw();
    }
    break;

  case 3:
    textFont(gameFont48);
    text("GAME OVER", width/2, height/3);
    textFont(gameFont18);
    text("Enemies Killed: " + enemiesKilled, width/2, height*12/16);
    text("Bombs Evaded: " + bombsEvaded, width/2, height*13/16);
    text("Power Ups Obtained: " + powerUpsObtained, width/2, height*14/16);
    break;
  case 4:
    imageMode(CENTER);
    textFont(gameFont48);
    fill(#00FF00);
    if (millis() > startFlashTime + 500) {
      startFlashTime = millis();
      showFlashText = !showFlashText;
    }
    if (showFlashText) {
      text("YOU WIN!", width/2, height/3);
      image(alienWinJump, width/2, height/2);
    }
    else
      image(alienWin, width/2, (height/2) - 1); 
    textFont(gameFont18);
    text("Enemies Killed: " + enemiesKilled, width/2, height*12/16);
    text("Bombs Evaded: " + bombsEvaded, width/2, height*13/16);
    text("Power Ups Obtained: " + powerUpsObtained, width/2, height*14/16);
    break;
  }
}
void shieldCollisionChecker(ArrayList<Bullet>bullets, ArrayList<Bomb> bombs, Shield shields[]) {
  for (Shield s : shields) {
    for (Bomb b : bombs)
      b.checkCollisionShield(s);
    for (Bullet b : bullets)
      b.checkCollisionShield(s);
  }
}


boolean powerUpObtained (ArrayList<PowerUps> powerUps) {
  boolean usesAvailable = false;
  if (powerUps != null)
    if (!powerUps.isEmpty()) {
      PowerUps currentPowerUp;
      Iterator<PowerUps> i = powerUps.iterator();
      while (!usesAvailable && i.hasNext()) {
        currentPowerUp = i.next();
        if (currentPowerUp.obtained) {
          if (currentPowerUp.usesLeft > 0) {
            switch(currentPowerUp.typeOfPowerUp) {
            case 3:
              powerUpTypeAvailable = "Burst Powerup";
              break;
            case 2:
              powerUpTypeAvailable = "Speed Powerup";
              break;
            case 1:
              powerUpTypeAvailable = "Spread Powerup";
              break;
            }
            currentPowerUpColor = currentPowerUp.powerUpColor;
            usesAvailable = true;
          }
        }
      }
    }
  return usesAvailable;
}
void bulletChecker(ArrayList<Bullet> bullets, AdvancedAlien[] aliens) {
  if (bullets != null && aliens != null)
    for (Bullet i : bullets) {
      i.move();
      i.draw();
      if (i.offScreen())
        bulletRemoveQueue.add(i);
      else
        for (AdvancedAlien alien : aliens) {
          if (i.collide(alien)) {
            enemiesKilled++;
            if (enemiesKilled == 10)
              currentScreen = 4;
            if (alien.dropPowerUpOnDeath()) {
              randomNumber2 = randomNumberPicker.nextInt((NUMBER_OF_POWER_UPS - 1) + 1) + 1;
              PowerUps powerUp = new PowerUps(randomNumber2, alien.location.x + ALIEN_WIDTH/2, alien.location.y + ALIEN_HEIGHT/2, millis());
              if (!powerUpsAddQueue.contains(powerUp))
                powerUpsAddQueue.add(powerUp);
              alien.draw = false;
            }
          }
        }
    }
}

boolean bombChecker(AdvancedAlien[] aliens, Player player) {
  if (aliens != null)
    for (AdvancedAlien i : aliens) {
      if (i.bomb != null) {
        i.bomb.move();
        i.bomb.draw();
        if (i.bomb.collide(player))
          return true;
        if (i.bomb.offScreen() && !bombRemoveQueue.contains(i.bomb) && i.bombDropped) {
          bombRemoveQueue.add(i.bomb);
          bombsEvaded++;
          i.bombDropped = false;
        }
      }
    }
  return false;
}

void powerUpCollisionChecker(ArrayList<Bullet> bullets, ArrayList<PowerUps> powerups) {
  if (bullets != null && powerups != null)
    for (Bullet i : bullets)
      for (PowerUps j : powerups)
        i.checkCollisionPowerUp(j);
}

void initShields(Shield shields[])
{
  for (int i = 0; i < shields.length; i++)
  {
    shields[i] = new Shield(i*width/3 + 47, height-(PLAYER_HEIGHT*2) - 73);
  }
}
void init_adv_aliens(AdvancedAlien theAdvancedAliens[])
{
  for (int i = 0; i < theAdvancedAliens.length; i++) {
    theAdvancedAliens[i] = new AdvancedAlien(0 + ((i * (4+ALIEN_WIDTH)) + 30), 0, invader, exploding, true);
    switch(i) {
    case 1:
    case 4:
      theAdvancedAliens[i].setAlienStatePortrayal(invaderBlue, explodingBlue);
      break;
    case 2:
      theAdvancedAliens[i].setAlienStatePortrayal(invaderGreen, explodingGreen);
      break;
    case 3:
    case 8:
      theAdvancedAliens[i].setAlienStatePortrayal(invaderOrange, explodingOrange);
      break;
    case 5:
    case 9:
      theAdvancedAliens[i].setAlienStatePortrayal(invaderPurple, explodingPurple);
      break;
    case 6:
    case 0:
      theAdvancedAliens[i].setAlienStatePortrayal(invaderRed, explodingRed);
      break;
    case 7:
      theAdvancedAliens[i].setAlienStatePortrayal(invaderYellow, explodingYellow);
      break;
    }
  }
  initializeArrayNeeded = false;
}

void mouseMoved() {
  player.setXCoordinate(mouseX);
}

void mouseClicked() {
  if (currentScreen == 1) {
    textFont(gameFont48);
    currentScreen = 2;
  } else if (currentScreen == 2) {
    usedPowerUp = false;
    if (powerUpObtained) {
      Iterator<PowerUps> i = thePowerUps.iterator();
      PowerUps currentPowerUp;
      while (i.hasNext() && !usedPowerUp) {
        currentPowerUp = i.next();
        if (currentPowerUp.obtained) {
          if (currentPowerUp.usesLeft > 0) {
            currentPowerUp.use(player);
            if (currentPowerUp.usesLeft > 0)
              powerUpObtained = false;
            usedPowerUp = true;
          } else if (currentPowerUp.checkOffScreen() && !powerUpsRemoveQueue.contains(currentPowerUp)) {
            powerUpsRemoveQueue.add(currentPowerUp);
          }
        }
      }
    }
    if (!usedPowerUp) {
      Bullet bullet = new Bullet(player.location.x, player.location.y, 0);
      theBullets.add(bullet);
    }
  }
}
