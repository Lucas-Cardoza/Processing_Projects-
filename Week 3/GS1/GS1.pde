// Load and display an image
// Convert canvas to graycscale using 3 formula
PImage img;
String fname = "colorful1.jpg";

void setup()
{
  size(400, 400);
  surface.setResizable(true);
  img = loadImage(fname);
  surface.setSize(img.width, img.height);  // Set the canvas to the size of the image 
  //println(img.width, img.height);
}

void draw()
{
}


// Convert pixels in canvas to grayscale
void grayscale1()  // Use the green channel
{
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      color c = img.get(x, y);  // Gets pixel from x, y and into c
      float green = green(c);  // Get green channel from pixel c
      c = color(green, green, green);  // Create a grayscale color from green value
      set(x, y, c);
    }
  }
}


// Average color channels
void grayscale2()  
{
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      color c = img.get(x, y);  // Gets pixel from x, y and into c
      float g = green(c), r = red(c), b = blue(c);
      float val = (r + g + b) / 3.0;
      c = color(val, val, val);
      set(x, y, c);
    }
  }
}


// Perceptual formula. Probably best to use most of the time.
void grayscale3()  
{
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      color c = img.get(x, y);  // Gets pixel from x, y and into c
      float r = .299 * red(c);
      float g = .587 * green(c);
      float b = .114 * blue(c);
      float val = r + g + b;
      c = color(val, val, val);
      set(x, y, c);
    }
  }
}


// Switch between color to grayscale functions
void keyReleased()
{
  if (key == 'c')
  {
    image(img, 0, 0);
  }
  else if (key == '1')
  {
    grayscale1();
  }
  else if (key == '2')
  {
    grayscale2();
  }
  else if (key == '3')
  {
    grayscale3();
  }
}
  
