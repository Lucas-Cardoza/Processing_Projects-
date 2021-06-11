/* //<>//
 Student: Lucas Cardoza
 Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
 Assignment: Exercise 2a: Calculating Image Histograms
 Instructor: Lloyd Smith
 Due Date: Sunday, February 21, 2021, 11:59 PM
*/


/* 
 This program calculates red, green, and blue histograms.
 It prints values to the console - it does not graph the
 histograms.
*/


//Define arrays for red, green, and blue counts
int[] rCounts = new int[256];  //bins for red histogram
int[] gCounts = new int[256];  //bins for green histogram
int[] bCounts = new int[256];  //bins for blue histogram
int changeImageValue = 40;  // Used to change original image to brighter or darker image
File[] fileList;
// Images in file = "emptyroad.jpg", "daytona.jpg", "daytona2.jpg", "charlton vale 3.jpg", "swl badminton 3.jpg"
PImage[] img;
PImage currentImg, bimg, dimg;  // Current, brightened, darkened, and original Images
int nextImg = 0;  // Left edges of the color histograms in the canvas.


// Function for initial setup
void setup() 
{
  size(400, 400);  // Set size of display
  surface.setResizable(true);  // Allow for resizing of display
  
  // Java method for getting an array of image files
  fileList = dataFile("").listFiles();
  img = new PImage[fileList.length];
  
  // Load image files into img
  for (int i = 0; i < fileList.length; i++)
  {
    img[i] = loadImage(fileList[i].getName());
  }
  
  currentImg = img[0];  // Set current image to the first image file
  surface.setSize(currentImg.width, currentImg.height);  // Resize the display screen to image size
  calcHists(currentImg);  // Get Histogram values for image
  bimg = alterBrightness(currentImg, changeImageValue);  // Get brighter image
  dimg = alterBrightness(currentImg, -changeImageValue);  // Get darker image
  
  /* Below is the orignial test image for testing the calculations, however
     it is no longer being used by the program. I decided to leave it to
     show orignal work.
  */
  //img = makeTestImage(10, 10, color(128);
}


// Draw function to draw images to screen
void draw() 
{
  image(currentImg, 0, 0);
}


// Function to calculate histogram values
void calcHists(PImage img) 
{
  //Calculate red, green, & blue histograms
  
  //First initialize rCounts, gCounts, and bCounts to all 0
  for (int i = 0; i < bCounts.length; i++)
  {
    rCounts[i] = 0;
    gCounts[i] = 0;
    bCounts[i] = 0;
  }

  /*For each pixel, get the red, green, and blue values as ints.
    Increment the counts for the red, green, and blue values.
    For example, if the red value is 25, the green value is 110,
    and the blue value is 42, increment rCounts[25], gCounts[110],
    and bCounts[42].
  */
  
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      color c = img.get(x, y);
      int r = int(red(c));
      int g = int(green(c));
      int b = int(blue(c));
      
      rCounts[r] += 1;
      gCounts[g] += 1;
      bCounts[b] += 1;
    }
  }
}


// Function to print histogram values to console
void printHists() 
{
  //Use a for (int i...) loop to println i, rCounts[i], gCounts[i], and bCounts[i]
  for (int i = 0; i < bCounts.length; i++)
    {
      println(i, rCounts[i], gCounts[i], bCounts[i]);
    }
}


// Function to brighten image
PImage alterBrightness(PImage img, int amount) 
{
  PImage newImg = img.get();  //Make a copy of img
  /*
    Your code here to add amount to the red, green and blue values of each pixel
    in the copied image
  */
  
  for (int y = 0; y < newImg.height; y++)
  {
    for (int x = 0; x < newImg.width; x++)
    {
      color c = newImg.get(x, y);
      float r = red(c), g = green(c), b = blue(c);
      
      // Use contrain to ensure pixel values are between 0-255
      r = constrain(r + amount, 0, 255);
      g = constrain(g + amount, 0, 255);
      b = constrain(b + amount, 0, 255);
      
      // Set new image to values
      newImg.set(x, y, color(r, g, b));
    }
  }
  
  return newImg;  //Return the brightened or darkened image
}


// Function first used to create an image to text calculations out on.
// It is not used anymore, but I thought is should be included to show work done.
PImage makeTestImage(int w, int h, color c) 
{
  //Make a test image of width w and height h and color c
  PImage target = createImage(w, h, ARGB);  //First create a new image
  
  //Your code here to set all the pixel values to c (use a nested loop)
  for (int y = 0; y < target.height; y++)
  {
    for (int x = 0; x <target.width; x++)
    {
      target.set(x, y, c);
    }
  }
  
  return target;  //Return the image
}


// Function to check for keys pressed (released)
void keyReleased() 
{ 
  if (key == CODED)
  {
    if ( keyCode == LEFT)
    {
      // The following if statements are to change between the image files
      if (nextImg >= 1)
      {
        nextImg--;  // Move to privious image
        currentImg = img[nextImg];  // Set current image to previous image
        surface.setSize(currentImg.width, currentImg.height);  // Resize display to image size
        calcHists(currentImg);  // Get histogram values
        bimg = alterBrightness(currentImg, changeImageValue);  // Get brighter image
        dimg = alterBrightness(currentImg, -changeImageValue);  // Get darker image
      }
    }
    else if (keyCode == RIGHT)
    { 
      if (nextImg < (img.length - 1))
      {
        nextImg++;  // Move to next image
        currentImg = img[nextImg];  // Set current image to next image
        surface.setSize(currentImg.width, currentImg.height);  // Resize display to image size
        calcHists(currentImg);  // Get histogram values
        bimg = alterBrightness(currentImg, changeImageValue);  // Get brighter image
        dimg = alterBrightness(currentImg, -changeImageValue);  // Get darker image
      }
    }
  }

  //If the key is 'h' set currentImg to original image
  if (key == 'h')
  {
    currentImg = img[nextImg];
    calcHists(currentImg);  // Get original image histogram
  }

  
  //If the key is 'b' set currentImg to bimg
  if (key == 'b')
  {
    //call calcHists() on bimg
    currentImg = bimg;
    calcHists(bimg);  // Get brighter image histogram
  }
  
  //If the key is 'd' set currentImg to dimg
  if (key == 'd')
  {
    //call calcHists on dimg
    currentImg = dimg;
    calcHists(dimg);  // Get darker image histogram
  }
  
  // Call to print Histograms
  printHists();
}
       
