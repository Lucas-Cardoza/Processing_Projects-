/*
 Student: Lucas Cardoza
 Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
 Exercise No. 6: Use pixel arrays to calculate Euclidean distances from 
                 an average pixel to all others.
 Instructor: Lloyd Smith
 Due Date: Sunday, March 14, 2021 11:59 PM
*/


PImage[] img = new PImage[5];
PImage currentImg;
String fname1 = "penny.jpg", fname2 = "Lizard.jpg";
String fname3 = "sunflower.jpg", fname4 = "parrot400.jpg";
String loadName = fname4;
int startX, startY, endX, endY; //Used for selection
color avgPixel;   //Avg pixel over whole image


void setup() 
{
  size(500, 500);
  surface.setResizable(true);
  noTint();
  img[0] = loadImage(loadName);
  surface.setSize(img[0].width, img[0].height);
  avgPixel = averagePixels(img[0]);
  img[1] = avgDist(img[0], avgPixel);
  currentImg = img[0];
  noFill();
  rectMode(CORNERS);  //Better for showing selection rectangle
}


void draw() 
{
  background(200);
  image(currentImg, 0, 0);
  if (mousePressed) 
  {
    rect(startX, startY, mouseX, mouseY);
  }
}


color averagePixels(PImage img) 
{
  float r = 0, g = 0, b = 0;
  img.loadPixels();  //Get access to pixel array
  
  //Your code here to calculate average r, g, and b values
  for (int i = 0; i < img.pixels.length; i++)
  {
    r += red(img.pixels[i]);
    g += green(img.pixels[i]);
    b += blue(img.pixels[i]);
  }
  
  r /= img.pixels.length;
  g /= img.pixels.length;
  b /= img.pixels.length;
  
  return color(r, g, b);
}


float cdist(color c1, color c2) 
{
  //Your code here to calculate Euclidean distance between c1 and c2
  //Return distance
  return sqrt(sq(red(c2) - red(c1)) + sq(green(c2) - green(c1)) + sq(blue(c2) - blue(c1))); 
}


PImage avgDist(PImage source, color avgPix) 
{
  PImage target = createImage(source.width, source.height, ARGB);
  /*Your code here to fill target with grayscale values that represent the
    distance between the corresponding pixel in source and avgPix. Don't
    forget to load pixels for target; also load them for source unless your
    design ensures that they are already loaded elsewhere. Update target's
    pixels before returning it.
    One important point: you will have to scale the distance into the range
    0 to 255. Use map; consider that the maximum possible distance is the
    distance between white and black.
  */
  
  float maxDist = cdist(color(0), color(255));
  target.loadPixels();
  source.loadPixels();
  
  for (int i = 0; i < target.pixels.length; i++)
  {
    float dist = map(cdist(source.pixels[i], avgPix), 0, maxDist, 0, 255);
    target.pixels[i] = color(dist);
  }
  
  target.updatePixels();
  return target;
}


void mousePressed() 
{
  startX = mouseX;
  startY = mouseY;
  currentImg = img[0];
}


//Calculate the average color in a selected region, then base entire image
//on distance from that color. This function includes the solution.
void mouseReleased() 
{
  float r = 0, g = 0, b = 0;
  int total = 0;
  endX = mouseX;
  endY = mouseY;
  //Handle case where user moved the mouse up and/or to the left
  if (endX < startX) 
  {
    int temp = startX;
    startX = endX;
    endX = temp;
  }
  if (endY < startY) 
  {
    int temp = startY;
    startY = endY;
    endY = temp;
  }
  
  /*Average pixels over selection. This area is not likely to be contiguous in
    the pixel array so you have to use a nested loop. You can still use the
    pixel array, though - the pixel's position in the array is y * width + x.
  */
  for (int y = startY; y < endY; y++) 
  {
    for (int x = startX; x < endX; x++) 
    {
      //color p = img[0].get(x, y);              //Get the pixel using get
      color p = img[0].pixels[y*img[0].width+x]; //Get the pixel from the pixel array
      r += red(p);
      g += green(p);
      b += blue(p);
      total += 1;
    }
  }
  
  r /= total;
  g /= total;
  b /= total;
  img[2] = avgDist(img[0], color(r, g, b));
}


void keyPressed() 
{
  background(128);  //Clear screen to medium gray
  //If 0 key is pressed, set currentImg to img[0] (Original)
  //If 1 key is pressed, set currentImg to img[1] (dist from avg pixel)
  //If 2 key is pressed, set currentImg to img[2] (dist from avg pixel in selection)
  if (key == '0')
  {
    currentImg = img[0];
  }
  else if (key == '1')
  {
    currentImg = img[1];
  }
  else if (key == '2')
  {
    currentImg = img[2];
  }
}
