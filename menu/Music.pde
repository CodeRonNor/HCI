
import processing.sound.*;

/*
 *  sources: throughSpace.ogg and xeonTheme.ogg are taken from
 *    https://opengameart.org/content/space-game-starter-set (15.05.18)
 */

class Music {
  menu app;
  SoundFile file;

  Music(menu a) {
    this.app = a;
    // Load a soundfile from the /data folder of the sketch and play it back
  }

  void menu() {
    if (file != null) {
      file.stop();
    }
    file = new SoundFile(app, "music/xeonTheme.ogg");
    file.loop();
  }  

  void game() {
    if (file != null) {
      file.stop();
    }
    file = new SoundFile(app, "music/throughSpace.ogg");
    file.loop();
  }
}
