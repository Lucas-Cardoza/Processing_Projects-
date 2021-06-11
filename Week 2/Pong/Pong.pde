Ball ball;
Paddle paddle;


// Function to setup screen
void setup()
{
  size(800, 600);
  ball = new Ball(color(0, 0, 255));
  paddle = new Paddle(color(0, 255, 0));
  background(0);
}


// Function to draw to the screen. Loops at 60Hz
void draw()
{
  background(0);
  paddle.display();
  ball.display();
  ball.move(paddle);
  
  // Check for end of game
  if (ball.xPos > 800 + ball.radius)
  {
    // Display end of game message
    PFont font = createFont("Arial", 46, true);
    textFont(font);
    fill(255, 0, 0);
    text("Game Over", 285, 300);
    noLoop();
  }
}


// Function to reconize keyboard use to move paddle
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      paddle.moveUp();
    }
    else if (keyCode == DOWN)
    {
      paddle.moveDown();
    }
  }
}
