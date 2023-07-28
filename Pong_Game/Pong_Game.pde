///////////////////////////////////////////////////////////////////
//Name: Ran Daniel
//Date: Nov, 2022
//Description: Pong Game
//////////////////////////////////////////////////////////////////

int state = 1;
boolean[] keys;

//Media Variables
PImage background;
PImage startScreen;
PImage gameOver;
PImage ball;
PFont NewA;

//Ball Variables
float xBall = 400;
float yBall = 300;
int dBall = 31;

//Ball Speed Variables
float xSpeed = 3;
float ySpeed = 3;
float ySpeed2 = -3;
float mSpeed = 1.1;

//Left Paddle Variables
int padLeftX = 0;
int padLeftY = 250;
int padLeftW = 10;
int padLeftH = 150;

//Right Paddle Variables
int padRightX = 790;
int padRightY = 250;
int padRightW = 10;
int padRightH = 150;

//Score
int playerOneScore = 0;
int playerTwoScore = 0;


//Basic Setup
void setup() {
  frameRate(120);
  size(800,600);
  smooth();
  NewA = createFont("NewA.ttf",20);
  textFont(NewA);
  keys=new boolean[4]; // give the array its dimencion: 4 elements 
  keys[0]=false; // give them values. When each key is not pressed its state is false
  keys[1]=false;
  keys[2]=false;
  keys[3]=false;


//Load Media
  background = loadImage("background.png");
  background.resize(800,600);
  startScreen = loadImage("startScreen.png");
  startScreen.resize(800,600);
  ball = loadImage("ball.png");
}


//Start Screen
void BeginGame() {
  image(startScreen,0,0);
  textSize(20);
  text("By: Ran Daniel", 50,550);
}


//Instructions Screen
void Instructions() {
  textSize(20);
  text("Player One",350, height/5);
  text("Use the 'W' Key to move up and the 'S' Key to move down", width/5, height/4); 
  text("Player Two",340, height/3*2+20);
  text("Use the Up Arrow Key to move up and the Down Arrow Key to move down",width/9, height/4*3);
  textSize(40);
  text("Press 'ENTER' to Begin!", 220, height/2);
}


//Reset Ball After Point
void score(){
if(xBall <= 0){
  playerTwoScore = playerTwoScore + 1;
  xBall = width/3;
  yBall = height/2;
  xSpeed = -3;
  if(padRightY < 225){
  ySpeed = 3; 
  }
  else{
  ySpeed = -3;
  }
}  
else if(xBall >= width){
  playerOneScore = playerOneScore + 1;
  xBall = width/3*2;
  yBall = height/2;
  xSpeed = 3;
  if(padLeftY < 225){
  ySpeed = 3; 
  }
  else{
  ySpeed = -3;
  }
}  

  
//Ending the Game
  if(playerOneScore == 7){
  state = 4;
}
  if(playerTwoScore == 7){
  state = 5;
  }
}


void bounceBall(){
  xBall = xBall - xSpeed;
  yBall = yBall + ySpeed;

  
//Ball Bounce Off Paddles (Speeds Up After Every Bounce)
if(xBall <= 20 && yBall >= padLeftY && yBall <= padLeftY+padLeftH){
xSpeed = xSpeed *-1;
xSpeed = xSpeed * mSpeed;
ySpeed = ySpeed * mSpeed;
}

else if(xBall >= width-20 && yBall >= padRightY && yBall <= padRightY+padLeftH){
xSpeed = xSpeed *-1;
xSpeed = xSpeed * mSpeed;
ySpeed = ySpeed * mSpeed;
}


//Ball Bounce Off Top and Bottom Border
  else if (yBall > height-15 || yBall < dBall){
  ySpeed = ySpeed * -1;
}

//Ball Speeds Up Slower After Speed = 5
if (xSpeed >= 5){
  mSpeed = 1.02;
}
if(xSpeed <= 5){
  mSpeed = 1.1;
}
}


