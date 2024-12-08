Ball ball; 
Platform platform;
Brick[][] bricks;
int lives = 3;
int points = 0;
boolean isPaused = false;
boolean isGameStarted = false;
boolean isGameOver = false;
boolean hasWon = false;

void setup() {
  size(600, 400);
  ball = new Ball(width / 2, height - 50, 15, color(255, 0, 0));  // Start with a red ball
  platform = new Platform(width / 2 - 50, height - 30, 100, 10, color(255));
  bricks = new Brick[5][7];  // 5 rows and 7 columns of bricks

  // Create random bricks with no gaps, ensuring they are adjacent to each other
  float currentX = 5;
  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[i].length; j++) {
      float brickWidth = random(60, 100);  // Random width
      bricks[i][j] = new Brick(currentX, i * 25 + 40, brickWidth, 20, color(random(255), random(255), random(255)));
      currentX += brickWidth + 5;  // Ensure bricks touch, with no gaps
    }
    currentX = 5; // Reset for the next row
  }
}

void draw() {
  background(0);

  if (!isGameStarted) {
    displayStartMessage();
    return;
  }

  if (isGameOver) {
    displayGameOver();
    return;
  }

  if (hasWon) {
    displayYouWon();
    return;
  }

  if (!isPaused) {
    ball.move();
    ball.checkCollision(platform, bricks);

    // Check if all bricks are destroyed (winning condition)
    if (checkIfGameWon()) {
      hasWon = true;  // Set the game to the win state
    }

    // Ball falling off the screen
    if (ball.y > (height - 15)) {
      lives--; // Reduce life when the ball falls
      if (lives > 0) {
        ball.reset(); // Reset ball if lives are left
      } else {
        isGameOver = true; // Game over if no lives are left
      }
    }
  }

  ball.display();
  platform.display();

  // Display the bricks
  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[i].length; j++) {
      if (bricks[i][j] != null) {
        bricks[i][j].display();
      }
    }
  }

  displayHUD();
}

void displayStartMessage() {
  textSize(32);
  fill(255);
  textAlign(CENTER, CENTER);
  text("click to start\nP: Increase Platform Size\nB: Change Ball Color\nT: Change Brick Color", width / 2, height / 2);
}

void displayHUD() {
  textSize(16);
  fill(255);
  text("Lives: " + lives, 25, 20);
  text("Points: " + points, width - 100, 20);
}

void displayGameOver() {
  textSize(32);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width / 2, height / 2 - 20);
  textSize(24);
  text("Points: " + points, width / 2, height / 2 + 20);
  textSize(16);
  text("Press 'r' to Restart", width / 2, height / 2 + 60);
}

void displayYouWon() {
  textSize(32);
  fill(0, 255, 0);
  textAlign(CENTER, CENTER);
  text("YOU WON!", width / 2, height / 2 - 20);
  textSize(24);
  text("Points: " + points, width / 2, height / 2 + 20);
  textSize(16);
  text("Press 'r' to Restart", width / 2, height / 2 + 60);
}

void keyPressed() {
  if (key == ' ' && !isGameOver && !hasWon) {
    isGameStarted = true; // Start the game when space is pressed
  } else if (key == 'r' && (isGameOver || hasWon)) {
    resetGame(); // Restart the game when 'r' is pressed
  } else if (key == 'p') {
    if (platform.width < 200) {
    platform.width += 10;
    }// Increase platform size
  } else if (key == 'b') {
    ball.bcolor = color(random(255), random(255), random(255)); // Change ball color to a random color
  } else if (key == 't') {
    // Change brick color to a random color for each brick
    for (int i = 0; i < bricks.length; i++) {
      for (int j = 0; j < bricks[i].length; j++) {
        if (bricks[i][j] != null) {
          bricks[i][j].bcolor = color(random(255), random(255), random(255));  // Assign new random color
        }
      }
    }
  }

  // Platform movement (left and right arrow keys)
  if (keyCode == LEFT) {
    platform.move(true); // Move platform left
  } else if (keyCode == RIGHT) {
    platform.move(false); // Move platform right
  }
}

void mousePressed() {
  if (!isGameStarted) {
    isGameStarted = true; // Start the game when mouse is pressed
  }
}

void resetGame() {
  lives = 3;
  points = 0;
  isGameOver = false;
  hasWon = false;
  ball.reset(); // Reset ball position
  platform = new Platform(width / 2 - 50, height - 30, 100, 10, color(255)); // Reset platform
  
  // Reset bricks
  float currentX = 5;
  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[i].length; j++) {
      float brickWidth = random(60, 100);  // Random width
      bricks[i][j] = new Brick(currentX, i * 25 + 40, brickWidth, 20, color(random(255), random(255), random(255)));
      currentX += brickWidth + 5;  // Ensure bricks touch, with no gaps
    }
    currentX = 5; // Reset for the next row
  }
}

// Check if the game is won (all bricks are broken)
boolean checkIfGameWon() {
  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[i].length; j++) {
      if (bricks[i][j] != null) {
        return false; // If any brick is still present, the game isn't won yet
      }
    }
  }
  return true; // If no bricks are left, the player has won
}      
