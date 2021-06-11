class SubtitlePlayer 
{
  String arrow = "-->";  //Arrow separating start time from end time
  String tokens = ":,";
  String[] lines;
  
  SubtitlePlayer(String fname) 
  {
    //Load the file into the lines array
    lines = loadStrings(fname);
    int i = 0;
    
    while (i < lines.length) 
    {
      //If the line contains an arrow, you have a new subtitle - get it into a StringList
      if (lines[i].contains(arrow))
      {
        StringList subtitle = new StringList();
        subtitle.append(lines[i++]);
        
        while (lines[i].length() > 0)
        {
          subtitle.append(lines[i++]);
        }
        
        printSubtitle(subtitle);
        println(); //<>//
      }

      i++;  //Skip line
    }
  }
  
  
  int parseTime(String[] timeArr) 
  {
    //Returns time in ms; time array has format hours, minutes, seconds, milliseconds
    int tHour = parseInt(timeArr[0].trim()) * 60 * 60 * 1000;  // Hours * minutes * seconds * milsec
    int tMIn = parseInt(timeArr[1].trim()) * 60 * 1000;  // Minutes * seconds * milsec
    int tSec = parseInt(timeArr[2].trim()) * 1000;  // Seconds * milsec
    int tMilsec = parseInt(timeArr[3].trim());  // Milsec
    int t = tHour + tMIn + tSec + tMilsec;  // Total tine in milsec

    return t;
  }
  
  
  void printSubtitle(StringList subtitle) 
  {
    //Get the time line - the first element in subtitle
    String timeLine = subtitle.get(0);
    
    //Find the position of the arrow (-1 if not found - but it should be there)
    int arrowPos = timeLine.indexOf(arrow);
    
    //Get the string to the left of the arrow - that's the start time
    String t1String = timeLine.substring(0, arrowPos);  // This gets the timeLine up to the arrow char
    
    //Get the string to the right of the arrow - that's the end time
    String t2String = timeLine.substring(arrowPos + arrow.length() + 1);   // This will get the time after the arrow char
    
    //Split the start time on tokens, creating an array of strings
    String[] startTimeArr = splitTokens(t1String, tokens);  // Split the start time values up
    
    //Split the end time on tokens, creating another array of strings
    String[] endTimeArr = splitTokens(t2String, tokens);  // Split the end time values up
    
    int t1 = parseTime(startTimeArr);  //Start time
    int t2 = parseTime(endTimeArr);    //End time

    println("Start time:", t1, "End time:", t2);
    
    //Print the text lines in the subtitle StringList
    // Start index at 1 to skip time in subtitle list
    for (int i = 1; i < subtitle.size(); i++)  
    {
      println(subtitle.get(i));
    }
  }
}
