class Player {
  int x, y, dir;
  int[] current;

  ArrayList<int[]> nextShape = new ArrayList<int[]>();
  ArrayList<int[]> nextShapeBuffer = new ArrayList<int[]>();

  Player(int x, int y) {
    this.x = x;
    this.y = y;

    nextShape.addAll(0, randomShapes());
    nextShapeBuffer.addAll(0, randomShapes());
    nextShapeBuffer.addAll(0, randomShapes());

    getNextShape(); //set new current
  }
  //-----------------------------------------------------------------
  void move(int x, int y) {
    this.x += x;
    this.y += y;

    boolean valid = valid();
    if(!valid){
      //Place the block
    }
    else{
      //continue
    }
  }
  //-----------------------------------------------------------------
  boolean valid() {
    boolean valid = true;
    for (int i = 0; i < 16; i++) {

      if ((current[dir] & 1 << i) > 0) {
        int x = this.x + i % 4;
        int y = this.y + i / 4;

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
  void rotate() {
    dir++;
    if (dir > 3) dir = 0;
  }
}
