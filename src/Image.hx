package;

import js.html.webgl.RenderingContext;
import js.html.webgl.Texture;
import js.html.webgl.UniformLocation;
import js.lib.Uint8Array;

class Image {
  var width: Int;
  var height: Int;
  var tex: Texture;
  var bitmap: Uint8Array;

  public inline function new(gl: RenderingContext, w: Int, h: Int) {
    this.width = w;
    this.height = h;

    bitmap = new Uint8Array(w * h * 4);
    for (i in 0...w * h) {
      bitmap[i * 4] = i % 2 == 0 ? 230 : 180;
      bitmap[i * 4 + 1] = i % 2 == 0 ? 230 : 180;
      bitmap[i * 4 + 2] = i % 2 == 0 ? 230 : 180;
      bitmap[i * 4 + 3] = 255;
    }

    tex = gl.createTexture();
    gl.bindTexture(RenderingContext.TEXTURE_2D, tex);
    gl.texImage2D(
      RenderingContext.TEXTURE_2D,
      0,
      RenderingContext.RGBA,
      w,
      h,
      0,
      RenderingContext.RGBA,
      RenderingContext.UNSIGNED_BYTE,
      bitmap
    );

    gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_S, RenderingContext.CLAMP_TO_EDGE);
    gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_T, RenderingContext.CLAMP_TO_EDGE);
    gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MIN_FILTER, RenderingContext.NEAREST);
    gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MAG_FILTER, RenderingContext.NEAREST);
  }

  public inline function setUniform(gl: RenderingContext, location: UniformLocation) {
    gl.uniform1i(location, 0);
  }

  public inline function bind(gl: RenderingContext) {
    gl.bindTexture(RenderingContext.TEXTURE_2D, tex);
  }
}

