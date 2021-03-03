PImage wall;
PImage character;
PImage columnt, columnb;
int wallx;
int wally;
int chx; 
float chy;
float g;
float Vchy;
int[] columnX, columnY;
int gameCondition;
int score, highScore;

PImage[]sprites;
int direction=1;
int step=0;
int frames_x;
int frames_y;
int speed=3;

import processing.sound.*;
SoundFile file;

void setup() {
  size(400, 400);
  wall=loadImage("underwater.png");
  character=loadImage("scuba.png");
  sprites= new PImage[8];
  int img_w= character.width/8;
  int img_h= character.height/1;

  int index=0;
  for (int frames_y=0; frames_y<1; frames_y++) {
    for (int frames_x=0; frames_x<8; frames_x++) {
      sprites[index]= character.get(frames_x*img_w, frames_y*img_h, img_w, img_h);
      index++;
    }
  }

  columnb=loadImage("pipetop.png");
  columnt=loadImage("pipebottom.png");

  file= new SoundFile(this, "buble.wav");

  chx=50;
  chy=50;
  g=0.5;

  columnX=new int[5];
  columnY=new int[columnX.length];

  for (int i=0; i<columnX.length; i++) {
    columnX[i]=width+150*i;
    columnY[i]= (int)random(-50, 0);
  }
  gameCondition=-1;
}

void draw() {
  if (gameCondition==-1) {
    startScreen();
  } else if (gameCondition==0) {
    moveBackground();


    columnSet();

    characterControl();
    score();
  } else {

    restartScreen();
  }
  if (mousePressed) {
    file.stop();
    file.play();
    Vchy=-5;
    direction=1;
    frames_x+=speed;

    if (frameCount%speed==0) {
      step = (step+1) % 8;
      //gameCondition=1;
    }
  }
}
void score() {
  if (score>highScore) {
    highScore=score;
  }
  textSize(15);
  fill(160, 160, 160, 200);
  rect(width-100, 10, 85, 60, 5);
  fill(0);

  text("SCORE:"+ score, width-85, 30);
  text("BEST:"+ highScore, width-85, 60);
}
void startScreen() {
  image(wall, 0, 0);
  textSize(40);
  text("DROWNING DIVER", 0+20, height/2);
  textSize(20);
  text("click to start", width/2-60, height/2+60);
  if (mousePressed) {
    chy=height/2;
    gameCondition=0;
  }
}

void restartScreen() {
  image(wall, 0, 0);
  textSize(40);
  text("YOU DROWNED", 60, height/2);
  textSize(20);
  text("score:"+score, 160, height/2+50);
  text("click SPACE to restart", 0+100, height/2+100);
  if (keyPressed) {
    if (key==' ') {
      chx=50;  
      chy=height/2;
      for (int i=0; i<columnX.length; i++) {
        columnX[i]=width+150*i;
        columnY[i]= (int)random(-50, 0);
      }
      gameCondition=0;
      score=0;
    }
  }
}


void characterControl() {
  scale(direction, 1);

  image(sprites[step], chx, chy, 50, 100);
  chy=chy+Vchy;
  Vchy=Vchy+g;
  if (chy>height || chy<0) {
    gameCondition=1;
  }
}
void moveBackground() {
  image(wall, wallx, wally);
  image(wall, wallx+wall.width, wally);
  wallx= wallx-1; 
  if (wallx<-wall.width) {
    wallx=0;
  }
}

void columnSet() {
  for (int i=0; i<columnX.length; i++) {
    image(columnt, columnX[i], columnY[i]+300, 50, 180);
    image(columnb, columnX[i], columnY[i], 50, 180);
    columnX[i]-=2;
    if (score>5) {
      columnX[i]--; //speed up when score more than 5
    }
    if (score>10) {
      columnX[i]--; //speed up when score more than 10
    }
    if (score>20) {
      columnX[i]--; //speed up when score more than 20
    }
    if (columnX[i]<-200) {
      columnX[i]=width;
    }
    //character collision with columns
    if (chx> columnX[i]-50 && chx<columnX[i] +50) {
      if (!(chy> columnY[i] +150  && chy<columnY[i] +(300-40))) {
        gameCondition=1;
      } else if (chx==columnX[i] || columnX[i]+1==chx)
      {
        score++;
      }
      if (gameCondition==1 && gameCondition==-1) {
        score=0;
      }
    }
  }
}
