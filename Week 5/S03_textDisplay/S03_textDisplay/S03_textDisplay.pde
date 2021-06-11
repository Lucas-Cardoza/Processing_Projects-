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
int xPos = 0, yPos = 0;


void setup() 
{
  size(900, 500);
  //Set up your font here
  f = createFont("Times New Roman", 48, true);
  textFont(f);
  xPos = width / 2;  // Set x baseline position for text 
  yPos = height / 2;  // Set y baseline position for text
  stroke(0, 255, 0);  // Set stroke to green
  textAlign(RIGHT);
}


void draw() 
{
  //Control your display here
  background(0);  // Set background to black
  textFont(f);
  text(s, xPos, yPos);  // Display text
  fill(0, 0, 255);  // Set Blue fill for text
  
  // Set up rectangle 
  float rectX = xPos - textWidth(s);
  float rectY = yPos - textAscent();
  noFill();
  rect(rectX, rectY, textWidth(s) * 2, textAscent());
  
  if (mousePressed)
  {
    fill(255, 0, 0);  // Set red fill for text
    String mousePos = str(mouseX) + ' ' + str(mouseY);
    textSize(20);
    text(mousePos, mouseX, mouseY);
  }
  

}
