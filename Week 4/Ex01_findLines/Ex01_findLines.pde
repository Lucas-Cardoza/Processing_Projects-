/* //<>//
 Student: Lucas Cardoza
 Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
 Assingment: Exercise 1: Find Colors in an Image
 Instructor: Lloyd Smith
 Due Date: Sunday, February 7, 2021, 11:59 PM
*/


//This program finds colors in an image and creates new images with only selected colors.
//It's set up to process emptyroad.jpg: type 0, 1, 2, or 3 to display images
PImage[] img = new PImage[4];
int imgIndex = 0;  //Specifies which image to display in draw()
String[] imgFiles = {"emptyroad.jpg"};
int mVal = 0;


void setup() 
{
  //Reference colors for emptyroad.jpg
  color refWhite = color(255), refYellow = color(244, 217, 126);
  float white_thr = 75, yellow_thr = 50; //Thresholds for emptyroad.jpg
  size(500, 500);  // Display size
  surface.setResizable(true);  // Resize display to the image's size
  img[0] = loadImage(imgFiles[0]);  // Load "emptyroad.jpg" into img[0]
  surface.setSize(img[0].width, img[0].height);  // Set size to the width & height of img[0]
  img[1] = findColor(img[0], refWhite, white_thr);
  img[2] = findColor(img[0], refYellow, yellow_thr);
  img[3] = addImages(img[1], img[2]);
  imgIndex = 0;  //Set imgIndex to 0 to display original image
}


// Function to draw to screen
void draw() 
{
  image(img[imgIndex], 0, 0);
  
  // Method to display color of pixel at mouse location
  if (mousePressed && mouseButton == RIGHT)
  {
    color c = get(mouseX, mouseY);
    fill(c);
    noStroke();
    rect(20, 20, 50, 50);
  }
}


// Function to display pixel location at mouse click
void mouseClicked()
{
  // Get location of mouse on display screen
  int x = mouseX, y = mouseY;
  println("Pixel at x", x, "y", y);
}


//Select pixels that are close to refColor in img1; return an image with pixels
//that are not close to refColor set to black
PImage findColor (PImage img1, color refColor, float thr) 
{
  color black = color(0, 0, 0);
  float d;  //Will hold distance between pixel colors
  
  //Create an image (img2) that is the same width and height as img1
  PImage img2 = createImage(img1.width, img1.height, ARGB);

  //Use a nested loop to examine each pixel in img1
  for (int y = 0; y < img1.height; y++) 
  {
    for (int x = 0; x < img1.width; x++) 
    {
      color c = img1.get(x, y);  // Get color from pixel at (x, y)
 
      //Set d to cdist between the current pixel and the reference color
      d = cdist(c, refColor);
      
      //if d > thr, set the current pixel in img2 to black
      if (d > thr)  // Check the distance against the threshold
      {
        c = black;  // Set to black
        img2.set(x, y, c);
      }
      //else set the current pixel to the color in img1
      else
      {
        img2.set(x, y, c);  // Set img2 color to current img1 color
      }
    }
  }
  
  return img2;
}


// Function to calculate the distance of pixels
float cdist(color c1, color c2) 
{
  //color distance: return the Euclidean distance between c1 and c2
  float dist = sqrt(sq(red(c2) - red(c1)) + sq(green(c2) - green(c1)) + sq(blue(c2) - blue(c1)));
  return dist;
}


// Function to combine img1 and img2 to make third image
PImage addImages(PImage img1, PImage img2) 
{
  float red, green, blue;
  //Create a new image (img3) that is the same width and height as img1 and img2
  PImage img3 = createImage(img1.width, img1.height, ARGB);
  
  for (int y = 0; y < img1.height; y++) 
  {
    for (int x = 0; x < img1.width; x++) 
    {
      color c1 = img1.get(x, y);  // Get color from pixel at (x, y) from img1
      color c2 = img2.get(x, y);  // Get color from pixel at (x, y) from img2
      
      // Ensure the values for red, green, blue is between 0 - 255
      red = constrain(green(c1) + green(c2), 0, 255);
      green = constrain(green(c1) + green(c2), 0, 255);
      blue = constrain(blue(c1) + blue(c2), 0, 255);
      
      // Set c3 to calculated red, green, and blue values
      color c3 = color(red, green, blue);
      img3.set(x, y, c3);  // img3 <-- img1 + img2
    }
  }
  
  return img3;
}
  

// Function to check for pressed keys
void keyPressed() 
{ 
  //Set imgIndex according to key pressed (0, 1, 2, or 3)
  if (key == '0')
  {
    imgIndex = 0;
  }
  else if (key == '1')
  {
    imgIndex = 1;
  }
  else if (key == '2')
  {
    imgIndex = 2;
  }
  else if (key == '3')
  {
    imgIndex = 3;
  }
}
