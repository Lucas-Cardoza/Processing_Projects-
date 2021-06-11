/* 
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 12a: Global Thresholding
   Instructor: Lloyd Smith
   Due Date: Sunday, May 2, 2021, 11:59 PM


  Converts a grayscale image to binary by thresholding
  'i' displays grayscale image;
  'h' displays histogram of grayscale image
  '1' displays binary image using mean pixel value as thr
  '2' displays binary image using median pixel value as thr
  '3' displays binary image using Ridler Calvard thr
  This version allows multiple thr methods
*/


final int MEAN = 0, MEDIAN = 1, RC = 2; //methods of finding thr
int thrMethod = RC;
String[] fname = {"basketball.jpg", "FlyingMan.jpg",
                  "bicycles.jpeg", "ChromaKeyLadybug7-512.jpg",
                  "Man-Blue.jpg", "studiosetup_standing.jpg",
                  "TRACEY-blue.jpg", "Woman1.jpg",
                  "coins_cambodia.jpg", "drakearmadaletter.jpg"};
PImage img, meanthr_img, medianthr_img, rcthr_img;
int[] redHist = new int[256], greenHist = new int[256];
int[] blueHist = new int[256];
int posRed = 10, posGreen = 275, posBlue = 541;
int xval, yval;
PFont f;
boolean showHists = false;  //Start out showing image
int rmax=0, gmax=0, bmax=0; //hold max vals for each band
PImage display;  //Image to display


void setup() 
{
  size(500, 500);
  surface.setResizable(true);
  img = loadImage(fname[2]);
  //img.resize(500, 0);  //Use this for fname[6]
  
  if (img.width < (256 * 3 + 30)) 
  {
    surface.setSize(256 * 3 + 30, img.height);
  }
  else 
  {
    surface.setSize(img.width, img.height);
  }
  
  img.filter(GRAY);
  img.loadPixels();
  
  calcHists();
  meanthr_img = thresholdImage(img, MEAN);
  medianthr_img = thresholdImage(img, MEDIAN);
  rcthr_img = thresholdImage(img, RC);
  
  background(0);
  image(img, 0, 0);
  
  stroke(255, 0, 0);
  strokeWeight(1);
  f = createFont("verdana", 24);
  textFont(f);
  
  display = img;  // Set display image to be the grayscale image
}


void draw() 
{
  if (showHists) 
  {
    drawHists();
  }
  else 
  {
    image(display, 0, 0);
  }
}


float getThreshold(PImage img, int method) 
{
  float thr = 0.0;
  
  if (method == MEAN) 
  {
    thr = avgPixels(img);  //Calculate thr using mean pixel value
  }
  else if (method == MEDIAN) 
  {
    thr = getMedianPixel(img); //Calculate using median pixel
  }
  else if (method == RC) 
  {
    thr = ridlerCalvard(redHist);  //Calculate by ridlerCalvard
  }
  
  println("Thr:", thr);
  return thr;
}


PImage thresholdImage(PImage src, int thrMethod) 
{
  PImage newImage = src.get();  //newImage is a copy of src
  newImage.loadPixels();
  float thr = getThreshold(newImage, thrMethod); //Uncomment to calculate thr
  //newImage.filter(THRESHOLD, 0.5);  //Remove this statement
  
  //Add code here to convert newImage to binary
  for (int i = 0; i < newImage.pixels.length; i++)
  {
    float val = blue(newImage.pixels[i]);
    
    if (val > thr)
    {
      val = 255;
    }
    else 
    {
      val = 0;
    }
    
    newImage.pixels[i] = color(val, val, val);
  }
  
  newImage.updatePixels();
  return newImage;
}


float avgPixels(PImage pic) 
{
  //Add your code to calculate and return the mean pixel value
  pic.loadPixels();
  float total = 0;
  
  for (int i = 0; i < pic.pixels.length; i++)
  {
    total += blue(pic.pixels[i]);
  }
  
  return total / pic.pixels.length; //128.0;  //Test value to allow debugging
}


float getMedianPixel(PImage pic) 
{
  //Add your code to calculate and return the median pixel value
  float median = 0.0;
  pic.loadPixels();
  float[] pArray = new float[pic.pixels.length];
  
  for (int i = 0; i < pic.pixels.length; i++)
  {
    pArray[i] = blue(pic.pixels[i]);
  }
  
  pArray = sort(pArray);
  
  if ((pArray.length % 2) == 0)
  {
    float valOne = pArray[int(pArray.length / 2.0)];
    float valTwo = pArray[int(pArray.length / 2.0) + 1];
    median = (valOne + valTwo) / 2.0;
  }
  else
  {
    median = pArray[pArray.length / 2];
  }
  
  return median; //128.0;  //Test value to allow debugging
}


