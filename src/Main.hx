package;

import js.Browser.document;
import js.html.Window;
import js.html.webgl.RenderingContext;

class Main {
  static var previousTime: Float = 0;
  static var deltaTime: Float = 0;

  static var imgView: ImgView;
  static var sideBar: SideBar;

  static function main() {
    document.addEventListener("DOMContentLoaded", function(event) {
      imgView = new ImgView();
      imgView.resize(document.defaultView.innerWidth, document.defaultView.innerHeight);
      imgView.center();

      sideBar = new SideBar(document.body);

      document.defaultView.requestAnimationFrame(frame);
    });
  }

  static function frame(time: Float) {
    deltaTime = (time - previousTime) * 0.01;
    previousTime = time;

    imgView.frame(deltaTime);

    document.defaultView.requestAnimationFrame(frame);
  }
}
