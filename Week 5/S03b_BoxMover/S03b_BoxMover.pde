/* S03a_BoxMover: write code in the Box class to determine
   whether mouse is inside the box. The goal is to use the
   mouse to stack the boxes.
*/


int nboxes = 10;
Box[] b = new Box[nboxes];


void setup() 
{
  size(800, 600);
  for (int i = 0; i < b.length; i++) 
  {
    b[i] = new Box();
  }
}


void draw() 
{
  background(0);
  for (int i = 0; i < b.length; i++) 
  {
    if (mousePressed)
    {
      int minbox = findClosestBox();
      b[minbox].move(mouseX, mouseY);
    }
    
    b[i].display();
  }
}


int findClosestBox() 
{
  //Returns index of closest mouse position
  float mindist = 1000000;
  int minbox = -1;  //Index of closest box
  for (int i = 0; i < b.length; i++) 
  {
    if (b[i].mousedist() < mindist) 
    {
      mindist = b[i].mousedist();
      minbox = i;
    }
  }
  return minbox;
}


void keyReleased() 
{
  if (key == 'd') 
  {  //Disperse boxes
    for (int i = 0; i < b.length; i++) 
    {
      b[i].randpos();
    }
  }
}
