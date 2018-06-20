import controlP5.*; // menu library
ControlP5 cp5MainMenu;
ControlP5 cp5Setting;
ControlP5 cp5Highscore;
ControlP5 cp5Play;
ControlP5 cp5Instructions;
ControlP5 cp5HighscoreFont;

ControlFont font1;
ControlFont font2;
ControlFont font3;

//The current menu-game-state
int state;
int difficulty;
LinkedList hardScoresList;
LinkedList midScoresList;
LinkedList easyScoresList;

String[] tokens;

//Classes
HighScore highScoreHard;
HighScore highScoreMid;
HighScore highScoreEasy;












ArrayList<Star> stars;
float speed;
final float PADDLE_SPEED = 0.025;

final boolean[] KEYS = new boolean [255];
Player player;
Timer timer;
boolean start = false; 

int score = 0;

float angle = 1;

PImage[] spaceShips;


float transX;
float transY;

import controlP5.*;
ControlP5 cp5;


int spaceShipSize;

int hitter = 0;

int finalTime;


ArrayList<Obstacle> obstacles;


Input input;


boolean startGame;

private Music music;

void setup() 
{
  size(1200, 800, P2D);


  initialize();


  transX = width/2;
  transY = height/2;
  spaceShipSize = 80;

  spaceShips = new PImage[] {loadImage("SpaceShips/spaceShip1.gif"), loadImage("SpaceShips/spaceShip2.gif")};
  spaceShips[0].resize(spaceShipSize, spaceShipSize);
  spaceShips[1].resize(spaceShipSize, spaceShipSize);



  stars = new ArrayList<Star>();
  for (int i = 0; i<1500; i++) 
  {
    stars.add(new Star());
  }

  player = new Player();
  timer = new Timer();

  obstacles = new ArrayList<Obstacle>();
  for (int i = 0; i<7; i++)
    obstacles.add(new Obstacle());

  input = new Input();
  
  music = new Music(this);
 
}

void draw() 
{
  background(0);
  
    

  if (startGame) {
    
    

    
    translate(transX, transY); 


    // Speed of the game
    if (!gameOver()) {

      if (difficulty == 1)
        speed = 5;
      if (difficulty == 2)
        speed = 10;
      if (difficulty == 3)
        speed = 15;
      //else
      //speed = map(mouseX, 0, width, 1, 20);
    }

    // Handling Stars
    for (Star star : stars)
    { 
      star.update();
      star.show();
    }

    // Handling Player
    player.show();
    input.handleInput();

    // Handling Obstacle
    for (Obstacle obstacle : obstacles) {
      obstacle.show();
      obstacle.update();
      obstacle.digger();
    }


    // Handling Collision
    for (Obstacle obstacle : obstacles)
      score(detectCollision(obstacle), obstacle);

    if (!start) {
      timer.start();
      start = true;
    }
  }
}







void keyPressed()
{
  KEYS[keyCode] = true;
}


void keyReleased()
{
  KEYS[keyCode] = false;
}




void checkHit() {
  if (!gameOver()) {
    for (Obstacle obstacle : obstacles) {
      obstacle.hit = lineCircle(player.spaceShip.x, player.spaceShip.y, obstacle.sx, obstacle.sy, obstacle.radius) && !obstacle.kill;
      if (obstacle.hit) {
        obstacle.kill = true;
        hitter++;
      }
    }
  }
}

boolean lineCircle(float x1, float y1, float cx, float cy, float r) {

  // get length of the line
  float len = sqrt( sq(x1) + sq(y1) );

  // get dot product of the line and circle
  float dot = ( ((cx-x1)*(-x1)) + ((cy-y1)*(-y1)) ) / sq(len);

  // find the closest point on the line
  float closestX = x1 + (dot * (-x1));
  float closestY = y1 + (dot * (-y1));

  // is this point actually on the line segment?
  // if so keep going, but if not, return false
  boolean onSegment = linePoint(x1, y1, closestX, closestY);
  if (!onSegment) 
    return false;

  // get distance to closest point
  x1 = closestX - cx;
  y1 = closestY - cy;
  float distance = sqrt( sq(x1) + sq(y1) );

  if (distance <= r) {
    return true;
  }
  return false;
}

