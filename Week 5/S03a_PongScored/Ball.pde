// Ball Object class for Pong game
class Ball
{
  int xPos, yPos, radius = 25;
  int xSpeed = 3, ySpeed = 3;
  int edge = radius/2;
  color ballColor;


  // Fouction to set ball color
  Ball(color bColor)
  {
    ballColor = bColor;
    resetPos();
  }
  
  
  void resetPos()
  {
    xPos = int(random(radius, width/2));
    yPos = int(random(radius, height - radius));
  }

  // Function to display ball to screen
  void display()
  {
    fill(ballColor);
    circle(xPos, yPos, radius);
  }


  // Function to move ball on screen
  boolean move(Paddle pad)
  {
    xPos += xSpeed;
    yPos += ySpeed;
    boolean addPoint = false;
    
    // Check to see if ball needs to change in the Y dimension
    if (yPos > height - edge || yPos < edge)
    {
      ySpeed = -ySpeed;
    }
    
    // Check to see if the ball need to change in the X dimension
    // Only change in the X dimension if there is a collsision with
    // paddle or a collision with wall opposite paddle.
    if (xPos < radius)
    {
      xSpeed = -xSpeed;
    }
    
    // Check to see if collision between ball and paddle has occoured 
    if (collision(pad))
    {
      if (xSpeed > 0)
      {
        xSpeed = -xSpeed;
      }
      else if (xPos > width)
      {
        addPoint = true;
        resetPos();
      }
    }
    
    return addPoint;
  }
  
  
  // Function to check for collision between ball and paddle
  boolean collision(Paddle pad)
  {
    int padX = width - pad.getWidth();
    int padTop = pad.getY() - pad.getHeight()/2;
    int padBottom = pad.getY() + pad.getHeight()/2;
    
    if (xPos + edge >= padX && yPos - edge >= padTop && yPos + edge <= padBottom)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}
