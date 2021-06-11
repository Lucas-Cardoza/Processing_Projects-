/* This program creates negative, grayscale & binary image
   'c' displays original color image; 'n' displays negative;
   'g' displays grayscale; 'b' displays binary.
   This is an example of point processing--the new value of
   each pixel depends only on the current value of that pixel
   
   Here's an additional challenge: can you make the program
   display img to the left of the mouse and currentImg to the
   right? So, if currentImg is negImg, and you put the mouse
   in the center of the canvas, the half of the image to the
   left will be the original image but the half on the right
   will be negative.
*/

PImage img, negImg, grayImg, binaryImg, currentImg;
String[] imgFiles = {"4.2.07.jpg", "4.2.03.jpg"};
int thr = 128;  // Threshold for binary image

void setup() 
{
  size(400, 400);  // Set an initial size
  surface.setResizable(true);    // Make the canvas resizable
  img = loadImage(imgFiles[1]);  // Load imgFiles[1] into img
  surface.setSize(img.width, img.height);  // Resize the canvas to the width and height of img
  image(img, 0, 0);  // Display img at position 0, 0
  currentImg = img;  // Set currentImg to img
  negImg = negative(img);    // Set negImg by calling negative() on img
  grayImg = grayscale(img);  // Set grayImg by calling grayscale() on img
  binaryImg = makeBinary(img, thr);  // Set binaryImg by calling makeBinary() on img with a threshold of thr
}


void draw() 
{
  image(currentImg, 0 ,0);  // Display currentImg at position 0. 0
  color c;
  
  if (mousePressed)
  {
    for (int y = 0; y < height; y ++)
    {
      for (int x = 0; x < width; x++)
      {
        if (x > mouseX)
        {
          c = currentImg.get(x, y);
        }
        else
        {
          c = img.get(x, y);
        }
        
        set(x, y, c);
      }
      
      line(mouseX, 0, mouseX, height);
    }
  }  // end if
  else
  {
    image(currentImg, 0, 0);
  }
}


// Return the negative of the source image
PImage negative(PImage source) 
{
  float maxValue = 255.0;  // Maximum value in a color channel 
  PImage target = createImage(source.width, source.height, ARGB);
  
  for (int y = 0; y < source.height; y++) 
  {
    for (int x = 0; x < source.width; x++) 
    {
      color c = source.get(x, y);
      
      // Set target's (x, y) pixel to inverse of c (255 - c)
      float red = red(c);
      float green = green(c);
      float blue = blue(c);
      red = maxValue - red;     // Invert red color
      green = maxValue - green; // Invert green color
      blue = maxValue - blue;   // Invert blue color
      
      c = color(red, green, blue);
      target.set(x, y, c);
    }
  }
  
  return target;
}


PImage grayscale(PImage source) 
{
  PImage target = createImage(source.width, source.height, RGB);
  for (int y = 0; y < source.height; y++) 
  {
    for (int x = 0; x < source.width; x++) 
    {
      // Get pixel from x, y and into c
      color c = source.get(x, y);  
      
      // Use 0.299 * R + 0.587 * G + 0.114 * B
      float red = .299 * red(c);
      float green = .587 * green(c);
      float blue = .114 * blue(c);
      float val = red + green + blue;
      c = color(val, val, val);
      
      // Set target's (x, y) pixel to grayscale of source pixel
      target.set(x, y, c);
    }
  }
  return target;
}


PImage makeBinary(PImage source, int thr) 
{
  PImage target = createImage(source.width, source.height, RGB);
  color black = color(0), white = color(255);
  target = grayscale(source);
  for (int y = 0; y < source.height; y++) 
  {
    for (int x = 0; x < source.width; x++) 
    {
      color c = source.get(x, y);
      
      // Using blue as referance pixel of grayscale image
      float value = blue(c);  
      
      // If source's (x, y) pixel < thr then set it to black
      // else set it to white
      if (value < thr)
      {
        target.set(x, y, black);
      }
      else
      {
        target.set(x, y, white);
      }
    }
  }
  return target;
}


void keyReleased() 
{
  if (key == 'c')
  {
    currentImg = img;
  }
  else if (key == 'n')
  {
    currentImg = negImg;
  }
  else if (key == 'g')
  {
    currentImg = grayImg;
  }
  else if ( key == 'b')
  {
    currentImg = binaryImg;
  }
  else if (key == CODED)
  {
    // Up arrow increases the threshold for binary image
    if (keyCode == UP)
    {
      if (thr < 225) // Picked 225 for no particular reason
      {
        thr += 10; // Picked 10 just because. No particular reason.
        // Redraw binary image after changing the threshold
        binaryImg = makeBinary(img, thr);
        currentImg = binaryImg;
      }
    }
    // Down arrow decreases the threshold for binary image
    else if (keyCode == DOWN)
    {
      if (thr >= 10)  // Picked 10 for no particular particular reason
      {
        thr -= 10;  // Picked 10 just because. No reason.
        // Redraw binary image after changing the threshold
        binaryImg = makeBinary(img, thr);
        currentImg = binaryImg;
      }
    }
    // Left arrow resets thr to default values
    else if (keyCode == LEFT)
    {
      thr = 128;
      binaryImg = makeBinary(img, thr);
      currentImg = binaryImg;
    }
  }
}
