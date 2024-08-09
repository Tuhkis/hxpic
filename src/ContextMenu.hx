package;

import js.Browser.document;
import js.html.ButtonElement;
import js.html.DivElement;
import js.html.Element;

class ContextMenu {
  var container: DivElement;
  var visible: Bool = false;

  public inline function new(parent: Element) {
    container = document.createDivElement();

    setPos("0px", "0px");

    parent.addEventListener("contextmenu", function(event) {
      event.preventDefault();
      toggle();
      setPos(event.clientX.toString() + "px", event.clientY.toString() + "px");
      onClick(event);
    });
    parent.appendChild(container);
  }

  public function toggle() {
    visible = !visible;
    if (visible) {
      container.className = "context-menu";
    } else {
      container.className = "hide";
    }
  }

  public inline function setPos(x: String, y: String) {
    container.style.top = y;
    container.style.left = x;
  }

  public inline function setSize(width: String, height: String) {
    container.style.width = width;
    container.style.height = height;
  }

  private function onClick(event) {
  }
}

