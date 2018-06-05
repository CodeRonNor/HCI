import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

class UserInput {
  // variables for game control plus
  ControlIO control; // This one is essential
  //ControlHat hat;
  // for input from a Xbox controller
  ControlDevice deviceXbox;
  ControlSlider xbMove;
  ControlSlider xbSpeed1;
  ControlButton xbAttack1;
  ControlButton xbSpeed2;
  ControlSlider xbAttack2;

  boolean playsWithKeyboard;
  boolean attackWasPressed = false;

  /*
   * init the UserInput
   */
  public UserInput(HCI2_expert main) {
    control = ControlIO.getInstance(main);//creates the control object for the user input control
  }

  /*
   * call this with true to play initialize xbox-controller input type
   */
  public void playWithKeyboard(boolean uiType) {
    if (uiType) {
      playsWithKeyboard = true;
    } else {
      playsWithKeyboard = false;
      initXBoxInput();
    }
  }

  private void initXBoxInput() {
    deviceXbox = control.getMatchedDevice("ctrls/SpaceXbox");
    xbMove = deviceXbox.getSlider("MOVE");
    xbMove.setTolerance(0.1);
    xbSpeed1 = deviceXbox.getSlider("TRIGGER");
    xbSpeed1.setTolerance(0.1);
    xbAttack1 = deviceXbox.getButton("A_BTN");
    // different play mode: left and right triggers to shoot, a button to speed
    xbSpeed2 = deviceXbox.getButton("A_BTN");
    xbSpeed2.setTolerance(0.05);
    xbAttack2 = deviceXbox.getSlider("TRIGGER");
  }

  //public void useKeyBoard() {
  //  playsWithKeyboard = true;
  //}

  //public void useMouse() {
  //  playsWithKeyboard = false;
  //}

  public boolean leftPressed() {
    if (playsWithKeyboard)
      return KEYS[LEFT];
    else
      return xbMove.getValue() > 0.5;
  }

  public boolean rightPressed() {
    if (playsWithKeyboard)
      return KEYS[RIGHT];
    else
      return xbMove.getValue() < -0.5f;
  }

  public boolean attackPressed() {
    if (playsWithKeyboard) {
      if (keyCode == ' ') {
        keyCode = 'n';
        return true;
      } else 
      return false;
    } else {
      if (!attackWasPressed && xbAttack1.pressed()) {
        attackWasPressed = true;
        return true;
      } else {
        if (!xbAttack1.pressed())
          attackWasPressed = false;
        return false;
      }
    }
  }

  public boolean speedUpPressed() {
    if (playsWithKeyboard) {
      return KEYS[SHIFT];
    } else
      return xbSpeed1.getValue() < -0.5f;
  }


  // for second play mode
  public boolean attackPressed2() {
    if (playsWithKeyboard) {
      if (keyCode == ' ') {
        keyCode = 'n';
        return true;
      } else 
      return false;
    } else {
      if (xbAttack2.getValue() > -0.5f && xbAttack2.getValue() < 0.5f) {
        attackWasPressed = false;
        return false;
      } else {
        if (attackWasPressed) {
          return false;
        } else {
          //if (xbAttack2.getValue() < -0.5f || xbAttack2.getValue() > 0.5f) {
          attackWasPressed = true;
          return true;
        }
      }
    }
  }

  public boolean speedUpPressed2() {
    if (playsWithKeyboard) {
      return KEYS[SHIFT];
    } else
      return xbSpeed2.pressed();
  }
}
