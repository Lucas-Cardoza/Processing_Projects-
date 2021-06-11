/* Pixels have been modified as follows:
   Green and blue channels have been set to random
   values
   The red values carry the image; they have been
   divided by 10
   Set green and blue channels to 0
   Multiply red values by 10
   Set hotkeys as follows:
   '1' displays the noise image
   '2' displays the hidden image; (you could display it in grayscale)
*/

PImage img, fixedImg, currentImg;
String fname = "landmark1.png";

void setup() {
  size(400, 400);
  surface.setResizable(true);
  img = loadImage(fname);
  surface.setSize(img.width, img.height);
  fixedImg = fixImage(img);
  currentImg = img;
}
void draw() {
  image(currentImg, 0, 0);
}
PImage fixImage(PImage img) {
  PImage newImg = img.get();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      float r = red(c) * 10;
      newImg.set(x, y, color(r, 0, 0));
    }
  }
  return newImg;
}
void keyReleased() {
  if (key == '1') {
    currentImg = img;
  } else if (key == '2') {
    currentImg = fixedImg;
  }
}
