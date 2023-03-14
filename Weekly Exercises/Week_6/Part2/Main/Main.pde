import java.util.*;
PFont stdFont;
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3=3;
final int EVENT_BUTTON4=4;
final int EVENT_BUTTON5=5;
final int EVENT_BUTTON6 = 6;
final int EVENT_BUTTON7 = 7;
final int EVENT_NULL=0;
Widget screen1Widget1, screen1Widget2, screen2Widget1, screen2Widget2;
ArrayList<Widget> screen1Widgets, screen2Widgets;
color squareColor;
CheckBox checkBox;
RadioButton radioButton;
Slider slider;
Screen screen1, screen2, currentScreen;

void setup() {
  stdFont=loadFont("Arial-Black-30.vlw");
  textFont(stdFont);
  screen1Widget1=new Widget(width/2 - 90, height/2 - 200, 180, 40, "Forward", color(#FF0000), stdFont, EVENT_BUTTON1);
  screen1Widget2=new Widget(width/2 - 90, height/2 + 200, 180, 40, "Button 1", color(#00FF00), stdFont, EVENT_BUTTON2);
  screen2Widget1=new Widget(width/2 - 90, height/2 - 200, 180, 40, "Backward", color(#0000FF), stdFont, EVENT_BUTTON3);
  screen2Widget2=new Widget(width/2 - 90, height/2 + 200, 180, 40, "Button 2", color(#FFFF00), stdFont, EVENT_BUTTON4);
  checkBox = new CheckBox (width/2-100, height/2 - 75, 75, 75, "Check Box", color(255), stdFont, EVENT_BUTTON5, false);
  radioButton = new RadioButton (width/2-100, height/2 - 75, 25, "Radio Button", color(255), stdFont, EVENT_BUTTON6, false);
  slider = new Slider(0, 0, 50, 20, 50, 150, stdFont, EVENT_BUTTON7, "");
  size(800, 600);
  squareColor = (255);
  screen1Widgets = new ArrayList<Widget>();
  screen2Widgets = new ArrayList<Widget>();
  screen1Widgets.addAll(Arrays.asList(screen1Widget1, screen1Widget2, radioButton));
  screen2Widgets.addAll(Arrays.asList(screen2Widget1, screen2Widget2, checkBox));
  screen1 = new Screen(screen1Widgets, color(205));
  screen2 = new Screen(screen2Widgets, color(115));
  currentScreen = screen1;
}

void draw() {
  stroke(0);
  if (currentScreen == screen1) {
    screen1.draw();
    slider.draw();
    //if (slider.currentNumber == 7)
    //  slider.currentNumber = 0;
  }
  else if (currentScreen == screen2)
    screen2.draw();
}

void mouseMoved() {
  if (currentScreen == screen1) {
    for (Widget i : screen1.widgets) {
      i.hoverCheck();
    }
    slider.hoverCheck(mouseX, mouseY);
  } else if (currentScreen == screen2)
    for (Widget i : screen2.widgets) {
      i.hoverCheck();
    }
}
void mouseDragged() {
  if (currentScreen == screen1) {
    if (slider.isHovering)
      slider.updateInnerLocationX(mouseX);
  }
}
void mousePressed() {
  int event;
  if (currentScreen == screen1) {
    for (Widget i : screen1.widgets) {
      event = i.getEvent(mouseX, mouseY);
      switch(event) {
        case EVENT_BUTTON1:
          currentScreen = screen2;
          break;
        case EVENT_BUTTON2:
          println("Button 1!");
          break;
        case EVENT_BUTTON6:
          println("Radio Button Updated");
          break;
      }
    }
  }
  else if (currentScreen == screen2) {
    for (Widget i : screen2.widgets) {
      event = i.getEvent(mouseX, mouseY);
      switch(event) {
        case EVENT_BUTTON3:
          currentScreen = screen1;
          break;
        case EVENT_BUTTON4:
          println("Button 2!");
          break;
        case EVENT_BUTTON5:
          println("Checkbox Updated");
          break;
      }
    }
  }
}
