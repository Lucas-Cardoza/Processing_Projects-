// Load and display an image
// Create graycscale images using 3 formula
// Draw grayscale to the left of mouse and color to the right
PImage img, gimg1, gimg2, gimg3, currentImg;
String fname = "colorful1.jpg";
int xPos = 0, yPos = 0, xSpeed = 3, ySpeed = 3;

void setup()
{
  size(400, 400);
  surface.setResizable(true);
  img = loadImage(fname);
  surface.setSize(img.width, img.height);  // Set the canvas to the size of the image
  img = loadImage(fname);
  gimg1 = grayscale1(img);
  gimg2 = grayscale2(img);
  gimg3 = grayscale3(img);
  currentImg = img;
  background(0);
}

void draw()
{
  color c;
  if (mousePressed)
  {
    for (int y = 0; y < height; y++)
    {
      for (int x = 0; x < width; x++)
      {
        if (x < mouseX)
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
  } //end if
  else
  {
   image(currentImg, 0, 0);
  }
}


// Convert pixels in canvas to grayscale
PImage grayscale1(PImage source)  // Use the green channel
{
  PImage target = createImage(source.width, source.height, ARGB);
  for (int y = 0; y < source.height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      color c = source.get(x, y);  // Gets pixel from x, y and into c
      float green = green(c);  // Get green channel from pixel c
      c = color(green, green, green);  // Create a grayscale color from green value
      target.set(x, y, c);
    }
  }
  
  return target;
}


// Average color channels
PImage grayscale2(PImage source)  
{
  PImage target = createImage(source.width, source.height, ARGB);
  for (int y = 0; y < source.height; y++)
  {
    for (int x = 0; x < source.width; x++)
    {
      color c = source.get(x, y);  // Gets pixel from x, y and into c
      float g = green(c), r = red(c), b = blue(c);
      float val = (r + g + b) / 3.0;
      c = color(val, val, val);
      target.set(x, y, c);
    }
  }
  
  return target;
}


// Perceptual formula. Probably best to use most of the time.
PImage grayscale3(PImage source)  
{
  PImage target = createImage(source.width, source.height, ARGB);
  for (int y = 0; y < source.height; y++)
  {
    for (int x = 0; x < source.width; x++)
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


// Switch between color to grayscale functions
void keyReleased()
{
  if (key == 'c')
  {
    currentImg = img;
  }
  else if (key == '1')
  {
    currentImg = gimg1;
  }
  else if (key == '2')
  {
    currentImg = gimg2;
  }
  else if (key == '3')
  {
    currentImg = gimg3;
  }
}
  
