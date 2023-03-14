public class Square {
  float x;
  float y;
  float velocityX;
  float velocityY;
  int height;
  int width;
  int colorParameter1;
  int colorParameter2;
  int colorParameter3;
  
  public Square(float x, float y, float velocityX, float velocityY, int height, int width, int colorParameter1, int colorParameter2, int colorParameter3) {
    this.x = x;
    this.y = y;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    this.height = height;
    this.width = width;
    this.colorParameter1 = colorParameter1;
    this.colorParameter2 = colorParameter2;
    this.colorParameter3 = colorParameter3;
  }
  
  void drawSquare() {
    fill(colorParameter1, colorParameter2, colorParameter3);
    rect(x, y, width, height);
  }

  void moveSquare() {
    x += velocityX;
    y += velocityY;
  }
  void setLocation(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void setColour(int colorParameter1, int colorParameter2, int colorParameter3) {
    this.colorParameter1 = colorParameter1;
    this.colorParameter2 = colorParameter2;
    this.colorParameter3 = colorParameter3;
  }
}
