class Box 
{
  int MINSIZE = 10, MAXSIZE = 80;
  int xpos, ypos, boxsize; //Box parameters
  color fillColor;
  
  
  Box() 
  {
    colorMode(HSB, 360, 100, 100);
    fillColor = color(int(random(0, 360)), 100, 100);
    boxsize = int(random(MINSIZE, MAXSIZE+1));
    randpos(); //Set a random position
  }
  
  
  void randpos() 
  {
    xpos = int(random(0, width-boxsize));
    ypos = int(random(0, height-boxsize));
  }
  
  
  void move(int x, int y) 
  {
    xpos = x;
    ypos = y;
  }
  
  
  boolean mouseIn() 
  {
    int w = boxsize/2;
    //Your code here to determine whether mouse is inside box
    if (mouseX > xpos - w && mouseX < xpos + w
    && mouseY > ypos - w && mouseY < ypos + w)
    {
      return true;
    }
    else
    {
      return false;  //Always returns false - you should change this
    }
  }
  
  
  float mousedist() 
  {
    return dist(xpos, ypos, mouseX, mouseY);
  }
  
  
  void display() 
  {
    fill(fillColor);
    stroke(0);
    rectMode(CENTER);
    rect(xpos, ypos, boxsize, boxsize);
  }
}
    
