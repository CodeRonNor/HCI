import controlP5.*; // menu library
ControlP5 cp5;

//The current state
int state;


void setup() {
  size(1000, 700);
  stroke(255);
  fill(0, 102, 153);
  textSize(32);
  
  initialize();
}

void draw() {
  background(0);
  
}

void initialize(){
  // start menu
  cp5 = new ControlP5(this);
  cp5.addButton("startButton").setLabel("Play").setPosition(width/2-200, height/2-30).setSize(400,60);
  
  // we initialize the state with the game_manu value
  state = 1;
}

// this function will be triggered if startButton is clicked
public void startButton() {
  state = 2;
  cp5.getController("startButton").remove();   // removes the button
  println("BUTTON REMOVE");
}
