import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

class UserInput {
  // variables for game control plus
  ControlIO control; // This one is essential
  ControlDevice device; // ControlDevice might be a joystick, gamepad, mouse etc.
  ControlButton leftB; // A device will have some combination of buttons, hats and sliders
  ControlButton rightB;
  ControlButton attackB;
  ControlButton speedB;
  //ControlHat hat;
  //ControlSlider slider;
  boolean playsWithKeyboard;

  public UserInput(HCI2_Ctrl main) {
    control = ControlIO.getInstance(main);//creates the control object for the user input control
    initMouseInput();
    playsWithKeyboard = true;
  }

  private void initMouseInput() {
    device = control.getMatchedDevice("SpaceMouse");
    leftB = device.getButton("LEFT");
    rightB = device.getButton("RIGHT");
    attackB = device.getButton("ATTACK");
    speedB = device.getButton("SPEED");
  }

  public void useKeyBoard() {
    playsWithKeyboard = true;
  }

  public void useMouse() {
    playsWithKeyboard = false;
  }

  public boolean leftPressed() {
    if (playsWithKeyboard)
      return KEYS[LEFT];
    else
      return leftB.pressed();
  }

  public boolean rightPressed() {
    if (playsWithKeyboard)
      return KEYS[RIGHT];
    else
      return rightB.pressed();
  }

  public boolean attackPressed() {
    if (playsWithKeyboard) 
      return KEYS[CONTROL];
    else
      return attackB.pressed();
  }

  public boolean speedUpPressed() {
    if (playsWithKeyboard) {
      return KEYS[SHIFT];
    } else
      return speedB.pressed();
  }
}
