class Player {
  int x, y, dir;
  int[] current;

  ArrayList<int[]> nextShape = new ArrayList<int[]>();
  ArrayList<int[]> nextShapeBuffer = new ArrayList<int[]>();

  Player(int x, int y) {
    this.x = x;
    this.y = y;

    nextShape.addAll(0,randomShapes());
    nextShapeBuffer.addAll(0,randomShapes());
    nextShapeBuffer.addAll(0,randomShapes());
    
    getNextShape(); //set new current
  }
  
  
//------------------------------------------------------------------------------------------------------  
//Set new current and return the next shape.
  int[] getNextShape(){
    int[] ns = nextShape.get(0); // Get the next shape in line
    
    nextShape.remove(0); // Remove the shape from the list
    nextShape.add(nextShapeBuffer.get(0)); //Add a shape from the buffer
    nextShapeBuffer.remove(0); // Remove the shape from the buffer
    
    if(nextShapeBuffer.size() > 7){
      nextShapeBuffer.addAll(randomShapes());
    }
    current = ns;
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
      }else{
        Shapes.add(shape);
      }
    }
    
    return Shapes;
  }
  
//-------------------------------------------------------------------------------------------------------
  void rotate(){
    dir++;
    if(dir > 3) dir = 0;
  }
}
