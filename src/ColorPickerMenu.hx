package;

import js.html.Element;

class ColorPickerMenu extends ContextMenu {
  var colorPicker: ColorPicker;

  public inline function new(parent: Element) {
    super(parent);

    colorPicker = new ColorPicker(container);
    colorPicker.hide();
    setSize("250px", "300px");
  }

  override private function onClick(event) {
    if (visible) {
      colorPicker.show();
    } else {
      colorPicker.hide();
    }
  }
}

