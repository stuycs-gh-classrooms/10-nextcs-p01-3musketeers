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
    if (left && x > 0) {
      x -= speed;
    } else {
      x += speed;
    }
  }
  void display() {
    fill(pcolor);
    rect(x, y, width, height);
  }
}