//Game Drawings
void redraw(){
stroke(255,0,0);
strokeWeight(6);
line(0,0,width,0);
line(0,height-2,width,height-2);
line(width/2,0,width/2,height);
strokeWeight(0);
rect(padLeftX, padLeftY, padLeftW, padLeftH);
rect(padRightX, padRightY, padRightW, padRightH);
image(ball,xBall-15,yBall-25,dBall,dBall);
textSize(30);
text(playerOneScore,365,height/2);
text(playerTwoScore,420,height/2);
}


//Cheat
void cheat(){
  if(keyPressed){


//Cheat 1 Can Only Be Used When The Players Score = 0 (High Vertical Speed)
    if(key == '1' && playerOneScore < 1){
    ySpeed = 10;
    }
  if(key == '/' && playerTwoScore < 1){
    ySpeed = 10;
    }


//Cheat 2 Can Only Be Used When The Players Score = 5 (Teleports Ball)
  if(key == '1' && playerOneScore == 5){
    xSpeed = -3;
    xBall = 700;
    yBall = random(50,550);
    delay(500);
    }
  if(key == '/' && playerTwoScore == 5){
    xSpeed = +3;
    xBall = 100;
    yBall = random(50,550);
    delay(500);
    }
  }
}


//Running The Game
void draw() {
  background(0);


  if (state == 1) {
    BeginGame();

//If 'PLAY' is Pressed, Instruction Screen Shows Up
     if (mouseX > 300 && mouseX < 500 && mouseY>330 && mouseY<390){
    if (mousePressed){ 
      clear();
     state = 2;
    }
  }
}


  if(state == 2) {
    Instructions();
    
//If Enter is Pressed, Game Begins
     if (keyPressed){
       if(key == ENTER){
      state = 3;
    }
  }
}
  if(state == 3) {
    image(background,0,0);
    bounceBall();
    redraw();
    score();
    cheat();

  }
//If Player 1 Wins
if(state == 4){
background(0);
fill(255);
textSize(50);
text("Player 1 Wins",250, 300);
text("Press 'Enter' to play again",120,500);
textSize(75);
fill(255,0,0);
text("Game Over",240,100);
fill(255);
if (keyPressed){
  if(key == ENTER){
  playerOneScore = 0;
  playerTwoScore = 0;
  state = 3;
  }
}
}


//If Player 2 Wins
 if(state == 5){
background(0);
fill(255);
textSize(50);
text("Player 2 Wins",250, 300);
text("Press 'Enter' to play again",120,500);
textSize(75);
fill(255,0,0);
text("Game Over",240,100);
fill(255);
if (keyPressed){
  if(key == ENTER){
  playerOneScore = 0;
  playerTwoScore = 0;
  state = 3;
  }
}
}
    
//Paddle Movement and Speed
if( keys[0])
  {  
    padLeftY-=5; 
  }
  if( keys[1]) 
  {
    padLeftY+=5;
  }
   if( keys[2]) 
  {
    padRightY-=5;
  }
   if( keys[3]) 
  {
    padRightY+=5;
  }

//Restrict Paddle To The Screen
if(padLeftY <= 0){
  padLeftY+=5;
}
if(padLeftY >= 450){
  padLeftY-=5;
}

if(padRightY <= 0){
  padRightY+=5;
}
if(padRightY >= 450){
  padRightY-=5;
  }
}


//Key Bindings For Paddle Movement
void keyPressed(){  
  if(key=='w')  keys[0]=true; 
  if(key=='s')  keys[1]=true;
  if(keyCode==UP)  keys[2]=true;
  if(keyCode==DOWN)  keys[3]=true;
}

void keyReleased()
{  
  if(key=='w') keys[0]=false;
  if(key=='s') keys[1]=false;
  if(keyCode==UP) keys[2]=false;
  if(keyCode==DOWN) keys[3]=false;
}
