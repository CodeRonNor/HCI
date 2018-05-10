class Obstacle {

  private float obSpeed;
  private float xPos;
  private float yPos;
  private float zPos;
  private float sx;
  private float sy;
  private float radius;

  float r;
  PShape moon;


  public Obstacle() {
    obSpeed = 3;
    xPos = random(-width/4, width/4);
    yPos = random(0, height/4);
    zPos = random(width);
    radius = 15;


    noStroke();
    noFill();

    
    //radius = map(zPos, 0, width, 0, 2*radius);

    moon = createShape(SPHERE, 2*radius);
    moon.setTexture(img);
  }

  void show() {
    sx = map(xPos/zPos, 0, 1, 0, width/2);
    sy = map(yPos/zPos, 0, 1, 0, height/2);

    //sx = constrain(sx, -width/2, width/2);
    //sy = constrain(sy, -height/2, height/2);

    //ellipse(sx, sy, 2*radius, 2*radius);
    pushMatrix();
    translate(sx, sy);
    
    // Show moon
    noFill();
    shape(moon);
    
    r = map(zPos, 0, width, 2*radius, 0);
    //sphere(r);
    popMatrix();
  }

  void update() {
    zPos = zPos-speed;
    if (zPos < 1) {
      zPos = random(width);
      xPos = random(-width/4, width/4);
      yPos = random(0, height/4);
    }

    //moon.scale(norm(r,0,1));
  }
}
