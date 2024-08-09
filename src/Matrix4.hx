package;

import js.lib.Float32Array;

abstract Matrix4(Float32Array) {
  public inline function new() {
    this = new Float32Array(4 * 4);
  }

  public inline function ortho(left: Float, right: Float, top: Float, bottom: Float, near: Float, far: Float) {
    this.fill(0);

    this[0] = 2 / (right - left);
    this[5] = 2 / (top - bottom);
    this[10] = 2 / (far - near);
    this[12] = -(right + left) / (right - left);
    this[13] = -(top + bottom) / (top - bottom);
    this[14] = -(far + near) / (far - near);
    this[15] = 1;
  }
}

