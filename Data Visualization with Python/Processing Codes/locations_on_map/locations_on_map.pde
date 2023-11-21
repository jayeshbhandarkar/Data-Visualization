PImage mapImage;
Table locationTable;
int rowCount;

Table dataTable;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
void setup( ) {
size(640, 400);
mapImage = loadImage("map.png");
locationTable = new Table("locations.tsv");
rowCount = locationTable.getRowCount( );
// Read the data table.
dataTable = new Table("random.tsv");
// Find the minimum and maximum values.
for (int row = 0; row < rowCount; row++) {
float value = dataTable.getFloat(row, 1);
if (value > dataMax) {
dataMax = value;
}
if (value < dataMin) {
dataMin = value;
}
}
}

void draw( ) {
background(255);
image(mapImage, 0, 0);
smooth( );
fill(192, 0, 0);
noStroke( );
for (int row = 0; row < rowCount; row++) {
String abbrev = dataTable.getRowName(row);
float x = locationTable.getFloat(abbrev, 1);
float y = locationTable.getFloat(abbrev, 2);
drawData(x, y, abbrev);
}
}
// Map the size of the ellipse to the data value
void drawData(float x, float y, String abbrev) {
// Get data value for state
float value = dataTable.getFloat(abbrev, 1);
// Re-map the value to a number between 2 and 40
float mapped = map(value, dataMin, dataMax, 2, 40);
// Draw an ellipse for this item
ellipse(x, y, mapped, mapped);
}

class Table {
  String[][] data;
  int rowCount;
   
  Table() {
    data = new String[10][10];
  }
  
  Table(String filename) {
    String[] rows = loadStrings(filename);
    data = new String[rows.length][];
    
    for (int i = 0; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }
      
      // split the row on the tabs
      String[] pieces = split(rows[i], TAB);
      // copy to the table array
      data[rowCount] = pieces;
      rowCount++;
      
      // this could be done in one fell swoop via:
      //data[rowCount++] = split(rows[i], TAB);
    }
    // resize the 'data' array as necessary
    data = (String[][]) subset(data, 0, rowCount);
  }

  int getRowCount() {
    return rowCount;
  }
    
  // find a row by its name, returns -1 if no row found
  int getRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {
      if (data[i][0].equals(name)) {
        return i;
      }
    }
    println("No row named '" + name + "' was found");
    return -1;
  }
   
  String getRowName(int row) {
    return getString(row, 0);
  }

  String getString(int rowIndex, int column) {
    return data[rowIndex][column];
  }
  
  String getString(String rowName, int column) {
    return getString(getRowIndex(rowName), column);
  }
 
  int getInt(String rowName, int column) {
    return parseInt(getString(rowName, column));
  }
  
  int getInt(int rowIndex, int column) {
    return parseInt(getString(rowIndex, column));
  }
  
  float getFloat(String rowName, int column) {
    return parseFloat(getString(rowName, column));
  }
 
  float getFloat(int rowIndex, int column) {
    return parseFloat(getString(rowIndex, column));
  }
    
  void setRowName(int row, String what) {
    data[row][0] = what;
  }

  void setString(int rowIndex, int column, String what) {
    data[rowIndex][column] = what;
  }
  
  void setString(String rowName, int column, String what) {
    int rowIndex = getRowIndex(rowName);
    data[rowIndex][column] = what;
  }
  
  void setInt(int rowIndex, int column, int what) {
    data[rowIndex][column] = str(what);
  }
  
  void setInt(String rowName, int column, int what) {
    int rowIndex = getRowIndex(rowName);
    data[rowIndex][column] = str(what);
  }

  void setFloat(int rowIndex, int column, float what) {
    data[rowIndex][column] = str(what);
  }

  void setFloat(String rowName, int column, float what) {
    int rowIndex = getRowIndex(rowName);
    data[rowIndex][column] = str(what);
  }
  
  // Write this table as a TSV file
  void write(PrintWriter writer) {
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < data[i].length; j++) {
        if (j != 0) {
          writer.print(TAB);
        }
        if (data[i][j] != null) {
          writer.print(data[i][j]);
        }
      }
      writer.println();
    }
    writer.flush();
  }
}
