/*
 Student: Lucas Cardoza
 Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
 Exercise No. 4: Filtering Images in the Spatial Domain
 Instructor: Lloyd Smith
 Due Date: Sunday, Feb 28, 2021


Perform spatial filtering using a mask
*/


File[] fnames; // = "emptyroad.jpg", fname2 = "";
//String loadName = fname1;
float[][] k1 = {{1/9.0, 1/9.0, 1/9.0}, {1/9.0, 1/9.0, 1/9.0}, {1/9.0, 1/9.0, 1/9.0}}; //Low pass
float[][] k2 = {{-1.0, -1.0, -1.0}, {-1.0, 9.0, -1.0}, {-1.0, -1.0, -1.0}};          //High pass
PImage[] img = new PImage[4]; //I used an array of images; you could do it differently
int nextImg = 0; // Index counter for image array


void setup() 
{
  size(500, 500);
  surface.setResizable(true);
  //Load and display initial image
  fnames = dataFile("").listFiles();
  img[nextImg] = loadImage(fnames[0].getName());
  surface.setSize(img[nextImg].width, img[nextImg].height);
  image(img[nextImg], 0, 0);
  img[1] = convolve(img[0], k1);  //Low passed image
  img[2] = convolve(img[0], k2);  //High passed image
  img[3] = convolve(img[0], k1);  
  img[3] = convolve(img[3], k2);  // Do a low pass followed by a high pass for img[3]
}


void draw() 
{
  //You could display here but you might prefer to display images in keyPressed()
}


PImage convolve(PImage source, float[][] kernel) 
{
  PImage target = createImage(source.width, source.height, ARGB);
  //target = grayscale(source);
  
  // Leaving a border of unfiltered pixels
  for (int y = 1; y < source.height - 1; y++) 
  {
    for (int x = 1; x < source.width - 1; x++) 
    {
      float red = 0, green = 0, blue = 0;
      
      // Get upper left values
      color c = source.get(x - 1, y - 1);
      red += red(c) * kernel[0][0];
      green += green(c) * kernel[0][0];
      blue += blue(c) * kernel[0][0];
      
      // Get upper center values
      c = source.get(x, y - 1);
      red += red(c) * kernel[0][1];
      green += green(c) * kernel[0][1];
      blue += blue(c) * kernel[0][1];
      
      // Get upper right values
      c = source.get(x + 1, y - 1);
      red += red(c) * kernel[0][2];
      green += green(c) * kernel[0][2];
      blue += blue(c) * kernel[0][2];
      
      // Get middle left values
      c = source.get(x - 1, y);
      red += red(c) * kernel[1][0];
      green += green(c) * kernel[1][0];
      blue += blue(c) * kernel[1][0];
      
      // Target pixel
      c = source.get(x, y);
      red += red(c) * kernel[1][1];
      green += green(c) * kernel[1][1];
      blue += blue(c) * kernel[1][1];
      
      // Get middle right values
      c = source.get(x + 1, y);
      red += red(c) * kernel[1][2];
      green += green(c) * kernel[1][2];
      blue += blue(c) * kernel[1][2];
      
      // Get lower left values
      c = source.get(x - 1, y + 1);
      red += red(c) * kernel[2][0];
      green += green(c) * kernel[2][0];
      blue += blue(c) * kernel[2][0];
      
      // Get lower center values
      c = source.get(x, y + 1);
      red += red(c) * kernel[2][1];
      green += green(c) * kernel[2][1];
      blue += blue(c) * kernel[2][1];
      
      // Get middle right values
      c = source.get(x + 1, y + 1);
      red += red(c) * kernel[2][2];
      green += green(c) * kernel[2][2];
      blue += blue(c) * kernel[2][2];
      
      // Set target color
      target.set(x, y, color(red, green, blue));
    }
  }
  
  return target;
}


//Optional
PImage grayscale(PImage img) 
{
  for (int y = 0; y < img.height; y++) 
  {
    for (int x = 0; x < img.width; x++) 
    {
      color p = img.get(x, y);
      float r = red(p), g = green(p), b = blue(p);
      float val = 0.299 * r + 0.587 * g + 0.114 * b;
      img.set(x, y, color(val, val, val));
    }
  }
  
  return img;
}


void keyReleased() 
{
  if (key == '0' && img[0] != null) 
  {
    image(img[0], 0, 0);
  }
  else if (key == '1' && img[1] != null)
  {
    image(img[1], 0, 0);
  }
  else if (key == '2' && img[2] != null)
  {
    image(img[2], 0, 0);
  }
    else if (key == '3' && img[2] != null)
  {
    image(img[3], 0, 0);
  }
  else if (key > '3' && key <= '9')
  {
    int n = int(str(key));
    
    for (int i = 0; i < n; i++)
    {
      img[1] = convolve(img[1], k1);
    }
    
    image(img[1], 0, 0);
  }
  else if (key == 'r')  // Reset to original image
  {
    img[0] = loadImage(fnames[nextImg].getName());
    img[1] = convolve(img[0], k1);
    img[2] = convolve(img[0], k2);
    image(img[0], 0, 0);
  }
  else if (key == 'g')  // Convert image to grayscale
  {
    grayscale(img[0]);
    img[1] = convolve(img[0], k1);
    img[2] = convolve(img[0], k1);
    image(img[0], 0, 0);
  }
  if (key == CODED)  // To change from image to image
  {
    if ( keyCode == LEFT)
    {
      // The following if statements are to change between the image files
      if (nextImg >= 1)
      {
        nextImg--;  // Move to previous image
        img[0] = loadImage(fnames[nextImg].getName());  // Set current image to next image
        surface.setSize(img[0].width, img[0].height);  // Resize display to image size
        img[1] = convolve(img[0], k1);
        img[2] = convolve(img[0], k2);
        img[3] = convolve(img[0], k1);  
        img[3] = convolve(img[3], k2);  // Do a low pass followed by a high pass for img[3]
        image(img[0], 0, 0);
      }
    }
    else if (keyCode == RIGHT)
    {
      if (nextImg < fnames.length - 1)
      {
        nextImg++;  // Move to next image
        img[0] = loadImage(fnames[nextImg].getName());  // Set current image to next image
        surface.setSize(img[0].width, img[0].height);  // Resize display to image size
        img[1] = convolve(img[0], k1);
        img[2] = convolve(img[0], k2);
        img[3] = convolve(img[0], k1);  
        img[3] = convolve(img[3], k2);  // Do a low pass followed by a high pass for img[3]
        image(img[0], 0, 0);
      }
    }
    else if (keyCode == UP)  // Do a low pass followed by a high pass
    {
      img[3] = convolve(img[0], k1);
      img[3] = convolve(img[3], k2);
      image(img[3], 0, 0);
    }
    else if (keyCode == DOWN)  // Do a high pass followed by a low pass
    {
      img[3] = convolve(img[0], k2);
      img[3] = convolve(img[3], k1);
      image(img[3], 0, 0);
    }
  }
  
}
