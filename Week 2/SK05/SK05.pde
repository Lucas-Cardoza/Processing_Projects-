// Stroke weight variable
int sw = 1;


// Function to setup screen
void setup()
{
  size(600, 400);
  background(0);
  stroke(255, 255, 0);
  strokeWeight(sw);
}


// Function to draw objects. Loops at 60Hz
void draw()
{
  if (mousePressed)
  {
    line(mouseX, mouseY, pmouseX, pmouseY); 
  }
}


// Function to change drawing characteristics
void keyReleased()
{
  // Ckeck to clear screen
  if (key == 'c')
  {
    background(0);
  }
  
  // Checks to change stroke color
  if (key == 'y')
  {
    stroke(255, 255, 0);  // Yellow
  }
  
  if (key == 'r')
  {
    stroke(255, 0, 0);  // Red
  }
  
    if (key == 'g')
  {
    stroke(0, 255, 0);  // Green
  }
  
  if (key == 'b')
  {
    stroke(0, 0, 255);  // Blue
  }
  
    if (key == 'm')
  {
    stroke(255, 0, 255);  // Magenta
  } // end color checks
  
  // Check to change stroke weight
  if (key == CODED)
  {
    if (keyCode == UP && sw < 11)
    {
      sw++;
      strokeWeight(sw);
    }
    else if (keyCode == DOWN && sw > 0)
    {
      sw--;
      strokeWeight(sw);
    }
  } // end stroke weight checks 
}
