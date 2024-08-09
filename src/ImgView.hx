package;

import js.Browser.document;
import js.html.CanvasElement;
import js.html.webgl.Buffer;
import js.html.webgl.Program;
import js.html.webgl.RenderingContext;
import js.html.webgl.UniformLocation;
import js.html.Window;
import js.lib.Float32Array;

class ImgView {
  var gl: RenderingContext;
  var canvas: CanvasElement;
  var proj: Matrix4;
  var uproj: UniformLocation;
  var buffer: Buffer;
  var shaders: Program;
  var image: Image;
  var isDragging: Bool = false;
  var scale: Float = 1;
  var visScale: Float = 1;
  var panX: Float = 0;
  var panY: Float = 0;
  var contextMenu: ColorPickerMenu;

  public inline function new() {
    this.proj = new Matrix4();

    this.canvas = document.createCanvasElement();
    canvas.className = "imgview";
    document.body.appendChild(this.canvas);

    contextMenu = new ColorPickerMenu(document.body);

    canvas.addEventListener('mousedown', onMouseDown);
    canvas.addEventListener('mousemove', onMouseMove);
    canvas.addEventListener('mouseup', onMouseUp);
    canvas.addEventListener('wheel', onWheel);

    this.gl = this.canvas.getContextWebGL();
    if (gl == null) {
      trace("failed to initialise webgl");
    }

    gl.disable(RenderingContext.DEPTH_TEST);

    final vertexShader = gl.createShader(RenderingContext.VERTEX_SHADER);
    final fragmentShader = gl.createShader(RenderingContext.FRAGMENT_SHADER);

    gl.shaderSource(vertexShader, "attribute vec4 avert;
uniform mat4 uproj;
varying highp vec2 vuv;
void main() {
  gl_Position = uproj * vec4(avert.xy, 0, 1);
  vuv = avert.zw;
}");

    gl.shaderSource(fragmentShader, "uniform sampler2D utex;
varying highp vec2 vuv;
void main() {
  gl_FragColor=texture2D(utex, vuv);
}
");

    gl.compileShader(vertexShader);
    gl.compileShader(fragmentShader);

    shaders = gl.createProgram();
    gl.attachShader(shaders, vertexShader);
    gl.attachShader(shaders, fragmentShader);

    gl.linkProgram(shaders);

    gl.deleteShader(vertexShader);
    gl.deleteShader(fragmentShader);

    final VERTS = new Float32Array([
      -250, -250, 0, 0,
      250, 250, 1, 1,
      250, -250, 1, 0,

      -250, -250, 0, 0,
      250, 250, 1, 1,
      -250, 250, 0, 1
    ]);

    buffer = gl.createBuffer();
    gl.bindBuffer(RenderingContext.ARRAY_BUFFER, buffer);
    gl.bufferData(RenderingContext.ARRAY_BUFFER, VERTS, RenderingContext.STATIC_DRAW);

    gl.vertexAttribPointer(0, 4, RenderingContext.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(0);

    uproj = gl.getUniformLocation(shaders, "uproj");

    image = new Image(gl, 15, 15);

    gl.clearColor(0.15, 0.15, 0.15, 1.0);
  }

  public inline function resize(width: Int, height: Int) {
    canvas.width = width;
    canvas.height = height;
    gl.viewport(0, 0, width, height);
  }

  public inline function center() {
    panX = 0.5 * canvas.width;
    panY = 0.5 * canvas.height;
  }

  public inline function pointInCanvas(): Bool {
    return false;
  }

  public inline function frame(dt: Float) {
    visScale = Interpolate.lerp(visScale, scale, dt, 3);
    proj.ortho(-panX * visScale, (canvas.width - panX) * visScale, -panY * visScale, (canvas.height - panY) * visScale, -0.1, 1);

    gl.clear(RenderingContext.COLOR_BUFFER_BIT);

    gl.useProgram(shaders);
    gl.bindBuffer(RenderingContext.ARRAY_BUFFER, buffer);
    gl.uniformMatrix4fv(uproj, false, cast proj);
    image.bind(gl);
    gl.drawArrays(RenderingContext.TRIANGLES, 0, 6);
  }

  function onMouseDown(event) {
    isDragging = event.buttons == 4;
  }

  function onMouseUp(event) {
    isDragging = event.buttons == 4;
  }

  function onMouseMove(event) {
    if (isDragging) {
      panX += event.movementX;
      panY += event.movementY;
    }
  }

  function onWheel(event) {
    // final zoom = event.deltaY * 0.001;
    final zoom = event.deltaY < 0 ? -0.15 : 0.15;

    scale += zoom;

    scale = scale > 0.05 ? scale : 0.05;
    scale = scale < 4.6 ? scale : 4.6;
  }
}

