/*
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 12b: Component Labeling — The Recursive Grass Fire Algorithm
   Instructor: Lloyd Smith
   Due Date: Sunday, May 2, 2021, 11:59 PM
   
   
  Labels blobs; assumes black is foreground
  'b' displays binary image; 'L' displays labeled blobs
  NOTE: currently uses random colors for blobs; needs a
  better way to make sure colors are clearly different
*/


String[] fname = {"coins_binary.png", "coins_binary_filled.png"};
PImage[] img = new PImage[2];
int display;  //index of image to display


void setup() 
{
  size(500, 500);
  surface.setResizable(true);
  
  img[0] = loadImage(fname[0]);
  surface.setSize(img[0].width, img[0].height);
  img[1] = img[0].get();  //Copy of img[0]
  
  background(0);
  
  display = 0;  //display binary image
  grassFire(img[1]);
}


void draw() 
{
  image(img[display], 0, 0);
}


void grassFire(PImage pic) 
{
  //Your code here to implement the grassfire algorithm by...
  //...calling label() on each pixel, sending it a random color
  /*
    for each pixel x, y in img
        create a unique color c
        label(img, x, y, )
  */
  for (int y = 0; y < pic.height; y++)
  {
    for (int x = 0; x < pic.width; x++)
    {
      color c = color(random(10, 230), random(10, 230), random(10, 230)); 
      label(pic, x, y, c);
    }
  }
}


void label(PImage pic, int x, int y, color p) 
{
  //This is the recursive function that labels all connected pixels
  //Label by setting the pixel to p
  /*
    If pixel at img(x, y) is foreground and is unlabelled
        Set pixel’s color to c
        label(img, x-1, y, c)  //Check boundaries
        label(img, x+1, y, c)
        label(img, x, y-1, c)
        label(img, x, y+1, c)
  */
  color c = pic.get(x, y);
  int r  = int(red(c));
  int g  = int(green(c));
  int b  = int(blue(c));
  
  if ((r == 0) && (g == 0) && (b == 0))
  {
    pic.set(x, y, p);
    
    // Label the left neighbor
    if (x > 0)
    {
      label(pic, (x - 1), y, p);
    }
    
    // Label the right neighbor
    if (x < pic.width - 1)
    {
      label(pic, (x + 1), y, p);
    }
    
    // Label the upper neighbor
    if (y > 0)
    {
      label(pic, x, (y - 1), p);
    }
    
    // Label the lower neighbor
    if (y < pic.height - 1)
    {
      label(pic, x, (y + 1), p);
    }
  }
}


void keyReleased() 
{
  if (key == 'b' || key == 'B') 
  {
    display = 0; //Binary image
  }
  else if (key == 'l' || key == 'L') 
  {
    display = 1;  //Labeled image
  }
}