float ridlerCalvard(int[] hist) 
{
  //Add your code to calculate and return the threshold
  /*
    Algorithm findThreshold(Image src):
    T0 = 0
    T1 = 128
    while T0 != T1:
      T0 = T1
      M0 = the mean of all samples < T0
      M1 = the mean of all samples >= T0
      T1 = (M0+M1)/2
    return T0
  */
  
  int t0 = 0, t1 = 128;
  
  while (t0 != t1)
  {
    t0 = t1;
    float m0 = histMean(hist, 0, t0);
    float m1 = histMean(hist, t0, hist.length);
    t1 = int((m0 + m1) / 2);
  }
    
  return float(t0);  //Test value to allow debugging
}


float histMean(int[] nums, int start, int stop) 
{
  /*
    Add your code to calculate mean pixel value from start to stop
    Remember that nums[] is a histogram - nums[i] represents the
    number of pixels that have a value of i. For example, if nums[38]
    is 212, that means 212 pixels have a value of 38
  */
  float total = 0.0, numOfPixels = 0.0;
  
  for (int i = start; i < stop; i++)
  {
    total = total + i * nums[i];
    numOfPixels += nums[i];
  }
  
  return total / numOfPixels;  //Test value to allow debugging
}


void calcHists() 
{
  int r, g, b;
  
  //First init hist counts to 0
  for (int i = 0; i < redHist.length; i++) 
  {
    redHist[i] = 0; greenHist[i] = 0; blueHist[i] = 0;
  }
  
  //Now fill r, g, and b hists with counts 
  for (int i = 0; i < img.pixels.length; i++) 
  {
    r = (int) red(img.pixels[i]);
    g = (int) green(img.pixels[i]);
    b = (int) blue(img.pixels[i]);
    redHist[r] += 1;
    greenHist[g] += 1;
    blueHist[b] += 1;
  }
  
  //Now find max values for each band
  rmax = 0; gmax = 0; bmax = 0;
  for (int i = 0; i < redHist.length; i++) 
  {
    if (redHist[i] > rmax) rmax = redHist[i];
    if (greenHist[i] > gmax) gmax = greenHist[i];
    if (blueHist[i] > bmax) bmax = blueHist[i];
  }
  
  //println(rmax + "; " + gmax + "; " + bmax);
}


void drawHists() 
{
  background(0);
  stroke(255, 0, 0);
  
  for (int i = 0; i < redHist.length; i++) 
  {
    yval = (int) map(redHist[i], 0, rmax, 0, height/2);
    xval = i + posRed;
    line(xval, height, xval, height-yval);
  }
  
  stroke(0, 255, 0);
  
  for (int i = 0; i < greenHist.length; i++) 
  {
    yval = (int) map(greenHist[i], 0, gmax, 0, height/2);
    xval = i + posGreen;
    line(xval, height, xval, height-yval);
  }
  
  stroke(0, 0, 255);
  
  for (int i = 0; i < blueHist.length; i++) 
  {
    yval = (int) map(blueHist[i], 0, bmax, 0, height/2);
    xval = i + posBlue;
    line(xval, height, xval, height-yval);
  }
  
  if (mouseX >= posRed && mouseX < posRed + redHist.length) 
  {
    xval = mouseX - posRed;
    text("x: " + xval + "; y: " + redHist[xval], 10, 50);
  }
  else if (mouseX >= posGreen && mouseX < posGreen+greenHist.length) 
  {
    xval = mouseX - posGreen;
    text("x: " + xval + "; y: " + greenHist[xval], 10, 50);
  }
  else if (mouseX >= posBlue && mouseX < posBlue+blueHist.length) 
  {
    xval = mouseX - posBlue;
    text("x: " + xval + "; y: " + blueHist[xval], 10, 50);
  }
}


void keyReleased() 
{
  showHists = false;
  if (key == 'i' || key == 'I') 
  {
    display = img;
  }
  else if (key == 'h' || key == 'H') 
  {
    showHists = true;
  }
  //else if (key == 'b' || key == 'B') display = thr_img;
  else if (key == '1') 
  {
    display = meanthr_img;
  }
  else if (key == '2') 
  {
    display = medianthr_img;
  }
  else if (key == '3') 
  {
    display = rcthr_img;
  }
}
