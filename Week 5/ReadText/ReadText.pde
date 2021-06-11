String[] words;
String delimiters = " ,-;.!?";
String fName = "gb.txt";

void setup()
{
  String[] lines;
  size(400, 400);
  lines =loadStrings(fName);
  
  //for (int i = 0; i < lines.length; i++)
  //{
  //  println(lines[i]);
  //}
  
  String text = join(lines, "");
  //println(text);
  
  words = splitTokens(text, delimiters);
  for (int i = 0; i < words.length; i++)
  {
    println(words[i]);
  }
}


void draw()
{
  background(255);
}
