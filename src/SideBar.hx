package;

import js.Browser.document;
import js.html.DivElement;
import js.html.Element;

class SideBar {
  var container: DivElement;
  var center: Element;

  public inline function new() {
    container = document.createDivElement();
    center = document.createElement("center");

    container.id = "sidebarcontainer";

    container.appendChild(center);

    addButton();
    addButton();
    addButton();

    document.body.appendChild(container);
  }

  public inline function addButton() {
    final button = document.createButtonElement();
    button.innerText = "Hello";
    center.appendChild(button);
  }
}

