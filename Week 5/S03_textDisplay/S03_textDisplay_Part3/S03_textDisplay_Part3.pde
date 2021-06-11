/* Show text in display window
   Use the Processing textFont documentation to do the following operations:
   1. Create a 48 point font in setup() and store it in f (I suggest Arial)
      Use createFont() and textFont()
   2. Display "Hello world!" at position 75, 75
   3. Change the program so "Hello World!" is in color (use fill() to set text color)
   4. If the mouse is pressed, display the mouse x, y position in a different color
   5. Draw a red box around "Hello World!"
      a. Figure out how the text position (75, 75) relates to its y position
      b. Use rect(); make the box tight by using textWidth()
   6. Now move the text to the center of the screen; keep the box around it
      Use textAlign() to get the text centered
   7. Now make the box twice as wide as the text
      Keep the text in the screen center and centered horizontally in the box
   8. Move the text to the left side of the box (use textAlign())
   
   You might want to save your program and do the following in a new program
   9. Load an image and set the canvas size to the size of the image
  10. Somewhere in the top left corner (50, 50?), display the red, green, and blue
      values of the pixel under the mouse.
*/


PFont f;  //This will hold the font
String s = "Hello World!";
String[] fNames = {"AmboiseCastle.jpg", "BlarneyCastle.jpg"};
int xPos = 0, yPos = 0;
PImage img;


void setup() 
{
  size(900, 500);
  surface.setResizable(true);
  img = loadImage(fNames[1]);
  surface.setSize(img.width, img.height);
  //Set up your font here
  f = createFont("Times New Roman", 48, true);
  textFont(f);
  xPos = 75;  // Set x baseline position for text 
  yPos = 75;  // Set y baseline position for text
  textAlign(LEFT);
}


void draw() 
{
  //Control your display here
  background(0);  // Set background to black
  image(img, 0, 0);
  
  if (mousePressed)
  {
    color c = get(mouseX, mouseY);
    int red = int(red(c)), green = int(green(c)), blue = int(blue(c));
    String pixelStr = str(red) + ' ' + str(green) + ' ' +str(blue);
    fill(255, 0, 0);
    textSize(20);
    text(pixelStr, mouseX, mouseY);
  }
}
