// Bouncing ball using ball object
int nBalls = int(random(1, 11)); // Generate 1 to 10 ball objects
Ball b[] = new Ball[nBalls];
boolean frozen = false;


// Function to setup screen
void setup()
{
  size(1000, 800);  // Size of screen
  colorMode(HSB, 360, 100, 100);  // Using HSB color modle 
  print(nBalls);    // Print to console the number of balls
  background(0);    // Set background to black
 
   for (int i = 0; i < b.length; i++)
   {
     b[i] = new Ball();
   }
}


// Function to draw objects. Loops at 60Hz
void draw()
{ 
  // Loop to draw the random number of balls
  for (int i = 0; i < b.length; i++)
  {
    b[i].move();
    b[i].display();
  }
}

// Function to clear screen upon key release of the 'c' key 
void keyReleased()
{
  if (key == 'c')
  {
    background(0);
  }
  
  // Check to freeze screen
  if (key == 'f')
  {
    if (frozen)
    {
      frozen = false;
      loop();
    }
    else
    {
      frozen = true;
      noLoop();
    }
  } //end if
}
