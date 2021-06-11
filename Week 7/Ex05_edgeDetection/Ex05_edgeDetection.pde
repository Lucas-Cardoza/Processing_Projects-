/*
 Student: Lucas Cardoza
 Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
 Exercise No. 5: Edge Detection
 Instructor: Lloyd Smith
 Due Date: Sunday, Feb 28, 2021
 
 Perform edge detection using a mask
*/


File[] fname; // = "emptyroad.jpg", "Chang’e 5-T1 On the Far Side of the Moon.jpg", "Mural.jpg";
//String loadName = fname;
float[][] k1 = {{1/9.0, 1/9.0, 1/9.0}, {1/9.0, 1/9.0, 1/9.0}, {1/9.0, 1/9.0, 1/9.0}}; //Blur
float[][] k2 = {{-1.0, -1.0, -1.0}, {0.0, 0.0, 0.0}, {1.0, 1.0, 1.0}};  //Prewitt horizontal
float[][] k3 = {{-1.0, 0.0, 1.0}, {-1.0, 0.0, 1.0}, {-1.0, 0.0, 1.0}};  //Prewitt vertical
float[][] k4 = {{-1.0, -2.0, -1.0}, {0.0, 0.0, 0.0}, {1.0, 2.0, 1.0}};  //Sobel horizontal
float[][] k5 = {{-1.0, 0.0, 1.0}, {-2.0, 0.0, 2.0}, {-1.0, 0.0, 1.0}};  //Sobel vertical
float[][] k6 = {{-1.0, -1.0, -1.0}, {-1.0, 8.0, -1.0}, {-1.0, -1.0, -1.0}}; //Laplacian
PImage[] img = new PImage[10]; //I used an array of images; you could do it differently
int imgIndex = 0, nextImg = 0;


void setup() 
{
  size(500, 500);
  surface.setResizable(true);
  //Load and display initial image
  fname = dataFile("").listFiles();
  img[imgIndex] = loadImage(fname[nextImg].getName());
  surface.setSize(img[imgIndex].width, img[imgIndex].height);
  //Add code here to call filter function
  img[1] = convolve(img[0], k1);  // Blur
  img[2] = convolve(img[0], k2);  // Prewitt horizontal
  img[3] = convolve(img[0], k3);  // Prewitt vertical
  img[4] = convolve(img[0], k4);  // Sobel horizontal
  img[5] = convolve(img[0], k5);  // Sobel vertical
  img[6] = convolve(img[0], k6);  // Laplacian
  
  for (int i = 0; i < 5; i++)  // Stronger blur
  {
    img[1] = convolve(img[1], k1);
  }
  
  img[7] = addImages(img[1], img[6]);  // Blurred + Laplacian
  img[8] = subtractImages(img[0], img[1]);
  img[9] = addImages(img[0], img[8]);  // Unsharp filter
}


void draw() 
{
  image(img[imgIndex], 0, 0);
}


