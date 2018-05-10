class Star {
  
  private float xPos;
  private float yPos;
  private float zPos;
  private float prevZ;
  
  

  Star() {

    xPos = random(-width/2, width/2);
    yPos = random(-height/2, height/2);
    zPos = random(width);
    prevZ = zPos;
  }


  void update() {
    zPos = zPos-speed;
    if (zPos < 1) {
      zPos = random(width);
      xPos = random(-width/2, width/2);
      yPos = random(-height/2, height/2);
      prevZ = zPos;
    }
  }



  void show() {
    
    // Coloured stars
    //strokeWeight(3);
    //stroke(random(255), random(255),random(255));
    //fill(random(255), random(255),random(255));
    
    
    fill(255);
    noStroke();
    float sx = map(xPos/zPos, 0, 1, 0, width);
    float sy = map(yPos/zPos, 0, 1, 0, height);

    //float r = map(zPos, 0, width, 5, 0);
    //ellipse(sx, sy, r, r);

    float prevX = map(xPos/prevZ, 0, 1, 0, width);
    float prevY = map(yPos/prevZ, 0, 1, 0, height);
    prevZ = zPos;
    stroke(255);
    line(prevX, prevY, sx, sy);
  }
}
