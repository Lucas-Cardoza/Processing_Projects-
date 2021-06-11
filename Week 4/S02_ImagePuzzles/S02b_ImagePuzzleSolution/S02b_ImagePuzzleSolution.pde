/* Pixels in landmark2.png have been modified as follows:
   Red values have been set to random values
   The image is carried in the green and blue values but
   they have been divided by 20
   Set the red channel to 0; multiply green & blue by 20
   Set hotkeys as follows:
   '1' displays the noise image; '2' displays the fixed image
*/
PImage[] img = new PImage[2];
int currentx = 0;  //Index of image to display
String fname = "landmark2.png";

void setup() {
  size(400, 400);
  surface.setResizable(true);
  img[0] = loadImage(fname);
  surface.setSize(img[0].width, img[0].height);
  img[1] = fixImg(img[0]);
}
void draw() {
  image(img[currentx], 0, 0);
}
PImage fixImg(PImage img) {
  PImage newImg = createImage(img.width, img.height, RGB);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      float g = green(c) * 20, b = blue(c) * 20;
      newImg.set(x, y, color(0, g, b));
    }
  }
  return newImg;
}
void keyReleased() {
  if (key == '1') currentx = 0;
  else if (key == '2') currentx = 1;
}
  