PImage convolve(PImage source, float[][] kernel) 
{
  PImage target = createImage(source.width, source.height, ARGB);
  //Your code here to implement edge detection 
  // Leaving a border of unfiltered pixels
  for (int y = 1; y < source.height - 1; y++) 
  {
    for (int x = 1; x < source.width - 1; x++) 
    {
      float red = 0, green = 0, blue = 0;
      // Commented out the above line and replaced with the line below to 
      // get the "emboss" effect on filters. Pretty cool!
      // float red = 128, green = 128, blue = 128;
      
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


//Add two images and return the result (used to add an edge image and for unsharp filtering)
PImage addImages(PImage img1, PImage img2) 
{
  PImage target = createImage(img1.width, img2.height, RGB); //Assume both images are the same size
  
  //Your code here to add images; make sure pixels stay in range 
  for (int y = 0; y < img1.height; y++)
  {
    for (int x = 0; x < img1.width; x++)
    {
      // Get color values of pixel(x, y)
      color c1 = img1.get(x, y);
      color c2 = img2.get(x, y);
      
      float red = getResult(red(c1), red(c2), true);
      float green = getResult(green(c1), green(c2), true);
      float blue = getResult(blue(c1), blue(c2), true);
      
      // Set new image to new color values
      target.set(x, y, color(red, green, blue));
    }
  }
  
  return target;
}


//Subtract images - use abs value; one will be a blurred image (used for unsharp filtering)
PImage subtractImages(PImage img1, PImage img2) 
{
  PImage target = createImage(img1.width, img2.height, RGB); //Assume they are the same size
  
  //Your code here to subtract images - use abs value
  for (int y = 0; y < img1.height; y++)
  {
    for (int x = 0; x < img1.width; x++)
    {
      // Get color values of pixel(x, y)
      color c1 = img1.get(x, y);
      color c2 = img2.get(x, y);
      
      float red = getResult(red(c1), red(c2), false);
      float green = getResult(green(c1), green(c2), false);
      float blue = getResult(blue(c1), blue(c2), false);
      
      // Set new image to new color values
      target.set(x, y, color(red, green, blue));
    }
  }
  
  return target;
}


void keyReleased() 
{
  //Add code to set imgIndex to select image to display
  if (key >= '0' && key <= '9')
  {
    imgIndex = int(str(key));
  }
  else if (key == CODED)  // To change from image to image
  {
    if ( keyCode == LEFT)
    {
      // The following if statements are to change between the image files
      if (nextImg >= 1)
      {
        nextImg--;  // Move to previous image
        imgIndex = 0;  // Reset index to show new image
        img[0] = loadImage(fname[nextImg].getName());  // Set current image to next image
        surface.setSize(img[0].width, img[0].height);  // Resize display to image size
        img[1] = convolve(img[0], k1);  //Blur
        img[2] = convolve(img[0], k2);  //Prewitt horizontal
        img[3] = convolve(img[0], k3);  //Prewitt vertical
        img[4] = convolve(img[0], k4);  //Sobel horizontal
        img[5] = convolve(img[0], k5);  //Sobel vertical
        img[6] = convolve(img[0], k6);  //Laplacian
        
        for (int i = 0; i < 5; i++)  // Stronger blur
        {
          img[1] = convolve(img[1], k1);
        }
  
        img[7] = addImages(img[1], img[6]);  // Blurred + Laplacian
        img[8] = subtractImages(img[0], img[1]);
        img[9] = addImages(img[0], img[8]);  // Unsharp filter
      }
    }
    else if (keyCode == RIGHT)
    {
      if (nextImg < fname.length - 1)
      {
        nextImg++;  // Move to next image
        imgIndex = 0;  // Reset index to show new image
        img[0] = loadImage(fname[nextImg].getName());  // Set current image to next image
        surface.setSize(img[0].width, img[0].height);  // Resize display to image size
        img[1] = convolve(img[0], k1);  //Blur
        img[2] = convolve(img[0], k2);  //Prewitt horizontal
        img[3] = convolve(img[0], k3);  //Prewitt vertical
        img[4] = convolve(img[0], k4);  //Sobel horizontal
        img[5] = convolve(img[0], k5);  //Sobel vertical
        img[6] = convolve(img[0], k6);  //Laplacian
        
        for (int i = 0; i < 5; i++)  // Stronger blur
        {
          img[1] = convolve(img[1], k1);
        }
        
        img[7] = addImages(img[1], img[6]);  // Blurred + Laplacian
        img[8] = subtractImages(img[0], img[1]);
        img[9] = addImages(img[0], img[8]);  // Unsharp filter
      }
    }
  }
}


// Function to calculate the absolute value of the
// differences between pixels
float getResult (float firstColor, float secondColor , boolean add)
{
  if (add)
  {
    return constrain((firstColor + secondColor), 0, 255);
  }
  else
  {
    return constrain(abs(secondColor - firstColor), 0, 255);
  }
}