boolean linePoint(float x1, float y1, float px, float py) {

  // get distance from the point to the two ends of the line
  float d1 = dist(px, py, x1, y1);
  float d2 = dist(px, py, 0, 0);

  // get the length of the line
  float lineLen = dist(x1, y1, 0, 0);

  // since floats are so minutely accurate, add
  // a little buffer zone that will give collision
  float buffer = 0.1;    // higher # = less accurate

  // if the two distances are equal to the line's
  // length, the point is on the line!
  if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
    return true;
  }
  return false;
}

boolean detectCollision(Obstacle obstacle) 
{
  float dist = dist(player.spaceShip.x, player.spaceShip.y, obstacle.sx, obstacle.sy);
  return ((dist < player.PR + obstacle.radius) && !obstacle.kill);
}




















void score(boolean collide, Obstacle obstacle)
{

  if (!gameOver()) { 
    finalTime = timer.getElapsedTime();
    if (collide) 
    {
      score++;
      obstacle.kill = true;
    }
    textSize(20);
    fill(255);
    if (timer.second()<10)
      text("hit: " + score + "     kills: " + hitter + " ♥           0" + timer.hour() + ":0" + timer.minute() + ":0" + timer.second(), 0, -height/2+30);
    else
      text("hit: " + score + "     kills: " + hitter + " ♥           0" + timer.hour() + ":0" + timer.minute() + ":" + timer.second(), 0, -height/2+30);
  } else {
    speed = 0;
    timer.stop();
    pushStyle();
    textSize(50);
    stroke(0, 0, 200);
    fill(200, 0, 0);
    text("GAME OVER ", -100, 0);
    popStyle();
    int finalHour = (finalTime /  (1000*60*60)) % 24;
    int finalMinute = (finalTime / (1000*60)) % 60;
    int finalSecond = (finalTime / 1000) % 60;

    if (finalSecond<10)
      text("hit: " + score + "     kills: " + hitter + " ♥           0" + finalHour + ":0" + finalMinute + ":0" + finalSecond, 0, -height/2+30);
    else
      text("hit: " + score + "     kills: " + hitter + " ♥           0" + finalHour + ":0" + finalMinute + ":" + finalSecond, 0, -height/2+30);

    //if(difficulty == 1)
    //highscoreEasy.addUser(,);
  }
}

private boolean gameOver() {
  return score == 3;
}
































































void initialize() {

  music.playThroughSpace();

  highScoreHard = new HighScore("hardScores.txt");
  highScoreMid = new HighScore("midScores.txt");
  highScoreEasy = new HighScore("easyScores.txt");

  // Fonts we use
  font1 = new ControlFont(createFont("Arial", 20));
  font2 = new ControlFont(createFont("Arial", 10));
  font3 = new ControlFont(createFont("8-BIT WONDER.TTF", 40));

  mainMenuInitialize();
  settingsInitialize();
  highscoreInitialize();
  instructionsInitialize();
}

public void mainMenuInitialize() {


  // we initialize all the buttons we need and because it is the main menu when we start this game we don't have to hide other features
  cp5MainMenu = new ControlP5(this);
  cp5MainMenu.setFont(font1);
  cp5MainMenu.addButton("startButton").setLabel("Play").setPosition(width/2-200, height/2-140).setSize(400, 60);
  cp5MainMenu.addButton("settingsButton").setLabel("Settings").setPosition(width/2-200, height/2-70).setSize(400, 60);
  cp5MainMenu.addButton("highScoreButton").setLabel("HighScore").setPosition(width/2-200, height/2+0).setSize(400, 60);
  cp5MainMenu.addButton("instructionButton").setLabel("Instructions").setPosition(width/2-200, height/2+70).setSize(400, 60);
  cp5MainMenu.addButton("exitButton").setLabel("Exit").setPosition(width/2-200, height/2+140).setSize(400, 60);
  
 // we initialize the state with the main menu
  state = 1;
}

