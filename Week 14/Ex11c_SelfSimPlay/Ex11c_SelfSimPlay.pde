/*
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 11c: Visualizing the Structure of Music 2: Adding Sound and Time
   Instructor: Lloyd Smith
   Due Date: Sunday, April 25, 2021, 11:59 PM

  Calculates and displays a self-similarity matrix of a song.
  This one plays the song and shows a red line illustrating passage 
  of time. This version of selfSimPlay syncs song play by tying 
  percentage of audio file played to pixel position.
*/


import ddf.minim.*;
import ddf.minim.analysis.*;


int fftSize = 4096;  //No. of samples for fft
Minim minim;
float[][] spectra;
FFT fft;
float maxVal;
int frameNum = 0; //frame number during song play
float pctPlayed, songLength;

String[] songfiles = {"Tokens - The Lion Sleeps Tonight.mp3"};
String fname = songfiles[0]; //File to analyze
PImage simImage;
AudioPlayer songPlayer;


void setup()
{
  fullScreen();
  surface.setResizable(true);
  surface.setSize(height, height);
  minim = new Minim(this);

  //Load audio data into memory, mix channels, and analyze
  analyzeUsingAudioSample();
  println(spectra.length);
  simImage = createImage(spectra.length, spectra.length, ARGB);
  calcSelfSimilarity();
  simImage.resize(width, height);
  //TODO: create songPlayer using minim.loadFile
  songPlayer = minim.loadFile(fname, fftSize);
  //TODO: get songLength using a songPlayer method
  songLength = (float)songPlayer.length();
  //TODO: set line color and weight (optional)
  stroke(255, 0, 0);  // Red line to show song's progress
  strokeWeight(5);
  noFill();
  //TODO: start the song playing
  songPlayer.play();
}


void draw() 
{
  image(simImage, 0, 0);
  /* TODO: calculate percentage of song played; use it
     to determine frameNum; draw the line or otherwise
     show passage of time synchronized to song play
  */
  pctPlayed = songPlayer.position() / songLength;
  frameNum = int(pctPlayed * width);
  line(0, 0, frameNum, frameNum);
  rect(0, 0, frameNum, frameNum);
}


void analyzeUsingAudioSample()
{
   AudioSample song = minim.loadSample(fname, fftSize);
  // get the left channel of the audio as a float array
  // getChannel is defined in the interface BufferedAudio, 
  // which also defines two constants to use as an argument
  // BufferedAudio.LEFT and BufferedAudio.RIGHT
  float[] leftChannel = song.getChannel(AudioSample.LEFT);
  float[] rightChannel = song.getChannel(AudioSample.RIGHT);
  
  for (int i = 0; i < leftChannel.length; i++) 
  {
    leftChannel[i] = (leftChannel[i] + rightChannel[i])/2;
  }
  
  // then we create an array we'll copy sample data into for the FFT object
  // this should be as large as you want your FFT to be. generally speaking, 1024 is probably fine.
  float[] fftSamples = new float[fftSize];
  fft = new FFT( fftSize, song.sampleRate() );
  fft.logAverages(25, 3);  //3 bands per octave, starting at 25Hz; results in 30 bands @ 44100 Hz sampling
  // now we'll analyze the samples in chunks
  int totalChunks = (leftChannel.length / fftSize) + 1;
  // allocate a 2-dimentional array that will hold all of the spectrum data for all of the chunks.
  // the second dimension is fftSize/2 because the spectrum size is always half the number of samples analyzed.
  spectra = new float[totalChunks][fft.avgSize()]; //Use fftsize/2 if not averaging
 
  for(int chunkIdx = 0; chunkIdx < totalChunks; ++chunkIdx)
  {
    int chunkStartIndex = chunkIdx * fftSize;
    // the chunk size will always be fftSize, except for the 
    // last chunk, which will be however many samples are left in source
    int chunkSize = min( leftChannel.length - chunkStartIndex, fftSize );
    // copy first chunk into our analysis array
    arraycopy( leftChannel, // source of the copy
               chunkStartIndex, // index to start in the source
               fftSamples, // destination of the copy
               0, // index to copy to
               chunkSize // how many samples to copy
              );
      
    // if the chunk was smaller than the fftSize, we need to pad the analysis buffer with zeroes        
    if ( chunkSize < fftSize )
    {
      for (int i = chunkSize; i < fftSamples.length; i++) 
      {
        fftSamples[i] = 0.0;
      }
    }
    
    // now analyze this buffer
    fft.forward( fftSamples );
    // and copy the resulting spectrum into our spectra array
    float total = 0;
    
    for (int i = 0; i < fft.avgSize(); i++) 
    {  //Original was 512; should be fftsize/2 if not averaging
      spectra[chunkIdx][i] = fft.getAvg(i);
      total += spectra[chunkIdx][i];
    }
    
    if (total > maxVal) 
    {
      maxVal = total; //Largest total spectral energy; used to scale display
    }
  }
  
  println("max: " + maxVal);
  song.close(); 
}


void calcSelfSimilarity()
{
  int i, j, k;
  float diff, val;
  color c;
  
  for (i = 0; i < spectra.length; i++) 
  {
    for (j = i; j < spectra.length; j++) 
    {
      diff = 0;
      
      for (k = 0; k < fft.avgSize(); k++) 
      {
        diff += abs(spectra[i][k] - spectra[j][k]);
      } //end for k
      
      val = map(diff, 0, maxVal, 0, 255);
      c = color(val, val, val);
      simImage.set(i, j, c);
      simImage.set(j, i, c);
    } //end for j
  } //end for i
}


void stop()
{
  minim.stop();
  
  super.stop();
}
