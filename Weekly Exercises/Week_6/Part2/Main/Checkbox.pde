class CheckBox extends Widget {
  PImage checkBoxOn = loadImage("checkBox2.gif");
  PImage checkBoxOff = loadImage("checkBox1.gif");
  boolean isChecked;
  CheckBox(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, boolean isChecked) {
    super(x, y, width, height, label, widgetColor, widgetFont, event);
    this.isChecked = isChecked;
    tint(widgetColor, 255);
    checkBoxOn.resize(width, height);
    checkBoxOff.resize(width, height);
  }

  @Override
    void draw() {
    if (isHovering)
      stroke(255);
    else
      stroke(0);
    rect(x-1, y-1, width+1, height+1);
    if (isChecked)
      image(checkBoxOn, x, y);
    else
      image(checkBoxOff, x, y);
    text(label, x + width + 10, y + height/2 + 10);
    stroke(0);
  }

  @Override
    int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      isChecked = !isChecked;
      return event;
    }
    return EVENT_NULL;
  }
}
