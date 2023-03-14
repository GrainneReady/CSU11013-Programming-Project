import java.util.*;
PFont stdFont;
final int EVENT_BUTTON1=1, EVENT_BUTTON2=2, EVENT_BUTTON3=3, EVENT_NULL=0;
Widget widget1, widget2, widget3;
ArrayList<Widget> widgets;
color squareColor;


void setup() {
  size(800, 600);
  stdFont=loadFont("Arial-Black-30.vlw");
  textFont(stdFont);
  widget1=new Widget(100, 100, 180, 40, "Red", color(#FF0000), stdFont, EVENT_BUTTON1);
  widget2=new Widget(100, 200, 180, 40, "Green", color(#00FF00), stdFont, EVENT_BUTTON2);
  widget3=new Widget(100, 300, 180, 40, "Blue", color(#0000FF), stdFont, EVENT_BUTTON3);
  squareColor = (255);
  widgets = new ArrayList<Widget>();
  widgets.addAll(Arrays.asList(widget1, widget2, widget3));
}

void draw() {
  background(155);
  stroke(0);
  for (int i = 0; i<widgets.size(); i++) {
    Widget aWidget = (Widget)widgets.get(i);
    aWidget.draw();
  }
  fill(squareColor);
  rect(width/2 + 100, height/2, 150, 150);
}

void mouseMoved() {
  for (Widget i : widgets) {
    i.hoverCheck();
  }
}
void mousePressed() {
  int event;

  for (int i = 0; i<widgets.size(); i++) {
    Widget aWidget = (Widget) widgets.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    switch(event) {
    case EVENT_BUTTON1:
      println("Change to Red!");
      squareColor = widget1.widgetColor;
      break;
    case EVENT_BUTTON2:
      println("Change to Green!");
      squareColor = widget2.widgetColor;
      break;
    case EVENT_BUTTON3:
      println("Change to Blue!");
      squareColor = widget3.widgetColor;
    }
  }
}
