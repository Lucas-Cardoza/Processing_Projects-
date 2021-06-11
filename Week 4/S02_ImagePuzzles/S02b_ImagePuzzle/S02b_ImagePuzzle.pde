/* Pixels in landmark2.png have been modified as follows:
   Red values have been set to random values
   The image is carried in the green and blue values but
   they have been divided by 20
   Set the red channel to 0; multiply green & blue by 20
   Set hotkeys as follows:
   '1' displays the noise image; '2' displays the fixed image
*/
//Add your setup and draw functions, as well as any other
//you think are needed, to solve this puzzle

PImage img, currentImg, changedImg;
String imgFiles = "landmark2.png";


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
  
  for (int y = 0; y < source.height; y++) 
  {
    for (int x = 0; x < source.width; x++) 
    {
      color c = source.get(x, y);
      float red = red(c);
      float green = green(c);
      float blue = blue(c);
      red = 0;     
      green = green * 20;
      blue = blue * 20;

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
