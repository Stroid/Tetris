
int rows = 20;
int cols = 10;

int scl = 40;

GameBoard gameBoard;
Player player;

color color1 = color(140);
color color2 = color(80);


//------------------------------------------------------------------------------
void settings() {
  int w = cols * scl + scl * 10;
  int h = rows * scl + scl * 2;
  size(w, h);
}

//------------------------------------------------------------------------------
void setup() {
  strokeWeight(5);
  stroke(color2);

  gameBoard = new GameBoard(scl * 4, scl, rows, cols);
  player = new Player(2, 0);
}

//------------------------------------------------------------------------------
void draw() {
  background(color2);
  if (frameCount % 120 == 0) {
    player.move(0, 1);
  }

  gameBoard.display();
}


//------------------------------------------------------------------------------
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      player.rotate();
      player.valid();
    }
    if (keyCode == DOWN) player.move(0, 1);
    if (keyCode == LEFT)  player.move(-1, 0);
    if (keyCode == RIGHT) player.move(1, 0);
  }
  if (key == ' ') {
    player.getNextShape();
  };
}
