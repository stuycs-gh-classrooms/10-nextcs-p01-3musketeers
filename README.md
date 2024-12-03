[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/2bl0h1Mb)
# NeXtCS Project 01
### Name0: Asna Rahman
### Name1: Michelle Chen
---

### Overview
Your mission is create either:
- Life-like cellular automata [life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), [life-like](https://en.wikipedia.org/wiki/Life-like_cellular_automaton), [demo](https://www.netlogoweb.org/launch#https://www.netlogoweb.org/assets/modelslib/Sample%20Models/Computer%20Science/Cellular%20Automata/Life.nlogo).
- Breakout/Arkanoid [demo 0](https://elgoog.im/breakout/)  [demo 1](https://www.crazygames.com/game/atari-breakout)
- Space Invaders/Galaga

This project will be completed in phases. The first phase will be to work on this document. Use markdown formatting. For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)


---

## Phase 0: Selection, Analysis & Plan

#### Selected Project: BREAKOUT

### Necessary Features
What are the core features that your program should have? These should be things that __must__ be implemented in order to make the program useable/playable, not extra features that could be added to make the program more interesting/fun.

:Array of bricks, once they collide wih ball they disappear, bouncing ball, and a platform where the bounce starts and bounces from, we also need a counter that monitors the amount of lives the player has, we also need a pause/play button, a function that changes the speed of the ball as game goes on, and a button to replay game. 

### Extra Features
What are some features that are not essential to the program, but you would like to see (provided you have time after completing the necessary features. Theses can be customizations that are not part of the core requirements.

Ability to change the color of the ball, size of the platform, and the color of the tiles. 

### Array Usage
How will you be using arrays in this project?

1D Array:
- Tracking lives: Store icons or life counters for display.
  
2D Array:
- Brick layout: Use a 2D array to store the positions, states (intact or broken), and types (normal or special) of the bricks.


### Controls
How will your program be controlled? List all keyboard commands and mouse interactions.

Keyboard Commands:
Left and right arrow keys to move the platform, the 'r' key that refreshes, space to pause and unpause the game.

Mouse Control:
- Mouse pressed: Click to start the game


### Classes
What classes will you be creating for this project? Include the instance variables and methods that you believe you will need. You will be required to create at least 2 different classes. If you are going to use classes similar to those we've made for previous assignments, you will have to add new features to them.

Ball
- Instance variables:// Breakout Game in Processing int lives = 3; // Starting lives Ball ball; Platform platform; Brick[][] bricks; boolean isPaused = false; boolean gameOver = false; void setup() { size(800, 600); ball = new Ball(width / 2, height - 50); // Position the ball platform = new Platform(width / 2, height - 20); // Position the platform bricks = new Brick[6][10]; // 6 rows and 10 columns of bricks // Initialize bricks for (int i = 0; i < bricks.length; i++) { for (int j = 0; j < bricks[i].length; j++) { bricks[i][j] = new Brick(70 * j + 50, 30 * i + 50); } } } void draw() { background(0); // Draw bricks for (int i = 0; i < bricks.length; i++) { for (int j = 0; j < bricks[i].length; j++) { bricks[i][j].display(); } } // Handle pause/play if (isPaused) { textSize(32); fill(255); text("PAUSED", width / 2 - 80, height / 2); return; // Skip the rest of the game loop if paused } if (gameOver) { textSize(32); fill(255); text("GAME OVER", width / 2 - 100, height / 2); textSize(16); text("Press 'R' to restart", width / 2 - 60, height / 2 + 40); return; } // Move and display ball ball.move(); ball.display(); // Move and display platform platform.display(); // Check collisions ball.checkCollision(platform, bricks); // Display lives fill(255); textSize(16); text("Lives: " + lives, 10, height - 10); // If no lives left, game over if (lives <= 0) { gameOver = true; } } void keyPressed() { if (key == ' ' || key == 'p') { // Pause/Unpause isPaused = !isPaused; } if (key == 'r' && gameOver) { // Restart game resetGame(); } } void keyReleased() { if (keyCode == LEFT) { platform.move(false); // Stop moving left } else if (keyCode == RIGHT) { platform.move(false); // Stop moving right } } // Reset the game to initial state void resetGame() { lives = 3; ball = new Ball(width / 2, height - 50); // Reset ball position platform = new Platform(width / 2, height - 20); // Reset platform position gameOver = false; isPaused = false; // Reset bricks for (int i = 0; i < bricks.length; i++) { for (int j = 0; j < bricks[i].length; j++) { bricks[i][j] = new Brick(70 * j + 50, 30 * i + 50); } } } // Ball class class Ball { float x, y; float speedX = 4; float speedY = -4; float size = 10; PVector velocity; Ball(float startX, float startY) { x = startX; y = startY; velocity = new PVector(speedX, speedY); } void move() { if (!isPaused) { x += velocity.x; y += velocity.y; // Bounce off the walls if (x - size / 2 < 0 || x + size / 2 > width) { velocity.x *= -1; } if (y - size / 2 < 0) { velocity.y *= -1; } // Ball falls below the platform if (y + size / 2 > height) { lives--; reset(); } } } void display() { fill(255, 0, 0); ellipse(x, y, size, size); } void checkCollision(Platform p, Brick[][] bricks) { // Ball-platform collision if (x > p.x - p.width / 2 && x < p.x + p.width / 2 && y + size / 2 >= p.y - p.height / 2) { velocity.y *= -1; } // Ball-brick collision for (int i = 0; i < bricks.length; i++) { for (int j = 0; j < bricks[i].length; j++) { if (!bricks[i][j].isBroken) { if (x > bricks[i][j].x && x < bricks[i][j].x + bricks[i][j].width && y - size / 2 < bricks[i][j].y + bricks[i][j].height && y + size / 2 > bricks[i][j].y) { velocity.y *= -1; bricks[i][j].isBroken = true; } } } } } void reset() { x = width / 2; y = height - 50; speedX = 4; speedY = -4; velocity.set(speedX, speedY); } } // Platform class class Platform { float x, y; float speed = 8; float width = 100; float height = 10; Platform(float startX, float startY) { x = startX; y = startY; } void move(boolean left) { if (!isPaused) { if (left) { x -= speed; } else { x += speed; } } } void display() { fill(0, 255, 0); rect(x - width / 2, y - height / 2, width, height); } } // Brick class class Brick { float x, y; float width = 60; float height = 20; boolean isBroken = false; Brick(float startX, float startY) { x = startX; y = startY; } void display() { if (!isBroken) { fill(255, 255, 0); rect(x, y, width, height); } } } 
  - x.speed, y.speed, bsize, Pvector center
- METHODS
  - move(): Updates the position of the ball based on velocity.
  - display(): Draws the ball on the canvas.
  - checkCollision(Platform, wall, Brick[][] bricks): Checks for collisions with walls, the platform, and bricks.
  - reset(): Resets the ball position and speed when the player loses a life.

Platform
- Instance variables:
  - x.speed, psize, pcolor, width, height
- METHODS
  - move(boolean left): Moves the platform left or right.
  - display(): Draws the platform on the canvas.

Brick
- Instance variables:
  - x, y, width, height, boolean isBroken, bcolor
- METHODS
  - display(): Draws the brick if it is not broken.