public void settingsInitialize() {
  // we initialize everything needed for the settings menu
  cp5Setting = new ControlP5(this);
  cp5Setting.setFont(font1);
  cp5Setting.addButton("difficult1").setLabel("Easy").setPosition(width/2-200, height/2-70).setSize(400, 60);
  cp5Setting.addButton("difficult2").setLabel("Medium").setPosition(width/2-200, height/2+0).setSize(400, 60);
  cp5Setting.addButton("difficult3").setLabel("Hard").setPosition(width/2-200, height/2+70).setSize(400, 60);
  cp5Setting.addButton("back").setLabel("<").setPosition(width-50, 0).setSize(50, 50);

  // we do not show these buttons right away ... only when the settings menu is called
  cp5Setting.getController("difficult1").hide();
  cp5Setting.getController("difficult2").hide();
  cp5Setting.getController("difficult3").hide();
  cp5Setting.getController("back").hide();
}

public void highscoreInitialize() {
  // we initialize everything needed for the high score menu
  cp5Highscore = new ControlP5(this);
  cp5Highscore.setFont(font2);

  cp5HighscoreFont = new ControlP5(this);
  cp5HighscoreFont.setFont(font3);
  cp5HighscoreFont.addLabel("High Scores").setPosition(width/2-200, 90).setSize(400, 50).hide();
  // we do not show these buttons right away ... only when the high score menu is called

  // we load the highscores into the userList
  hardScoresList = highScoreHard.getUsersList();
  midScoresList = highScoreMid.getUsersList();
  easyScoresList = highScoreEasy.getUsersList();

  initializeHardScoreBox();
  initializeMidScoreBox();
  initializeEasyScoreBox();
}

private void initializeEasyScoreBox() {
  ListBox listBoxEasy = cp5Highscore.addListBox("Easy").setSize(150, 300).setPosition(100, 250).setBarHeight(30).setItemHeight(30);
  tokens  = new String[hardScoresList.size()];
  for (int k = 0; k < tokens.length; k++) {
    tokens[k] = prepareStringForDisplaying("" + easyScoresList.get(k));
    listBoxEasy.addItem(tokens[k], k);
  }
  cp5Highscore.getController("Easy").hide();
}

private void initializeMidScoreBox() {
  ListBox listBoxMid = cp5Highscore.addListBox("Medium").setSize(150, 300).setPosition(width/2-75, 250).setBarHeight(30).setItemHeight(30);
  tokens  = new String[hardScoresList.size()];
  for (int k = 0; k < tokens.length; k++) {
    tokens[k] = prepareStringForDisplaying("" + midScoresList.get(k));
    listBoxMid.addItem(tokens[k], k);
  }
  cp5Highscore.getController("Medium").hide();
}

private void initializeHardScoreBox() {
  ListBox listBoxHard = cp5Highscore.addListBox("Hard").setSize(150, 300).setPosition(width-250, 250).setBarHeight(30).setItemHeight(30);
  tokens  = new String[hardScoresList.size()];
  for (int k = 0; k < tokens.length; k++) {
    tokens[k] = prepareStringForDisplaying("" + hardScoresList.get(k));
    listBoxHard.addItem(tokens[k], k);
  }
  cp5Highscore.getController("Hard").hide();
}

private String prepareStringForDisplaying(String dataBaseString) {
  String newString = "";

  for (int i = 1; i < dataBaseString.length()-1; i++) {
    char currentChar = dataBaseString.charAt(i);
    if (currentChar == ',') {
      newString += "      ";
    } else {
      newString += str(currentChar);
    }
  }

  return newString;
}

