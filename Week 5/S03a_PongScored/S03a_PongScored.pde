Ball ball;
Paddle paddle;
int textX = 75, textY = 75;
int score = 0;
PFont font;  // Font for score


// Function to setup screen
void setup()
{
  size(800, 600);
  ball = new Ball(color(0, 0, 255));
  paddle = new Paddle(color(0, 255, 0));
  font = createFont("Times New Roman", 48, true);
  textFont(font);
}


// Function to draw to the screen. Loops at 60Hz
void draw()
{
  background(0);
  paddle.display();
  ball.display();
  ball.move(paddle);
  
  if (ball.move(paddle))
  {
    score += 1;
  }
  
  text(score, textX, textY);
  
  // Check for end of game
  if (score == 3)
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
