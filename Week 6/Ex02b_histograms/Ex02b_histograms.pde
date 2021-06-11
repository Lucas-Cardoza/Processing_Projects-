/*
 Student: Lucas Cardoza
 Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
 Assingment: Exercise 2b: Calculating Image Histograms
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
PImage currentImg, bimg, dimg;  // Current, brightened, darkened, and orignal Images
PFont font; // Used to display histogram values
int textX = 50, textY = 75;  // X and Y positions for histogram text
boolean showHisto = false;  // Draw histograms if true
int posR = 10, posG = 275, posB = 541; // Left edges of the color histograms in the canvas.
int nextImg = 0; // Index counter for image array


// Function for initial setup
void setup() 
{
  size(400, 400);  // Set size of display
  surface.setResizable(true);  // Allow for resizing of display
  
  // Java method for getting an array of image files
  fileList = dataFile("").listFiles();
  
  // Load image files into img
  img = new PImage[fileList.length];
  
  for (int i = 0; i < fileList.length; i++)
  {
    img[i] = loadImage(fileList[i].getName());
  }
  
  currentImg = img[0];  // Set current image to the first image file
  surface.setSize(currentImg.width, currentImg.height);  // Resize the display screen to image size
  calcHists(currentImg);  // Get Histogram values for image
  bimg = alterBrightness(currentImg, changeImageValue);  // Get brighter image
  dimg = alterBrightness(currentImg, -changeImageValue);  // Get darker image
  
  // Set up for text font for hisotgram bins and values
  font = createFont("Times New Roman", 30); 
  textFont(font);
}


// Draw function to draw images to screen
void draw() 
{
  // Check to see if histograms are to be drawn
  if (showHisto)
  {
    drawHists();
  }
  else
  {
    image(currentImg, 0, 0);
  }
}


// Function to draw histograms to screen
void drawHists() //<>//
{
  background(255);
  int maxValue = 0;
  
  for (int i = 0; i < bCounts.length; i++)
  {
    // Find the max value of red pixels
    if (rCounts[i] > maxValue)
    {
      maxValue = rCounts[i];
    }
    
    // Find the max value of green pixels
    if (gCounts[i] > maxValue)
    {
      maxValue = gCounts[i];
    }
    
    // Find the max value of blue pixels
    if (bCounts[i] > maxValue)
    {
      maxValue = bCounts[i];
    }
  }
  
  strokeWeight(1);  // Histogram lines = 1 pixel wide
  
  // Scale of histogram to screen size
  int scale = height / 2;
  int value = 0;
  
  // Draw red histogram
  stroke(255, 0, 0);  // Each color in histogram will have its own colored lines
  for (int i = 0; i < rCounts.length; i++)
  {
    // Scale line from height to scale value
    value = int(map(rCounts[i], 0, maxValue, 0, scale));
    line(i + posR, height, i + posR, height - value);
  }
  
  // Draw green histogram 
  stroke(0, 255, 0);  // Each color in histogram will have its own colored lines
  for (int i = 0; i < gCounts.length; i++)
  {
    // Scale line from height to scale value
    value = int(map(gCounts[i], 0, maxValue, 0, scale));
    line(i + posG, height, i + posG, height - value);
  }
  
  // Draw blue histogram 
  stroke(0, 0, 255);  // Each color in histogram will have its own colored lines
  for (int i = 0; i < bCounts.length; i++)
  {
    // Scale line from height to scale value
    value = int(map(bCounts[i], 0, maxValue, 0, scale));
    line(i + posB, height, i + posB, height - value);
  }
  
  // Display histogram red bin and number of pixels text
  if (mouseX >= posR && mouseX < posR + rCounts.length)
  {
    fill(255, 0, 0);
    int x = mouseX - posR;
    String r = str(x) + ": " + rCounts[x];
    text(r, textX, textY);
  }
  
  // Display histogram green bin and number of pixels text
  if (mouseX >= posG && mouseX < posG + gCounts.length)
  {
    fill(0, 255, 0);
    int x = mouseX - posG;
    String g = str(x) + ": " + gCounts[x];
    text(g, textX, textY);
  }
  
  // Display histogram blue bin and number of pixels text
  if (mouseX >= posB && mouseX < posB + bCounts.length)
  {
    fill(0, 0, 255);
    int x = mouseX - posB;
    String b = str(x) + ": " + bCounts[x];
    text(b, textX, textY);
  }
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


// Function to check for keys pressed (released)
void keyReleased() 
{ 
  // Display original image
  if (key == '1')
  {
    currentImg = img[nextImg];
    surface.setSize(currentImg.width, currentImg.height);  // Resize display to image size
    showHisto = false;
  }
  
  // Display brighter image
  if (key == '2')
  {
    currentImg = bimg;
    surface.setSize(currentImg.width, currentImg.height);  // Resize display to image size
    showHisto = false;
  }
  
  // Display darker image
  if (key == '3')
  {
    currentImg = dimg;
    surface.setSize(currentImg.width, currentImg.height);  // Resize display to image size
    showHisto = false;
  }
 
  //If the key is 'h' show currentImg histogram
  if (key == 'h')
  {
    currentImg = img[nextImg];
    // Used +10 to give blue a little more buffer between it and the end of the screen 
    surface.setSize(posB + bCounts.length + 10, img[nextImg].height);
    calcHists(currentImg);  // Get histogram for original image
    showHisto = true;  // Display histogram
  }

  //If the key is 'b' show bimg histogram
  if (key == 'b')
  {
    calcHists(bimg);  // Get histogram for brighter image
    // Used +10 to give blue a little more buffer between it and the end of the screen 
    surface.setSize(posB + bCounts.length + 10, img[nextImg].height);
    showHisto = true;

  }
  
  //If the key is 'd' show dimg histogram
  if (key == 'd')
  {
    calcHists(dimg);  // Get histogram for darker image
    // Used +10 to give blue a little more buffer between it and the end of the screen 
    surface.setSize(posB + bCounts.length + 10, img[nextImg].height);
    showHisto = true;  // Display histogram  
  }
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
        bimg = alterBrightness(currentImg, changeImageValue); // Get brighter image
        dimg = alterBrightness(currentImg, -changeImageValue);  // Get darker image
        showHisto = false;
      }
    }
    else if (keyCode == RIGHT)
    { 
      if (nextImg < (img.length - 1))
      {
        nextImg++;  // Move to next image
        currentImg = img[nextImg];  // Set current image to next image
        surface.setSize(currentImg.width, currentImg.height);  // Resize display to image size
        calcHists(currentImg);   // Get histogram values
        bimg = alterBrightness(currentImg, changeImageValue);  // Get brighter image
        dimg = alterBrightness(currentImg, -changeImageValue);  // Get darker image
        showHisto = false;
      }
    }
  }
  
  // Call to print Histograms
  printHists();
}
      
