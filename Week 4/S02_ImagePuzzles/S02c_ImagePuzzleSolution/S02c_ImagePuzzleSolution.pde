/* Pixels have been modified as follows:
   1. Red and green values have been set to random values
   2. Blue values greater than 15 are noise
   3. The image is carried in the blue values that are
      less than 16
   4. Set blue values that are 16 or greater to 0
   5. Multiply blue values that are less than 16 by 16
   6. The image is better seen in the red channel - move
      the blue values to the red channel
   7. Set hotkeys as follows:
      '1' displays the noise image
      '2' displays the fixed imageS
*/
PImage[] img = new PImage[2];
int currentx = 0;  //Index of image to display
String fname = "landmark3.png";

void setup() {
   size(400, 400);
  surface.setResizable(true);
  img[0] = loadImage(fname);
  surface.setSize(img[0].width, img[0].height);
  img[1] = fixImg2(img[0]);
}
void draw() {
  image(img[currentx], 0, 0);
}
PImage fixImg(PImage img) {
  PImage newImg = createImage(img.width, img.height, RGB);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      float b = blue(c);
      if (b <= 15) b *= 16;
      else b = 0;
      newImg.set(x, y, color(b, 0, 0));
    }
  }
  return newImg;
}
PImage fixImg2(PImage img) {
  //This function works by shifting bits & masking
  int mask = 255;  //Lowest 8 bits are all ones
  int bshift = 0;  //No. bits to shift to get blue in lowest 8 bits
  int redshift = 16; //No. bits to shift left to get blue into red channel
  int ashift = 24; //No. bits to shift mask left to preserve alpha
  PImage newImg = createImage(img.width, img.height, RGB);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      int a = c & (mask << ashift); //Get alpha channel bits
      int b = (c >> bshift) & mask;
      if (b <= 15) b <<= 4; //Multiply by 16
      else b = 0;
      b <<= redshift;  //Get blue bits into red channel
      c = c & 0;  //Clear all bits
      c = c | b | a;  //Put in shifted blue bits; restore alpha bits
      newImg.set(x, y, c);
    }
  }
  return newImg;
}
void keyReleased() {
  if (key == '1') currentx = 0;
  else if (key == '2') currentx = 1;
}