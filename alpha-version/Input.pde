class Input {
  
  public Input() {
    
  }
  
  









void handleInput()
{
  if (KEYS[LEFT])
    player.theta += PADDLE_SPEED;
  if (KEYS[LEFT] && KEYS[SHIFT])
    player.theta += PADDLE_SPEED*2;
  if (KEYS[RIGHT]) 
    player.theta -= PADDLE_SPEED;
  if (KEYS[RIGHT] && KEYS[SHIFT])
    player.theta -= PADDLE_SPEED*2;

  if (keyCode == ' ') {
    player.shoot();
    checkHit();
    keyCode = 'n';
  }
}



  
}
