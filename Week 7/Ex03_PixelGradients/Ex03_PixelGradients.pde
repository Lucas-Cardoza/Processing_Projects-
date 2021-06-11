/*
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 3: Pixel Gradients
   Instructor: Lloyd Smith
   Due Date: Sunday, Feb 28, 2021

  Display pixel gradients in horizontal and vertical directions
  Carry out the operations on the canvas so you can repeat them
  multiple times to get a cumulative effect.
*/


PImage img;
File[] fnames;
boolean showImage = true;  //Determines whether draw() displays the image


void setup() 
{
  //Set the canvas size
  size(900, 900);
  
  //Make the canvas resizable
  surface.setResizable(true);
  
  //Load an image
  fnames = dataFile("").listFiles();
  img = loadImage(fnames[0].getName());
  
  //Set the surface size to the size of the image
  surface.setSize(img.width, img.height);
}


void draw() 
{
  //If showImage is true, display the image
  if (showImage)
  {
    image(img, 0, 0);
  }
}


void vDiff() 
{
  //Difference the image pixels in the vertical direction
  //Go from row 0 to row height - 2 and subtract the pixel below.
  //Do this for each row - so it will be the usual nested loop
  //Red, green, and blue channels must be differenced separately
  //Use absolute values - we want the magnitude of the difference
  //Create a grayscale image - add the R, G, and B differences
  //Constrain the sum to be between 0 and 255
  //Create a new grayscale color from the sum and set the pixel on the canvas
  //*Do not* modify the image pixel
  
  /* 
     I tried to figure out how to modify my program so that the image wraps
     around itself as suggested in the handout, but I could not figure out how
     to implement it.
  */
  for (int y = 0; y < height - 2; y++)
  {
    for (int x = 0; x < width; x++)
    {
      // Get color values of pixel(x, y) and its neighbour
      color c1 = get(x, y);
      color c2 = get(x, y + 1);
      float red = getResult(red(c1), red(c2), false);
      float green = getResult(green(c1), green(c2), false);
      float blue = getResult(blue(c1), blue(c2), false);

      // Add constrained color channel values together to get new color
      float newValue = constrain(red + green + blue, 0, 255);

      // Set new image to new color values
      set(x, y, color(newValue, newValue, newValue));
    }
  }
}


void hDiff() 
{
  //Difference the image pixels in the horizontal direction
  //Go from column 0 to width - 2 and subtract the pixel to the right
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width - 2; x++)
    {
      // Get color values of pixel(x, y) and its neighbour
      color c1 = get(x, y);
      color c2 = get(x + 1, y);
      float red = getResult(red(c1), red(c2), false);
      float green = getResult(green(c1), green(c2), false);
      float blue = getResult(blue(c1), blue(c2), false);
      
      // Add constrained color channel values together to get new color
      float newValue = constrain(red + green + blue, 0, 255);
      
      // Set new image to color values
      set(x, y, color(newValue, newValue, newValue));
    }
  }
}


void vAvg() 
{
  //Average each pixel with the one below it.
  for (int y = 0; y < height - 2; y++)
  {
    for (int x = 0; x < width; x++)
    {
      // Get color values of pixel(x, y) and its neighbour
      color c1 = get(x, y);
      color c2 = get(x, y + 1);
      
      float red = getResult(red(c1), red(c2), true);
      float green = getResult(green(c1), green(c2), true);
      float blue = getResult(blue(c1), blue(c2), true);

      // Set new image to color values
      set(x, y, color(red, green, blue));
    }
  }
}


void hAvg() 
{
  //Average each pixel with the one to the right.
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width - 2; x++)
    {
      // Get color values of pixel(x, y) and its neighbour
      color c1 = get(x, y);
      color c2 = get(x + 1, y);
      
      float red = getResult(red(c1), red(c2), true);
      float green = getResult(green(c1), green(c2), true);
      float blue = getResult(blue(c1), blue(c2), true);
      
      // Set new image to color values
      set(x, y, color(red, green, blue));
    }
  }
}


void keyReleased() 
{
  if (key == 'h') 
  {
    showImage = false;
    
    //Show the horizontal gradient
    hDiff();    
  } 
  else if (key == 'v') 
  {
    showImage = false;
    
    //Show the vertical gradient
    vDiff();
  } 
  else if (key == 'H') 
  {
    showImage = false;
    
    //Show the vertical average
    hAvg();
  } 
  else if (key == 'V') 
  {
    showImage = false;
    
    //Show the vertical average
    vAvg();
  } 
  else if (key == '0') 
  {
    //Load fnames[0]
    img = loadImage(fnames[0].getName());;
    surface.setSize(img.width, img.height);
    showImage = true;
  } 
  else if (key == '1') 
  {
    //Load fnames[1]
    img = loadImage(fnames[1].getName());
    surface.setSize(img.width, img.height);
    showImage = true;
  } 
  else if (key == '2') 
  {
    //Load fnames[2]
    img = loadImage(fnames[2].getName());
    surface.setSize(img.width, img.height);
    showImage = true;
  }
  else if (key == '3') 
  {
    //Load fnames[3]
    img = loadImage(fnames[3].getName());
    surface.setSize(img.width, img.height);
    showImage = true;
  }
  else if (key == '4') 
  {
    //Load fnames[4]
    img = loadImage(fnames[4].getName());
    surface.setSize(img.width, img.height);
    showImage = true;
  }
  else if (key == '5') 
  {
    //Load fnames[5]
    img = loadImage(fnames[5].getName());
    surface.setSize(img.width, img.height);
    showImage = true;
  }
  else if (key == '6') 
  {
    //Load fnames[6]
    img = loadImage(fnames[6].getName());
    surface.setSize(img.width, img.height);
    showImage = true;
  }
}


// Function to calculate the absolute value or the average of the
// differences between pixels
float getResult (float firstColor, float secondColor, boolean ave)
{
  if (ave)
  {
    return constrain(((firstColor + secondColor) / 2.0), 0, 255);
  }
  else 
  {
    return abs(secondColor - firstColor);
  }
}
