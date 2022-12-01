final int NUM_TILES = 5;
PImage baseImage;
PImage[][] mainCopy = new PImage[NUM_TILES][NUM_TILES]; //chopped up correct
PImage[][] board = new PImage[NUM_TILES][NUM_TILES]; //chopped up jumbled
int sqSide;
int numClicks = 0; //help identify user first clicking

void setup(){
  size(750,750);
  baseImage = loadImage("sky.png");
  baseImage.resize(width, height);
  sqSide = width/NUM_TILES;
  
  
  chop();
  displayPuzzle();
}

void draw(){}

void chop(){
  //imageName.get(x, y, re dw, reqdH) - gives us portion of the image 
  for(int row=0; row<NUM_TILES; row++){
    for(int col=0; col<NUM_TILES; col++){
      mainCopy[row][col] = baseImage.get(col*sqSide, row*sqSide, sqSide, sqSide);
      board[row][col] = mainCopy[row][col];
    }
  }
}

void displayPuzzle(){
  for(int row=0; row<NUM_TILES; row++){
    for(int col=0; col<NUM_TILES; col++){
      image(board[row][col], col*sqSide, row*sqSide, sqSide, sqSide);
      //image function brings the image to given place & resize to given size
    }
  }
}

int clickedRow, clickedCol, releasedRow, releasedCol;

void mousePressed(){
  if(numClicks ==0){
    //user has clicked for the first time
    jumble();
    displayPuzzle();
    numClicks=1;
  }else{
    clickedRow = int(mouseY/sqSide);
    clickedCol = int(mouseX/sqSide);
  }
}

void jumble(){
  int randomRow, randomCol;
  for(int row=0; row<NUM_TILES; row++){
    for(int col=0; col<NUM_TILES; col++){
      randomRow= int(random(NUM_TILES));
      randomCol= int(random(NUM_TILES));
      //swap each tile with another random tile
      PImage buffer = board[row][col];
      board[row][col] = board[randomRow][randomCol];
      board[randomRow][randomCol] = buffer;
    }
  }
}

void mouseReleased(){
  releasedRow = int(mouseY/sqSide);
  releasedCol = int(mouseX/sqSide);
  
  //swap  @clickedrow, lcikedcol, with released row and col
  PImage buffer = board[clickedRow][clickedCol];
  board[clickedRow][clickedCol] = board[releasedRow][releasedCol];
  board[releasedRow][releasedCol] = buffer;
  
  displayPuzzle();
  
  //check if game has come to an end
  if(checkEndGame() ==true){
    surface.setTitle("You Win!");
    noLoop();
  }
}

boolean checkEndGame(){
  for(int row=0; row<NUM_TILES; row++){
    for(int col=0; col<NUM_TILES; col++){
      if(board[row][col] != mainCopy[row][col]){
        return false;
      }
    }
  }
  return true;
}
