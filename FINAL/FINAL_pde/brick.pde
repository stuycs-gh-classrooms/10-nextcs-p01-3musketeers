class Brick {
  float x, y, width, height;
  boolean isBroken;
  color bcolor;

  Brick(float x, float y, float width, float height, color bcolor) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.isBroken = false;
    this.bcolor = bcolor;
  }

  void display() {
    if (!isBroken) {
      fill(bcolor);
      rect(x, y, width, height);
    }
  }

  boolean isColliding(float ballX, float ballY, float ballSize) {
    return !isBroken && ballX > x && ballX < x + width && ballY > y && ballY < y + height;
  }
}
