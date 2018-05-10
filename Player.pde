class Player {
  float paddleWidth;
  float paddleHeight;
  float x;
  float y;
  final float PADDLE_SPEED;
  
final float rad;

float angle;

  public Player() {
    PADDLE_SPEED = 3;

    paddleWidth = 50;
    paddleHeight = 10;

    x = paddleWidth/2;
    y = height/2-50;
    rad = sqrt(sq(x)+sq(y));
    
    angle = 0;
    
  }

  void show() {
    //x = constrain(x, -width/2, width/2-paddleWidth);

    noFill();
    stroke(255);
    ellipse(0,0,rad*2,rad*2);
    

    //x = sqrt((sq(rad)-sq(y)));
    y = sqrt((sq(rad)-sq(x)));
    println("x: "+ x);
    println("y: "+ y);
    
    pushMatrix();
    
    angle = map(x,0,rad,0,PI);
    rotate(angle);
    rect(x, y, paddleWidth, paddleHeight, 1);
    popMatrix();
    
  }
}
