String[] lines;
void setup() {
  size(400, 400);
  lines = loadStrings("list.txt");
  println("There are " + lines.length + " lines");
}

void draw() {
  background(220);                                                               // Clear the background

  // Display the lines on the canvas with black text color
  textSize(16);
  textAlign(LEFT);
  fill(0);  // Set text color to black

  for (int i = 0; i < lines.length; i++) {
    text(lines[i], 20, 40 + i * 20);                                           // Adjust position as needed
  }
}
