class Platform {
  float x, y, width, height, speed;
  color pcolor;

  Platform(float x, float y, float width, float height, color pcolor) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.pcolor = pcolor;
    this.speed = 10;
  }

  void move(boolean left) {
    if (left && x > 1) {
      x -= speed;
    } else {
      if (!left && x < 500) {
      x += speed;
      }
    }
  }
  void display() {
    fill(pcolor);
    rect(x, y, width, height);
  }
}
