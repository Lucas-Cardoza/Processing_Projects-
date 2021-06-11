/* alphaTest - experiment with alpha blending over a background image.
   Set one of the castles as the background. Display another castle over
   it, using tint() to set an alpha (transparency) value. Use 128 for your
   initial alpha value. Once you have that working, map mouseX or mouseY to
   the range 0 - 255 and use that as your alpha value -  vary the trasparency
   by mouse position.
   Do you think it's possible to overlay more than two images using transparency?
   Try it!
   Now modify your program so it gradually transitions from one image to the other
   over time. Look at the Processing reference to see how to use time.
   If you have time, experiment with other uses of tint().
*/


PImage img, img2, img3;
String[] imgFiles = {"hot_air.jpg", "Lizard.jpg", "AmboiseCastle.jpg", "BlarneyCastle.jpg",
                     "BodiamCastle.jpg", "EdinburghCastle2.jpg"};

void setup() 
{
  size(400, 400);
  //Make the canvas resizable
  surface.setResizable(true);
  
  //Load a castle into img
  img = loadImage(imgFiles[2]);
  
  //Set the canvas to the size of img
  surface.setSize(img.width, img.height);
  
  //Load another castle into img2
  img2 =loadImage(imgFiles[3]);
}


void draw() 
{
  //Set the background to img (see background() in the Processing reference)
  background(img);
  
  if (mousePressed)
  {
    //Set float val to a value to use for alpha
    float val = map(mouseY, 0, height, 0, 255);
    
    //Use tint() to set the alpha value
    tint(255, val);
  }
  
  //Display img2
  image(img2, 0, 0);
}
