/* 
  Student: Lucas Cardoza
   Class: CSC 545: Computer Speech, Music, and Images, Spring 2021
   Exercise No. 10c: Learn to Read srt Subtitle Files in Processing
   Instructor: Lloyd Smith
   Due Date: Sunday, April 18, 2021

   Prints subtitles from an srt file to the console
*/


import processing.video.*;


String srtName = "Ready-Player-One-Trailer-HD-English-French-Subtitles.srt";
SubtitlePlayer sp;

void setup() 
{
  size(640, 350);
  sp = new SubtitlePlayer(srtName);
}


void draw() {}
