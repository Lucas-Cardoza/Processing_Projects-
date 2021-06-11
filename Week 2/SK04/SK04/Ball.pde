// Ball Class
class Ball
{
  // Ball characteristics
  int xPos, yPos, radius;
  int xSpeed, ySpeed;
  color ballColor;

  // Function to generate a ball with random characteristics
  Ball()
  {
    radius = int(random(10, 51));   // Radius will be random between 10 and 50.
    xPos = int(random(radius, width - radius));
    yPos = int(random(radius, height - radius));
    xSpeed = int(random(1, 6));
    ySpeed = int(random(1, 6));
    int r = int(random(0, 256));
    int g = int(random(0, 256));
    int b = int(random(0, 256));
    ballColor = color(r, g, b);
  }
  
  // Function to move ball
  void move()
  {
    xPos += xSpeed;
    yPos += ySpeed;
    
    // Check to see if ball needs to change directions
    if (xPos > (width - radius/2) || xPos < radius/2)
    {
      xSpeed = -xSpeed;
    }
    else if (yPos > (height - radius/2) || yPos < radius/2)
    {
      ySpeed = -ySpeed;
    }
  }
  
  // Function to display ball
  void display()
  {
    fill(ballColor);
    circle(xPos, yPos, radius);
  }
}
