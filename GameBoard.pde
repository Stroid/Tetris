class GameBoard {
  int[] r;
  int cols;
  int gbX, gbY, gbW, gbH;
  GameBoard(int x, int y, int rows, int cols) {
    this.gbX = x;
    this.gbY = y;
    this.gbW = cols * scl;
    this.gbH = rows * scl;
    this.r = new int[rows];
    for (int row = 0; row < rows; row++) {
      this.r[row] = 0;
    }
    this.cols = cols;
  }
  //----------------------------------------------------------------------------------
  void display() {
    pushMatrix();
    translate(gbX, gbY);
    drawGameBoard();
    drawShape();
    popMatrix();
    drawNextShape(15, 1, 4, 20);
  }

  //----------------------------------------------------------------------------------
  void drawGameBoard() {
    fill(color1);
    rect(-(scl * 0.3), -(scl * 0.3), gbW + scl * 0.3 * 2, gbH + scl * 0.3 * 2);
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (Shape.getBit(this.r[row], col) == 1) {
          fill(#00FF00);
        } else {
          fill(color1);
        }
        rect(col * scl, row * scl, scl, scl);
      }
    }
  }

  //------------------------------------------------------------------------
  void drawShape() {
    int shape = player.current[player.dir];
    for (int i = 0; i < 16; i++) {
      if (Shape.getBit(shape, i) == 1) {
        fill(player.current[4]);
        rect((player.x + i % 4) * scl, (player.y  + i / 4) * scl, scl, scl);
      }
    }
  }
  //------------------------------------------------------------------------
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
  void addshape(int x, int y, int shape) {
    for (int i = 0; i < 4; i++) {
      int b = shape >> 4 * i & 0xF; 
      if (b > 0) {
        this.r[i + y] = this.r[i + y] << x | b;
      }
    }
  }
}
