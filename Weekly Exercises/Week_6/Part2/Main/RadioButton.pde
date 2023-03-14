class RadioButton extends Widget {
  PImage buttonOn = loadImage("radioButton2.gif");
  PImage buttonOff = loadImage("radioButton1.gif");
  boolean isChecked;
  int radius;
  RadioButton(int x, int y, int radius, String label, color widgetColor, PFont widgetFont, int event, boolean isChecked) {
    super(x, y, label, widgetFont, event);
    this.isChecked = isChecked;
    this.radius = radius;
    tint(widgetColor, 255);
    buttonOn.resize(radius*2, radius*2);
    buttonOff.resize(radius*2, radius*2);
  }

  @Override
    void draw() {
    if (isHovering) stroke(255);
    else stroke(0);
    //ellipse(x, y, radius*2, radius*2);
    if (isChecked) image(buttonOn, x, y);
    else image(buttonOff, x, y);
    text(label, x + radius*2 + 10, y + radius + 12);
    stroke(0);
  }
  
  @Override
    int getEvent(int mX, int mY) {
    if (mX>x && mX < x+radius*2 && mY >y && mY <y+radius*2) {
      isChecked = !isChecked;
      return event;
    }
    return EVENT_NULL;
  }
}
