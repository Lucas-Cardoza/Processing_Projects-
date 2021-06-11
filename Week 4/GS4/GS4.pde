// Load and display an image
// Create graycscale images using 3 formula
// Draw grayscale to the left of mouse and color to the right
PImage img, gimg, currentImg;
String fname = "colorful1.jpg";
int startX, startY;


void setup()
{
  size(400, 400);
  surface.setResizable(true);
  img = loadImage(fname);
  surface.setSize(img.width, img.height);  // Set the canvas to the size of the image
  currentImg = img;
  background(0);
  noFill();
  strokeWeight(3);
  stroke(255, 0, 0);
  rectMode(CORNERS);
}


void draw()
{
  image(currentImg, 0, 0);
  color c;
  if (mousePressed)
  {
    rect(startX, startY, mouseX, mouseY);
  }
}


// Perceptual formula. Probably best to use most of the time.
PImage grayscale(PImage source, int startX, int startY, int endX, int endY)  
{
  PImage target = createImage(source.width, source.height, ARGB);
  for (int y = startY; y < endY; y++)
  {
    for (int x = startX; x < endX; x++)
    {
      color c = source.get(x, y);  // Gets pixel from x, y and into c
      float r = .299 * red(c);
      float g = .587 * green(c);
      float b = .114 * blue(c);
      float val = r + g + b;
      c = color(val, val, val);
      target.set(x, y, c);
    }
  }
  
  return target;
}


void mousePressed()
{
  currentImg = img;
  startX = mouseX;
  startY = mouseY;
}


void mouseReleased ()
{
  int endX, endY;
  if (mouseX < startX)
  {
    endX = startX;
    startX = mouseX;
  }
  else
  {
    endX =mouseX;
  }
  
    if (mouseY < startY)
  {
    endY = startY;
    startY = mouseY;
  }
  else
  {
    endY = mouseY;
  }
  
  gimg = grayscale(img, startX, startY, endX, endY);
  currentImg = gimg;
}

  
