/* 
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 10a: Chromakey
   Instructor: Lloyd Smith
   Due Date: Sunday, April 18, 2021

   This program implements chromakey, given foreground and
   background images. The foreground image must have foreground
   people or objects in front of a blue or green background.
   The default images are the same size; modify the program
   so it can accept a background image that is larger than the
   foreground. The program will then use part of the background
   image.
*/


PImage bckgrnd, forgrnd, finalImage;
int show = 0;


void setup() 
{
  float r, g, b;
  size(500, 500);
  surface.setResizable(true);
  forgrnd = loadImage("blue-mark.jpg");
  surface.setSize(forgrnd.width, forgrnd.height);
  bckgrnd = loadImage("moon-surface.jpg");
  finalImage = chromakey(forgrnd, bckgrnd);
}


void draw() 
{
  if (show == 0) 
  {
    image(forgrnd, 0, 0);
  } 
  else if (show == 1) 
  {
    image(bckgrnd, 0, 0);
  }
  else if (show == 2) 
  {
    image(finalImage, 0, 0);
  }
}


PImage chromakey(PImage fg, PImage bg) 
{
  PImage target = createImage(fg.width, fg.height, RGB);
  //Put background replacement code here
  color c;
  float r, g, b;
  
  for (int y = 0; y < fg.height; y++)
  {
    for (int x = 0; x < fg.width; x++)
    {
      c = fg.get(x, y);
      r = red(c);
      g = green(c);
      b = blue(c);
      
      if ((r + g) < b)
      {
        c = bg.get(x, y);
      }
      
      target.set(x, y, c);
    }
  }
  
  return target;
}


void keyPressed() 
{
  if (key == '0') 
  {
    show = 0;
  } 
  else if (key == '1') 
  {
    show = 1;
  } 
  else if (key == '2') 
  {
    show = 2;
  }
}
