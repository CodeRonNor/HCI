import controlP5.*; // menu library
ControlP5 cp5MainMenu;
ControlP5 cp5Setting;
ControlP5 cp5Highscore;
ControlP5 cp5Play;
ControlP5 cp5Instructions;
Music music;

//The current state
int state;
int difficulty;

void setup() {
  size(1000, 700);
  stroke(255);
  fill(0, 102, 153);
  textSize(32);
  
  music = new Music(this);
  
  initialize();
}

void draw() {
  background(0);
  
}

void initialize(){
  mainMenuInitialize();
  settingsInitialize();
  highscoreInitialize();
  instructionsInitialize();
}

public void mainMenuInitialize(){
  // we initialize all the buttons we need and because it is the main menu when we start this game we don't have to hide other features
  cp5MainMenu = new ControlP5(this);
  cp5MainMenu.addButton("startButton").setLabel("Play").setPosition(width/2-200, height/2-140).setSize(400,60);
  cp5MainMenu.addButton("settingsButton").setLabel("Settings").setPosition(width/2-200, height/2-70).setSize(400,60);
  cp5MainMenu.addButton("highScoreButton").setLabel("HighScore").setPosition(width/2-200, height/2+0).setSize(400,60);
  cp5MainMenu.addButton("instructionButton").setLabel("Instructions").setPosition(width/2-200, height/2+70).setSize(400,60);
  cp5MainMenu.addButton("exitButton").setLabel("Exit").setPosition(width/2-200, height/2+140).setSize(400,60);
  
  // menu background music
  music.menu();
  
  // we initialize the state with the main menu
  state = 1;
}

public void settingsInitialize(){
  // we initialize everything needed for the settings menu
  cp5Setting = new ControlP5(this);
  cp5Setting.addButton("difficult1").setLabel("Easy").setPosition(width/2-200, height/2-70).setSize(400,60);
  cp5Setting.addButton("difficult2").setLabel("Medium").setPosition(width/2-200, height/2+0).setSize(400,60);
  cp5Setting.addButton("difficult3").setLabel("Hard").setPosition(width/2-200, height/2+70).setSize(400,60);
  cp5Setting.addButton("back").setLabel("<").setPosition(width-50, 0).setSize(50,50);
  
  // we do not show these buttons right away ... only when the settings menu is called
  cp5Setting.getController("difficult1").hide();
  cp5Setting.getController("difficult2").hide();
  cp5Setting.getController("difficult3").hide();
  cp5Setting.getController("back").hide();
}

public void highscoreInitialize(){
  // we initialize everything needed for the high score menu
  cp5Highscore = new ControlP5(this);
  // we do not show these buttons right away ... only when the high score menu is called
}

public void instructionsInitialize(){
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
  
  // change music
  music.game();
  //music.playThroughSpace();
  
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

public void back(){
  // show main menu items again
  cp5MainMenu.getController("settingsButton").show();   
  cp5MainMenu.getController("startButton").show();
  cp5MainMenu.getController("highScoreButton").show();
  cp5MainMenu.getController("instructionButton").show();
  cp5MainMenu.getController("exitButton").show();
  
  music.menu();
  
  // hide all the other items
  cp5Setting.getController("difficult1").hide();
  cp5Setting.getController("difficult2").hide();
  cp5Setting.getController("difficult3").hide();
  cp5Setting.getController("back").hide();
}

public void difficult1(){
  difficulty = 1;
}

public void difficult2(){
  difficulty = 2;
}

public void difficult3(){
  difficulty = 3;
}
