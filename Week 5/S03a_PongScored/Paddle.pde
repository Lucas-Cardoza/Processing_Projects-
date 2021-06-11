// Paddle class for Pong game
class Paddle
{
  int xPos, yPos;
  int wdth = 20, hght = 75;
  int speed = 10;
  color paddleColor;
  
  
  // Function to set paddle color
  Paddle(color pColor)
  {
    paddleColor = pColor;
    xPos = width - wdth/2;
    yPos = height/2;
  }
  
  
  // Function to move paddle up the screen
  void moveUp()
  {
    if (yPos > (hght/2))
    {
      yPos -= speed;
    }
  }
  
  
  // Fuction to move paddle down the screen
  void moveDown()
  {
    if (yPos < (height - hght/2))
    {
      yPos += speed;
    }
  }
  
  
  // Function to display the paddle to screen
  void display()
  {
    rectMode(CENTER);  // Using the center of the rectangel as the refereance of the shape
    fill(paddleColor);
    rect(xPos, yPos, wdth, hght);
  }
  
  
  // Function to get the value of the Y position of paddle
  int getY()
  {
    return yPos;
  }
  
  
  // Fuction to get the X position of the paddle
  int getWidth()
  {
    return wdth;
  }
  
  
  // Function to get the value of the height of the paddle
  int getHeight()
  {
    return hght;
  }
}
