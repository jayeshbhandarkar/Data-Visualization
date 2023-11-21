void setup() {
  size(400, 400);
}

void draw() {
  background(220);
  stroke(0);                                                  // Set stroke color to black
  strokeWeight(4);                                           // Default
  line(80, 80, 320, 80); 
  strokeWeight(16);                                          // Thicker
  line(80, 160, 320, 160);
  strokeWeight(40); // Beastly
  line(80, 280, 320, 280);
}
