/* 
  Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 11a: Intro to Audio Programming in Processing
   Instructor: Lloyd Smith
   Due Date: Sunday, April 25, 2021, 11:59 PM

   This program reads song files and plays them while displaying waveform and spectrum.
   The program starts by playing playfile[0]; the user can select the song to play by
   pressing a numeric key. Pressing space bar pauses play.
*/


import processing.sound.*;


String[] playfile = {"Santana - Oye Como Va.MP3", "Beach Boys - Good Vibrations.mp3"};
int nsongs = playfile.length;
int currentSong = 0;
SoundFile[] sndFile = new SoundFile[nsongs];
FFT fft;
int nbands = 1024;  //Number of spectral bands for FFT
float[] spectrum = new float[nbands];  //Array to hold spectral values
boolean paused = false;  //Used to toggle play/pause
LowPass lpFilter;
HighPass hpFilter;
float lpFreq = 500.0;   // Low pass cut off frequency
float hpFreq = 3000.0;  // Hight pass cut off frequency
boolean lp_on = false, hp_on = false, rate_on = false;  // Boolean values for features
float rate = 1;  // Original rate of audio play back is 1, the range is .5 - 2.0.


void setup()
{
  size(1500, 500);
  surface.setResizable(true);
  for (int i = 0; i < nsongs; i++) 
  {
    sndFile[i] = new SoundFile(this, playfile[i]);
  }
  sndFile[currentSong].play();
  fft = new FFT(this, nbands);
  fft.input(sndFile[currentSong]);
  
  lpFilter = new LowPass(this);
  hpFilter = new HighPass(this);
}


void draw() 
{
  int lineLen, thickness = 5, space = thickness + 1;
  background(0);
  strokeWeight(thickness);
  stroke(255, 0, 0);
  float maxVal = 0.0, minVal = 100000000.0;
  fft.analyze(spectrum);
  
  for (int i = 0; i < nbands; i++) 
  {
    if (spectrum[i] > maxVal) 
    {
      maxVal = spectrum[i];
    }
    else if (spectrum[i] < minVal) 
    {
      minVal = spectrum[i];
    }
  }
  
  for (int i = 0; i < nbands; i++) 
  {
    lineLen = (int) map(spectrum[i], 0, maxVal, 0, 3*height/4);
    line(space*i, height, space*i, height-lineLen);
  }
}


void keyPressed() 
{
  if (key >= '0' && key <= '9') 
  {
    int k = Character.getNumericValue(key);
    
    if (k < nsongs) 
    {
      sndFile[currentSong].pause();
      currentSong = k;
      sndFile[currentSong].play();
      fft.input(sndFile[currentSong]);
      println("Current song:", k);
    }
  }
  else if (key == ' ') 
  {
    if (paused) 
    {
      paused = false;
      sndFile[currentSong].play();
    } 
    else 
    {  //Pause any songs that are playing
      paused = true;
      sndFile[currentSong].pause();
    }
  }
  else if (key == 'l' || key == 'L')
  {
    if (lp_on)
    {
      println("Stopping low pass filter");
      lp_on = false;
      lpFilter.stop();
    }
    else
    {
      if (hp_on)
      {
        println("Stopping high pass filter");
        hp_on = false;
        hpFilter.stop();
      }
      
      println("Starting low pass filter");
      lp_on = true;
      lpFilter.process(sndFile[currentSong], lpFreq);
    }
  }
  else if (key == 'h' || key == 'H')
  {
    if (hp_on)
    {
      println("Stopping high pass filter");
      hp_on = false;
      hpFilter.stop();
    }
    else
    {
      if (lp_on)
      {
        println("Stopping low pass filter");
        lp_on = false;
        lpFilter.stop();
      }
      
      println("Starting high pass filter");
      hp_on = true;
      hpFilter.process(sndFile[currentSong], hpFreq);
    }
  }
  else if (key == 'r' || key == 'R')
  {
    if (rate_on)
    {
      println("Stop playback rate change");
      rate_on = false;
      sndFile[currentSong].rate(1);  // Change rate of playback back to original rate
    }
    else
    {
      println("Start playback rate change");
      sndFile[currentSong].rate(rate);  // Change playback to last rate value
      println("Rate:", rate);
      rate_on = true;    
    }
  }
  else if (key == CODED)
  {
    if (rate_on == true)
    {  
      if (keyCode == UP && rate < 2)  // Increase rate of playback
      {
        rate += 0.1;
        sndFile[currentSong].rate(rate);
        println("Rate:", rate);
      }
      else if (keyCode == DOWN && rate > 0.5)  // Decrease rate of playback
      {
        rate -= 0.1;
        sndFile[currentSong].rate(rate);
        println("Rate:", rate);
      }
    }
  }
}
