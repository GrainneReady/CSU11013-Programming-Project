class Screen {
  ArrayList<Widget> widgets;
  color backgroundColor;

  Screen(ArrayList<Widget> widgets, color backgroundColor) {
    this.widgets = widgets;
    this.backgroundColor = backgroundColor;
  }

  void draw() {
    background(backgroundColor);
    for (Widget i : widgets)
      i.draw();
  }

  void addWidget(Widget widgetToAdd) {
    widgets.add(widgetToAdd);
  }

  Widget getEvent() {
    int event = 0;
    for (Widget i : widgets) {
      event = i.getEvent(mouseX, mouseY);
      if (event != 0)
        return i;
    }
    return null;
  }
}
