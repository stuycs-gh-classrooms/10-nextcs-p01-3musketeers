class Ball {
  float x, y, speedX, speedY, size;
  color bcolor;
  float speedIncrement = 0.01;  // Increment speed over time

  Ball(float x, float y, float size, color bcolor) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.speedX = random(-3, 3);
    this.speedY = -3;
    this.bcolor = bcolor;
  }

  void move() {
    // Gradually increase the speed
    speedX += (speedX > 0 ? speedIncrement : -speedIncrement);  // Gradually change direction and speed
    speedY += speedIncrement;

    x += speedX;
    y += speedY;

    // Ball collision with walls
    if (x <= 0 || x >= width) {
      speedX *= -1;
    }
    if (y <= 0) {
      speedY *= -1;
    }
  }

  void display() {
    fill(bcolor);
    ellipse(x, y, size, size);
  }

  void checkCollision(Platform p, Brick[][] bricks) {
    // Check collision with platform
    if (y + size / 2 >= p.y && x > p.x && x < p.x + p.width) {
      speedY *= -1;
    }

    // Check collision with bricks
    for (int i = 0; i < bricks.length; i++) {
      for (int j = 0; j < bricks[i].length; j++) {
        if (bricks[i][j] != null && bricks[i][j].isColliding(x, y, size)) {
          bricks[i][j] = null;  // Break the brick
          speedY *= -1;  // Bounce off
          points += 10;  // Add points
          break;  // Prevent multiple collisions in the same frame
        }
      }
    }
  }

  void reset() {
    x = width / 2;
    y = height - 50;
    speedX = random(-3, 3);
    speedY = -3;
  }
}
