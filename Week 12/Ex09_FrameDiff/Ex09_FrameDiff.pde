/* 
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise 9: Show Frame to Frame Differences in Videos
   Instructor: Lloyd Smith
   Due Date: Sunday, April 11, 2021

   This program shows a video and, optionally, frame differences
   'd': toggle difference frames; 'p': toggle pause; 'r': restart
   NOTE: Import the Video library if you haven't done so before.
   For documentation follow the Libraries link at Processing.org.
*/


import processing.video.*;

//String fname = "Notre Dame at Michigan - Football Highlights.mp4";  //640 x 360
String fname = "The Hobbit Trailer Pop-Up - Lord of the Rings Movie.mp4"; //640 x 360
//String fname = "Kane Waselenchuk vs Alex Landa-Ektelon Nationals Racquetball.mp4"; //640 x 360
//String fname = "dumbo-trailer-2_h480p.mov";  //848 x 448
//String fname = "shazam-trailer-2_h480p.mov";   //848 x 360
PImage old_img, diff_img;
Movie m;
boolean show_diff = false, paused = false;


void setup() 
{
  size(640, 360);  //Set this to the size of the chosen film clip
  old_img = createImage(width, height, RGB);
  diff_img = createImage(width, height, RGB);
  frameRate(30);
  m = new Movie(this, fname);
  
  //Your code here to start the movie playing
  m.play();
}


void draw() 
{
  //Your code here to display the current frame or diff_img
  //background(0);  // Not having this did not seem to make a difference 
  if (show_diff)
  {
    image(diff_img, 0, 0, width, height);
  }
  else
  {
    image(m, 0, 0, width, height);
  }
}


void movieEvent(Movie m) 
{
  //Your code here to read the new frame
  m.read();
  
  //The following tells you the frame size; not needed for the given videos
  //println(m.width + "; " + m.height);
  if (show_diff)
  {
    diff(m, old_img);
  }
  
  old_img = m.get();  //Copy the new frame into old_img
}


void diff(PImage img1, PImage img2)
{
  //Your code here to difference img1 and img2 and put the difference into
  //the global diff_img. For each pixel, difference the R, G, and B channels
  //separately, then create a new color from those differences and set the 
  //corresponding pixel in diff_img to the new color.
  for (int y = 0; y < img1.height; y++)
  {
    for (int x = 0; x < img1.width; x++)
    {
      color pixel1 = img1.get(x, y);
      color pixel2 = img2.get(x, y);
      
      float r = abs(red(pixel2) - red(pixel1));
      float g = abs(green(pixel2) - green(pixel1));
      float b = abs(blue(pixel2) - blue(pixel1));
      
      diff_img.set(x, y, color(r, g, b));
    }
  }
}


void keyReleased() 
{
  if (key == 'd') 
  {  
    //toggle show difference frames
    if (show_diff)
    {
      show_diff = false;
    }
    else 
    {
      show_diff = true;
    }
  }
  else if (key == 'r')
  {  
    //restart
    //Your code here to stop the video then play it again
    m.stop();
    m.play();
  } 
  else if (key == 'p') 
  {
    if (paused) 
    {
      //Your code here to start the video playing again
      paused = false;
      m.play();
    } 
    else 
    {
      //Your code here to pause the video
      paused = true;
       m.pause();
    }
  }
}
