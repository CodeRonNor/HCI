ArrayList<Star> stars;
float speed;
final float PADDLE_SPEED = 3;

final boolean[] KEYS = new boolean [255];
Player player;
Obstacle obstacle;

int score = 0;

float angle = 1;
boolean collide = false;

PImage img;

float transX;
float transY;





import controlP5.*;
ControlP5 cp5;
int state;


void setup() 
{
  size(800, 800, P3D);
  //initialize();
  
  
  transX = width/2;
  transY = height/2;
  
  img = loadImage("moon.jpg");
  stars = new ArrayList<Star>();
  for (int i = 0; i<1500; i++) 
  {
    stars.add(new Star());
  }

  player = new Player();
  obstacle = new Obstacle();
}

void draw() 
{
  background(0);

  //if (state==2) {
    translate(transX, transY); 
    
    
    
    // Change perspective
    //transX++;
    //transY++;
    
    //if(transX>width || transX < 0)
    //transX *= -1;
    
    //if(transY>height || transX < 0)
    //transY *= -1;
    
    
    
    // Speed of the game
    speed = map(mouseX, 0, width, 1, 20);
    
    // Handling Stars
    for (Star star : stars)
    { 
      star.update();
      star.show();
    }
    
    // Handling Player
    player.show();
    handleInput();

    // Handling Obstacle
    obstacle.show();
    obstacle.update();

    // Handling Collision
    score(collide = detectCollision());


  //noFill();
  //rotate(angle++);
  //sphere(75);
  //angle+=0.001;
}

void initialize() 
{
  state = 1;
  cp5 = new ControlP5(this);
  textSize(20);
  fill(255);
  cp5.addButton("startButton").setLabel("Play").setPosition(width/2-200, height/2-30).setSize(400, 60);
  cp5.addTextfield("Masters of the Universe").setText("Steffen the Galaxy Hunter").setPosition(width/2, height/3);
}

public void startButton() 
{
  state = 2;
  cp5.getController("startButton").remove();
}

void keyPressed()
{
  KEYS[keyCode] = true;
}

void keyReleased()
{
  KEYS[keyCode] = false;
}

void handleInput()
{
  if (KEYS[LEFT])
    player.x -= PADDLE_SPEED;
  if (KEYS[LEFT] && KEYS[SHIFT])
    player.x -= PADDLE_SPEED*2;
  if (KEYS[RIGHT]) 
    player.x += PADDLE_SPEED;
  if (KEYS[RIGHT] && KEYS[SHIFT])
    player.x += PADDLE_SPEED*2;
}

boolean detectCollision() 
{

  float obLx = obstacle.sx-obstacle.radius;
  float obRx = obstacle.sx+obstacle.radius;
  float obDy = obstacle.sy+obstacle.radius;
  float pLx = player.x;
  float pRx = player.x+player.paddleWidth;
  float pUy = player.y;

  return obLx >= pLx && obRx <= pRx && obDy >= pUy;
}

void score(boolean collide)
{
  if (collide)
    score++;

  textSize(20);
  fill(255);
  text(score + " ♥ ", 0, -height/2+30);
}
