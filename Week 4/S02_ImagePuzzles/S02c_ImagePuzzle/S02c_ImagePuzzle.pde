/* Pixels have been modified as follows:
   1. Red and green values have been set to random values
   2. Blue values greater than 15 are noise
   3. The image is carried in the blue values that are
      less than 16
   4. Set blue values that are 16 or greater to 0
   5. Multiply blue values that are less than 16 by 16
   6. The image is better seen in the red channel - move
      the blue values to the red channel
   7. Set hotkeys as follows:
      '1' displays the noise image
      '2' displays the fixed image
*/
//Add your code here (setup(), draw(), etc.) to see the correct image

PImage img, currentImg, changedImg;
String imgFiles = "landmark3.png";


void setup()
{
  size(400, 400);  // Set an initial size
  surface.setResizable(true);    // Make the canvas resizable
  img = loadImage(imgFiles);  // Load imgFiles[1] into img
  surface.setSize(img.width, img.height);  // Resize the canvas to the width and height of img
  image(img, 0, 0);  // Display img at position 0, 0
  currentImg = img;  // Set currentImg to img
  changedImg = changeImg(img);    // Set negImg by calling negative() on img
}

void draw() 
{
  image(currentImg, 0 ,0);  // Display currentImg at position 0. 0
}


// Return the negative of the source image
PImage changeImg(PImage source) 
{
  //float maxValue = 255.0;  // Maximum value in a color channel 
  PImage target = createImage(source.width, source.height, ARGB);
  
    /*1. Red and green values have been set to random values
   2. Blue values greater than 15 are noise
   3. The image is carried in the blue values that are
      less than 16
   4. Set blue values that are 16 or greater to 0
   5. Multiply blue values that are less than 16 by 16
   6. The image is better seen in the red channel - move
      the blue values to the red channel */
  
  for (int y = 0; y < source.height; y++) 
  {
    for (int x = 0; x < source.width; x++) 
    {
      color c = source.get(x, y);
      float red = red(c);
      float green = green(c);
      float blue = blue(c);
      
      if (blue <= 15)
      {
        blue *= 16;
      }
      else
      {
        blue = 0;
      }
       green = 0;
       red = blue;
       blue = 0;
      c = color(red, green, blue);
      target.set(x, y, c);
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
  else if (key == '1')
  {
    currentImg = img;
  }
  else if (key == '2')
  {
    currentImg = changeImg(img);
  }
}
