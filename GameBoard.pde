class GameBoard {
  int[] rows;
  int cols;
  int gbX, gbY, gbW, gbH;
  GameBoard(int x, int y, int rows, int cols) {
    this.gbX = x; //GameBoard X
    this.gbY = y; //GameBoard Y
    this.gbW = cols * scl; //GameBoard Width
    this.gbH = rows * scl; //GameBoard Width
    this.rows = new int[rows];
    for (int row = 0; row < rows; row++) {
      this.rows[row] = 0;
    }
    this.cols = cols;
  }
  //----------------------------------------------------------------------------------
  //Display the gameboard
  void display() {
    pushMatrix();
    translate(gbX, gbY);
    drawGameBoard();
    drawCurrentShape();
    popMatrix();
    drawNextShape(15, 1, 4, 20);
  }

  //----------------------------------------------------------------------------------
  //draw gameboard
  void drawGameBoard() {
    fill(color1);
    rect(-(scl * 0.3), -(scl * 0.3), gbW + scl * 0.3 * 2, gbH + scl * 0.3 * 2);
    for (int row = 0; row < this.rows.length; row++) {
      for (int col = 0; col < cols; col++) {
        if (Shape.getBit(this.rows[row], col) == 1) {
          fill(#00FF00);
        } else {
          fill(color1);
        }
        rect(col * scl, row * scl, scl, scl);
      }
    }
  }

  //------------------------------------------------------------------------
  //Draw the current shape.
  void drawCurrentShape() {
    int shape = player.current[player.dir];
    for (int i = 0; i < 16; i++) {
      if (Shape.getBit(shape, i) == 1) {
        fill(player.current[4]);
        rect((player.x + i % 4) * scl, (player.y  + i / 4) * scl, scl, scl);
      }
    }
  }
  //------------------------------------------------------------------------
  //draw the next shape list.
  void drawNextShape(int x, int y, int w, int h) {
    x = x * scl;
    y = y * scl;
    w = w * scl;
    h = h * scl;

    fill(color1);
    rect(x - scl * 0.3, y - scl * 0.3, w + scl * 0.3 * 2, h + scl * 0.3 * 2);
    fill(color2);
    rect(x, y, w, h);

    for (int i = 0; i < 5; i++) {
      int[] shape = player.nextShape.get(i);

      for (int j = 0; j < 16; j++) {
        if (Shape.getBit(shape[0], j) == 1) {
          fill(shape[4]);
          rect((x + j % 4 * scl) - scl/2, (y  + j / 4 * scl) + scl * 4 * i, scl, scl);
        }
      }
    }
  }

  //------------------------------------------------------------------------
  //take the current shape and add it to the gameboard
  void addShape(int x, int y, int shape) {
    println(binary(shape));
    for (int i = 0; i < 16; i += 4) {
      int SR = (shape >> i) & 0xF;//Shape row
      int SR2X = SR << cols - (x + 2);//Move the shape row to the x possition of the current shape
      println(x, binary(SR2X));
    }
  }
}
