package;

import js.Browser.document;
import js.html.Element;
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;

class ColorPicker {
  var g: CanvasRenderingContext2D;
  var canvas: CanvasElement;
  var choiceX: Int = 0;
  var choiceY: Int = 0;
  var mouseDown: Bool = false;

  public inline function new(parent: Element) {
    canvas = document.createCanvasElement();
    hide();

    canvas.width = 250;
    canvas.height = 250;

    g = canvas.getContext2d();

    render();

    canvas.addEventListener('mousedown', onMouseDown);
    canvas.addEventListener('mousemove', onMouseMove);
    canvas.addEventListener('mouseup', onMouseUp);

    parent.appendChild(canvas);
  }

  public inline function hide() {
    canvas.className = "hide";
  }

  public inline function show() {
    canvas.className = "color-picker";
  }

  function render() {
    g.fillStyle = "red";
    g.fillRect(0, 0, canvas.width, canvas.height);

    g.lineWidth = 0;
    g.fillStyle = "#f0f0e0";
    g.beginPath();
    g.arc(choiceX - 12, choiceY - 12, 3, 0, 2 * Math.PI, false);
    g.closePath();
    g.fill();
  }

  function onMouseDown(event) {
    mouseDown = event.buttons == 1;
    if (mouseDown) {
      choiceX = event.layerX;
      choiceY = event.layerY;
      render();
    }
  }

  function onMouseUp(event) {
    mouseDown = event.buttons == 1;
  }

  function onMouseMove(event) {
    if (mouseDown) {
      choiceX = event.layerX;
      choiceY = event.layerY;
      render();
    }
  }
}

