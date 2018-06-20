import java.util.*;

class Player {
  float paddleWidth;
  float paddleHeight;
  float x;
  float y;
  final float PLAYER_SPEED;
  final float RAD;
  float theta;
  PVector spaceShip;
  ArrayList<Bullet> bullets;


  int frameNumber;
  int frameCycle;
  final int PR = 40; // player radius

  //Bullet bullet;

  public Player() {
    PLAYER_SPEED = 3;
    paddleWidth = 50;
    paddleHeight = 10;
    x = 0;
    y = height/2-50;
    RAD = sqrt(sq(x)+sq(y));
    theta = HALF_PI;
    spaceShip = new PVector(x, y);

    frameNumber = 0;
    frameCycle = frameNumber;

    //bullet = new Bullet(spaceShip);

    bullets = new ArrayList<Bullet>();
  }

  void show() {

    // Polar to Cartesian
    spaceShip.x = RAD * cos(theta);
    spaceShip.y = RAD * sin(theta);

    // Translate to (x,y) coordinates and rotate the player to always face the center
    pushMatrix();

    translate(spaceShip.x, spaceShip.y);
    rotate(atan2(spaceShip.y, spaceShip.x)-HALF_PI);

    // Illusion of movement of the ship through cycling through the images, per two frames
    frameCycle = frameCycle >= 4 ? -1 : frameCycle; // Could also increment by 1/2 or 1/3
    frameCycle++;  

    imageMode(CENTER);
    image(spaceShips[frameNumber = frameCycle < 2 ? 0 : 1], 0, 0);
    popMatrix();
    bulletBlaster();
  }





  public void bulletBlaster() {
    Iterator<Bullet> i = bullets.listIterator();
    while (i.hasNext()) {
      Bullet b = i.next();
      b.show();
      if (b.xPos == 0 && b.yPos == 0) {
        i.remove();
      }
    }
  }

  void shoot() {
    bullets.add(new Bullet(spaceShip));
  }
}
