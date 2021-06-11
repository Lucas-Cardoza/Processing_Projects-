int x = 100, y = 50;         // Starting position of ball
int r = 50;                  // Radius of ball
int xSpeed = 2, ySpeed = 2;  // Speed of ball in x dimension


// Function to setup screen
void setup()  
{
  size(600, 400);       // Size of screen
  fill(255, 255, 0);    // Background color
  noStroke();           // No outside line
  print(width, height); // Print to console the screen size
}


// Function to draw to screen. Loops at 60Hz
void draw()         
{
  background(0);    // Redraw the background
  circle(x, y, r);  // Draw the ball
  x += xSpeed;
  y += ySpeed;
  
  // Check if ball is to bounce off wall in the x dimension
  // using 25 to account for ball radius
  if (x > (width - 25))  
  {
    xSpeed = -xSpeed;
  }
  else if (x < 25)
  {
    xSpeed = -xSpeed;
  }
  
  // Check if ball is to bounce off wall in the y dimension
  // using 25 to account for ball radius
  if (y > (height - 25))  
  {
    ySpeed = -ySpeed;
  }
  else if (y < 25)
  {
    ySpeed = -ySpeed;
  }
}
