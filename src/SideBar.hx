package;

import js.Browser.document;
import js.html.ButtonElement;
import js.html.DivElement;
import js.html.Element;

class SideBar {
  var container: DivElement;
  var center: Element;
  var buttons: Array<ButtonElement>;

  public inline function new(parent: Element) {
    buttons = new Array<ButtonElement>();

    container = document.createDivElement();
    center = document.createElement("center");

    container.id = "sidebarcontainer";

    container.appendChild(center);

    buttons.push(createButton("Paint"));
    buttons.push(createButton("Fill"));
    buttons.push(createButton("Select"));

    chooseTool(buttons[0]);

    for (b in buttons) {
      center.appendChild(b);
    }

    parent.appendChild(container);
  }

  public inline function createButton(label: String): ButtonElement {
    final button = document.createButtonElement();
    button.innerText = label;
    button.onclick = function() { chooseTool(button); };
    return button;
  }

  function chooseTool(button: ButtonElement) {
    for (b in buttons) {
      b.className = "";
    }
    button.className = "active-button";
  }
}