public void instructionsInitialize() {
  // we initialize everything needed for the instruction menu
  cp5Instructions = new ControlP5(this);
  // we do not show these buttons right away ... only when the instruction menu is called
}

// this function will be triggered if startButton is clicked
public void startButton() {
  // removes the button
  cp5MainMenu.getController("startButton").hide();
  cp5MainMenu.getController("settingsButton").hide();
  cp5MainMenu.getController("highScoreButton").hide();
  cp5MainMenu.getController("instructionButton").hide();
  cp5MainMenu.getController("exitButton").hide();

  cp5Setting.getController("difficult1").show();
  cp5Setting.getController("difficult2").show();
  cp5Setting.getController("difficult3").show();
  cp5Setting.getController("back").show();

  state = 2;

  // start game here
  // play(int difficulty); // pass the selected difficulty as a parameter and start the game
}

// this function will be triggered when the startButton is clicked
public void settingsButton() {
  // removes the button
  cp5MainMenu.getController("settingsButton").hide();
  cp5MainMenu.getController("startButton").hide();
  cp5MainMenu.getController("highScoreButton").hide();
  cp5MainMenu.getController("instructionButton").hide();
  cp5MainMenu.getController("exitButton").hide();

  cp5Setting.getController("back").show();

  state = 3;
}

// this function will be triggered when the highScoreButton is clicked
public void highScoreButton() {
  // removes the button
  cp5MainMenu.getController("settingsButton").hide();   
  cp5MainMenu.getController("startButton").hide();
  cp5MainMenu.getController("highScoreButton").hide();
  cp5MainMenu.getController("instructionButton").hide();
  cp5MainMenu.getController("exitButton").hide();

  cp5Highscore.getController("Hard").show();
  cp5Highscore.getController("Medium").show();
  cp5Highscore.getController("Easy").show();
  cp5HighscoreFont.getController("High Scores").show();

  cp5Setting.getController("back").show();

  state = 4;
}

// this function will be triggered when the instrucitonButton is clicked
public void instructionButton() {
  // removes the button
  cp5MainMenu.getController("settingsButton").hide();   
  cp5MainMenu.getController("startButton").hide();
  cp5MainMenu.getController("highScoreButton").hide();
  cp5MainMenu.getController("instructionButton").hide();
  cp5MainMenu.getController("exitButton").hide();

  cp5Setting.getController("back").show();
  state = 5;
}

// this function will be triggered when the exitButton is clicked
public void exitButton() {
  exit();
}

public void back() {
  // show main menu items again
  cp5MainMenu.getController("settingsButton").show();   
  cp5MainMenu.getController("startButton").show();
  cp5MainMenu.getController("highScoreButton").show();
  cp5MainMenu.getController("instructionButton").show();
  cp5MainMenu.getController("exitButton").show();

  // hide all settings items

  cp5Setting.getController("difficult1").hide();
  cp5Setting.getController("difficult2").hide();
  cp5Setting.getController("difficult3").hide();
  cp5Setting.getController("back").hide();


  // hide all highscore items
  cp5Highscore.getController("Hard").hide();
  cp5Highscore.getController("Medium").hide();
  cp5Highscore.getController("Easy").hide();
  cp5HighscoreFont.getController("High Scores").hide();
}

public void difficult1() {
  difficulty = 1;
  startGame = true;
  cp5Setting.getController("difficult1").hide();
  cp5Setting.getController("difficult2").hide();
  cp5Setting.getController("difficult3").hide();
  
  music.playXeonTheme();
}

public void difficult2() {
  difficulty = 2;
  startGame = true;
  cp5Setting.getController("difficult1").hide();
  cp5Setting.getController("difficult2").hide();
  cp5Setting.getController("difficult3").hide();
  
  music.playXeonTheme();
}

public void difficult3() {
  difficulty = 3;
  startGame = true;
  cp5Setting.getController("difficult1").hide();
  cp5Setting.getController("difficult2").hide();
  cp5Setting.getController("difficult3").hide();
  
  music.playXeonTheme();
}
