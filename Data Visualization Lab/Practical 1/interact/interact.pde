// Drag (click and hold) your mouse across the 
// image to change the value of the rectangle

int value = 0;
void setup()
{
 size(400,400); 
}
void draw() {
  fill(value);
  rect(100,100, 150, 150);
}

void mouseDragged() 
{
  value = value + 5;
  if (value > 255) {
    value = 0;
  }
}
