extension NumExtensions on num {
  /// return `true` if a number `this` is between two numbers `a` and `b `.
  bool isBetween(num a, num b) {
    return !((a >= this && b > this) || (a < this && b < this));
  }
}
