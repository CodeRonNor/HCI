class Obstacle {

  private float xPos;
  private float yPos;
  private float zPos;
  private float sx;
  private float sy;
  private float radius;
  private PImage[] digger;
  private PImage[] expGreen, expPink, expYellow;
  private int diggerFrame;
  private int expGreenFrame, expPinkFrame, expYellowFrame;
    
  boolean kill;
  boolean hit;

  public Obstacle() 
  {
    digger = new PImage[12];

    expGreen = new PImage[19];
    expPink = new PImage[18];
    expYellow = new PImage[17];

    for (int i = 0; i< expGreen.length; i++) {
      int frame = 43+i;
      expGreen[i] = loadImage("ExplosionGreenCopy/frame_" + frame + "_delay-0.03s.gif");
    }

    for (int i = 0; i< expPink.length; i++) {
      int frame = 6+i;
      expPink[i] = loadImage("ExplosionPinkCopy/frame_"+frame+"_delay-.3s.gif");
    }

    for (int i = 0; i< expYellow.length; i++) {
      int frame = 25+i;
      expYellow[i] = loadImage("ExplosionYellowCopy/frame_"+frame+"_delay-0.03s.gif");
    }



    for (int i = 0; i<digger.length; i++)
      digger[i] = loadImage("Digger/DiggerSplit/frame"+i+".gif");
    xPos = random(-width/2, width/2);
    yPos = random(-height/2, height/2);
    zPos = random(width);    
    diggerFrame = 0;
    expGreenFrame = 0;
    expPinkFrame = 0;
    expYellowFrame = 0;
    radius = 30;
    
    
    kill = false;
    hit = false;
    
  }

  void show() 
  {
    sx = map(xPos/zPos, 0, 1, 0, width/2);
    sy = map(yPos/zPos, 0, 1, 0, height/2);
  }

  void update() 
  {
    zPos -= speed;
    if (zPos < 1) 
    {
      xPos = random(-width/4, width/4);
      yPos = random(-height/4, height/4);
      zPos = random(width);
      kill = false;
    }
  }


  void digger() {
    if (!kill) {
      image(digger[diggerFrame++], sx, sy);
      diggerFrame%=digger.length;
      expGreenFrame = 0;
      expPinkFrame = 0;
      expYellowFrame = 0;
    } else {
      int exp = (int)random(1, 4);

      if (exp == 1) {
        pushStyle();
        tint(255, 255);
        if (expGreenFrame<19)
          image(expGreen[expGreenFrame++], sx, sy);
        popStyle();
      }

      if (exp == 2) {
        pushStyle();
        tint(255, 255);
        if (expPinkFrame<18)
          image(expPink[expPinkFrame++], sx, sy);   
        popStyle();
      }

      if (exp == 3) {
        pushStyle();
        tint(255, 255);
        if (expYellowFrame < 17)
          image(expYellow[expYellowFrame++], sx, sy);    
        popStyle();
      }
    }
  }
}
