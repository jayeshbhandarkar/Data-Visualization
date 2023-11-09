String men = "Chernenko,Andropov,Brezhnev";
String[] list = split(men, ',');

void setup() {
  for (int i = 0; i < list.length; i++) {
    println("list[" + i + "] is now " + list[i]);
  }
}
