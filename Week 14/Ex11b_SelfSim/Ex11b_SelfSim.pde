/*
   Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 11b: Visualizing the Structure of Music
   Instructor: Lloyd Smith
   Due Date: Sunday, April 25, 2021, 11:59 PM

   Calculates and displays a self-similarity matrix of a song.
*/


import ddf.minim.*;
import ddf.minim.analysis.*;


int fftSize = 4096;  //No. of samples for fft
Minim minim;
float[][] spectra;
FFT fft;
float maxVal;

String[] songfiles = {"Tokens - The Lion Sleeps Tonight.mp3"};
String fname = songfiles[0]; //File to analyze
PImage simImage; //Used to display similarity


void setup() 
{
  size(200, 200);
  surface.setResizable(true);
  surface.setSize(displayHeight-100, displayHeight-100);  //use displayHeight for square window
  minim = new Minim(this);

  //Load audio data into memory, mix channels, and analyze
  analyzeUsingAudioSample();
  println(spectra.length);
  simImage = createImage(spectra.length, spectra.length, ARGB);
  calcSelfSimilarity();
  simImage.resize(width, height);
}


void draw() 
{
  image(simImage, 0, 0);
}


void analyzeUsingAudioSample()
{
   AudioSample song = minim.loadSample(fname, 4096);
  // get the left channel of the audio as a float array
  // getChannel is defined in the interface BuffereAudio, 
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
  // the second dimension if fftSize/2 because the spectrum size is always half the number of samples analyzed.
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
      for (int i = chunkSize; i < fftSamples.length; i++) fftSamples[i] = 0.0;
    }
    
    // now analyze this buffer
    fft.forward( fftSamples );
    // and copy the resulting spectrum into our spectra array
    float total = 0;
    
    for (int i = 0; i < fft.avgSize(); i++) 
    {
      spectra[chunkIdx][i] = fft.getAvg(i);
      total += spectra[chunkIdx][i];
    }
    if (total > maxVal) maxVal = total;  //Largest total spectral energy; used to scale display
  }
  
  println("max:", maxVal);
  song.close(); 
}


void calcSelfSimilarity() 
{
  //Your code here to calculate the self-similarity image
  int i, j, k, x, y;
  float diff, val;
  color c;
  
  for (i = 0, y = 0; i < spectra.length; i++, y++)
  {
    for (j = i, x = y; j < spectra.length; j++, x++)
    {
      diff = 0;
      
      for (k = 0; k < fft.avgSize(); k++)
      {
        diff += abs(spectra[i][k] - spectra[j][k]);
      }
      
      val = map(diff, 0, maxVal, 0, 255);
      c = color(val, val, val);
      simImage.set(x, y, c);
      simImage.set(y, x, c);
    }  // End for j loop
  }  // End for i loop
}


void stop()
{
  minim.stop();
  
  super.stop();
}
