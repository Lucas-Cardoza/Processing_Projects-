/* SlideShow
   Complete ths program to display all the images in the data folder. The program
   automatically discovers all the files in the data folder (note how that is done!).
   Add the following:
   Create the img array so it's the same length as flist
   For each File in flist, load the image into the img array
     Use flist[i].getName(), assuming your loop index is i
   Set currIndex to 0
   Set the surface size to the size of image 0
   Initially, select the image to display using keyReleased()
     I suggest you use Integer.parseInt() to convert key to a number
     -- but you should avoid null pointer exceptions by considering img.length
     Don't forget to resize the canvas according to the current image
   Then create a slide show by changing the image at some time interval
     See the Processing reference regarding time
     When you reach the last image, go back to img[0]
   For an additional challenge, use the mouse position to determine the time interval
   For another challenge, use arrow keys up/down to modify brightness of the displayed image
     The easiest way is probably to use tint()
*/


File[] flist;  //Holds files in data directory
PImage[] img;
int currIndex = 0;
int startTime = 0;
int displayInterval = 1000; // Controls image transitions in miliseconds.


void setup() 
{
  size(400, 400);
  surface.setResizable(true);
  //dataFile("") is the data directory of the current sketch
  flist = dataFile("").listFiles();  //Java method for getting an array of Files
  //printArray(flist);  //Uncomment this to see the file anmes
  //Create img array w/length the number of files in data
  
  //Load images into img array
  img = new PImage[flist.length];
  for (int i = 0; i < flist.length; i++)
  {
    img[i] = loadImage(flist[i].getName());
  }
  
  //Set currIndex to 0 and set size to size of img[0]
  currIndex = 0;
  surface.setSize(img[0].width, img[0].height);
  
  // Start timer
  startTime = millis();
}


void draw() 
{
  image(img[currIndex], 0, 0);
  
    if (mousePressed)
    {
      if (mouseX < (img[currIndex].width / 2) && displayInterval > 500)
      {
        displayInterval -= 20;
      }
      else if (mouseX > (img[currIndex].width / 2) && displayInterval < 2500)
      {
        displayInterval += 20;
      }
    }
  
  if (millis() - startTime >= displayInterval)
  {
    currIndex = (currIndex + 1) % img.length;
    surface.setSize(img[currIndex].width, img[currIndex].height);
    println(displayInterval);
    startTime = millis();  // Restart timer
  }
}


void keyReleased() 
{
  if (key >= '0' && key <= '7')
  {
    int i = Integer.parseInt(str(key));
    
    if (i < img.length)
    {
      currIndex = i;
      surface.setSize(img[currIndex].width, img[currIndex].height);
    }
  }
}
  
