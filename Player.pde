class Player {
  int x, y, dir;
  int[] current;

  ArrayList<int[]> nextShape = new ArrayList<int[]>();
  ArrayList<int[]> nextShapeBuffer = new ArrayList<int[]>();

  //keeps track of how many times in a row a move has been unvalid.
  int notValidCount = 0;

  Player(int x, int y) {
    this.x = x;
    this.y = y;
    
    //create a next shape list and fill it width shapes.
    nextShape.addAll(0, randomShapes());
    nextShapeBuffer.addAll(0, randomShapes());
    nextShapeBuffer.addAll(0, randomShapes());

    current = Shape.I;//getNextShape(); //set new current shape
  }
  //-----------------------------------------------------------------
  void move(int x, int y) {
    this.x += x;
    this.y += y;

    boolean valid = valid();
    
    //If the move whas not aloud add one too the not valid counter.
    if (!valid) {
      notValidCount++;
      //println("NotValidCount: " + notValidCount);
      
    //Else reset the not valid counter.
    } else {
      notValidCount = 0;
    }
  }
  //-----------------------------------------------------------------
  boolean valid() {
    boolean valid = true;
    for (int i = 0; i < 16; i++) {
      
      //If i is a block
      if ((current[dir] & 1 << i) > 0) {
        //Calculate the possition
        int x = this.x + i % 4;
        int y = this.y + i / 4;

        //while the current shape is outside the bounderies move the shape.
        //And det valid to false
        while (y > rows - 1) {
          y--;
          this.y--;
          valid = false;
        }
        while (x > cols - 1) {
          x--;
          this.x--;
          valid = false;
        }
        while (x < 0) {
          x++;
          this.x++;
          valid = false;
        }
      }
    }
    return valid;
  }
  //------------------------------------------------------------------------------------------------------  
  //Set new current and return the next shape.
  int[] getNextShape() {
    int[] ns = nextShape.get(0); // Get the next shape in line

    nextShape.remove(0); // Remove the shape from the list
    nextShape.add(nextShapeBuffer.get(0)); //Add a shape from the buffer
    nextShapeBuffer.remove(0); // Remove the shape from the buffer

    if (nextShapeBuffer.size() > 7) {
      nextShapeBuffer.addAll(randomShapes());
    }
    current = ns;

    this.x = 2;
    this.y = 0;

    return ns; //Return next shape;
  }

  //------------------------------------------------------------------------------------------------------
  //Return a list of shape in shuffeled order
  ArrayList<int[]> randomShapes() {
    ArrayList<int[]> Shapes = new ArrayList<int[]>();

    for (int i = 0; i < 7; i++) {
      int[] shape = Shape.shapes[(int)random(7)];
      if (Shapes.contains(shape)) {
        i--;
      } else {
        Shapes.add(shape);
      }
    }

    return Shapes;
  }

  //-------------------------------------------------------------------------------------------------------
  //Rotate the shape
  void rotate() {
    dir++;
    if (dir > 3) dir = 0;
  }
}
