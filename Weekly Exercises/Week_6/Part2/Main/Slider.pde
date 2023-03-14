class Slider extends Widget {
  PVector outerRectLocation = new PVector(0, 0);
  PVector innerRectLocation = new PVector(0, 0);
  PVector innerXLimits = new PVector(0, 0);
  PVector innerRectSize = new PVector(50, 20);
  boolean isHovering = false;
  int currentNumber = 0;
  Slider(float x1, float y1, float x2, float y2, int min, int max, PFont sliderFont, int event, String label) {
    super(label, sliderFont, event);
    outerRectLocation.x = x1;
    outerRectLocation.y = y1;
    innerRectLocation.x = x2;
    innerRectLocation.y = y2;
    innerXLimits.x = min;
    innerXLimits.y = max;
  }

  void updateInnerLocationX(float newX)
  {
    innerRectLocation.x = constrain(newX - innerRectSize.x/2, innerXLimits.x, innerXLimits.y);
    //currentNumber = (int)((innerRectLocation.x - (outerRectLocation.x + 25)) / (innerXLimits.y - 25)*100);
    //text(innerRectLocation.x, 200, 200);
    //currentNumber = (int)(((innerRectLocation.x - (outerRectLocation.x + 25)) / (innerXLimits.y))*100);
    currentNumber = (int)(((innerRectLocation.x - (innerRectSize.x - 50) / innerXLimits.y - innerRectSize.x/2)) - (innerRectSize.x/2));
  }

  void draw() {
    fill(255);
    rect(outerRectLocation.x + innerRectSize.x, outerRectLocation.y + innerRectSize.y, innerXLimits.y, innerRectSize.y); // (currentInnerX + innerXSize) / (innerXLimits.x - innerRectSize.x) * 100
    fill(200);
    if (isHovering) {
      stroke(255);
    } else stroke(0);
    rect(innerRectLocation.x, innerRectLocation.y, innerRectSize.x, innerRectSize.y);
    fill(0);
    text(currentNumber, outerRectLocation.x + innerXLimits.x, outerRectLocation.y + innerRectSize.y*4);
    stroke(0);
  }

  void hoverCheck(float mX, float mY) {
    isHovering = (mX > innerRectLocation.x && mX < innerRectLocation.x + innerRectSize.x && mY > innerRectLocation.y && mY < innerRectLocation.y + innerRectSize.y) ? true : false ;
  }
}
