package;

class Interpolate {
  public static function lerp(a: Float, b: Float, dt: Float, scale: Float): Float {
    return a + (b - a) * (1 - Math.pow(2, - scale * dt));
  }
}

