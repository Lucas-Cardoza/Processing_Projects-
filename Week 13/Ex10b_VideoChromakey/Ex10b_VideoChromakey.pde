/* 
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 10b: Video Chromakey
   Instructor: Lloyd Smith
   Due Date: Sunday, April 18, 2021

   This program plays a green screen movie and replaces its background
   'g': toggle whether to replace green; 'p': toggle pause; 'r': reverse play
*/


import processing.video.*;


String vidname = "APACHE HELICOPTER GREEN SCREEN FOOTAGE HD.mp4"; //640 x 360
String bgname = "moon-surface.jpg";
PImage bg, displayImg;  //background image and display image w/background inserted
Movie m;
boolean replaceGreen = false, paused = false;
float playSpeed = 1.0;


void setup() 
{
  size(640, 360);
  displayImg = createImage(640, 360, RGB);
  bg = loadImage(bgname);
  bg.resize(640, 360);  //Make bg image same size as movie frames
  frameRate(30);
  m = new Movie(this, vidname);
  m.play();
}


void draw() 
{
  background(0);

  //if replaceGreen is true, show the displayImage
  //otherwise, show the movie frame
  if (replaceGreen)
  {
    image(displayImg, 0, 0);
  }
  else
  {
    image(m, 0, 0);
  }
}


void movieEvent(Movie m) 
{
  m.read();
  //println(m.width + "; " + m.height);
  chromakey(m, bg, displayImg);
}


void chromakey(Movie fg, PImage bg, PImage target) 
{
  //target <-- fg + bg (bg replaces green in fg)
  color c;
  float r, g, b;
  
  for (int y = 0; y < fg.height; y++)
  {
    for (int x = 0; x < fg.width; x++)
    {
      c = fg.get(x, y);
      r = red(c);
      g = green(c);
      b = blue(c);
      
      if ((r + b) < g)
      {
        c = bg.get(x, y);
      }
      
      target.set(x, y, c);
    }
  }
}


void keyReleased() 
{
  if (key == 'g') 
  {
    //toggle replaceGreen
    if (replaceGreen)
    {
      replaceGreen = false;
    }
    else
    {
      replaceGreen = true;
    }
  } 
  else if (key == 'p') 
  {
    //toggle pause
    if (paused)
    {
      paused = false;
      m.play();
    }
    else
    {
      paused = true;
      m.pause();
    }
  } 
  else if (key == 'r') 
  { 
    //reverse play
    playSpeed *= -1;
    m.speed(playSpeed);
  }
}
