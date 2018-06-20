class Bullet {

  float xPos, yPos, zPos, prevZ, bulletX, bulletY, prevX, prevY;

  public Bullet(PVector spaceShip) {
    xPos = spaceShip.x;
    yPos = spaceShip.y;
    zPos = 1;
    prevZ = zPos;
  }


  void show() {

    zPos = zPos+speed;

    bulletX = map(xPos/zPos, 0, 1, 0, 1);
    bulletY = map(yPos/zPos, 0, 1, 0, 1);

    prevX = map(xPos/prevZ, 0, 1, 0, 1);
    prevY = map(yPos/prevZ, 0, 1, 0, 1);
    
    prevZ = zPos;
    
    
    pushStyle();
    stroke(random(255), random(255), random(255));
    strokeWeight(3);

    if (
      ( (bulletX < 3 || bulletX > 3) && (bulletY < -3 || bulletY > 3) ) || 
      ( (bulletY < 3|| bulletY > 3) && (bulletX < -3|| bulletX > 3) )
      ) 
      line(prevX, prevY, bulletX, bulletY);
    
    popStyle();
  }

}
