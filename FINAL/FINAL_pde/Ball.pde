class Ball {
  float x, y, speedX, speedY, size;
  color bcolor;
  float speedIncrement = 0.005;  // Increment speed over time

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
    speedX += (speedX > 0 ? speedIncrement : -speedIncrement);
    speedY += speedIncrement;

    // Update position
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
      speedY *= -1;  // Bounce off platform
      return;        // Exit early
    }

    // Step-based collision detection for bricks
    float steps = max(abs(speedX), abs(speedY)); // Determine the number of steps
    float stepX = speedX / steps;  // Divide movement into steps
    float stepY = speedY / steps;

    for (int step = 0; step < steps; step++) {
      float testX = x + stepX * step;  // Predicted position at this step
      float testY = y + stepY * step;

      for (int i = 0; i < bricks.length; i++) {
        for (int j = 0; j < bricks[i].length; j++) {
          Brick brick = bricks[i][j];

          if (brick != null && brick.isColliding(testX, testY, size)) {
            // Ball is colliding with the brick
            speedY *= -1;  // Reverse Y speed
            bricks[i][j] = null;  // Remove the brick
            points += 10;  // Add points for destroying the brick
            return;  // Prevent further collisions in this frame
          }
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
