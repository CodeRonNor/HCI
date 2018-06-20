import processing.sound.*;

class Music {

  SoundFile xeonTheme;
  SoundFile throughSpace;

  Music(HCI2 dat) {
    // Load a soundfile from the /data folder of the sketch and play it back
    xeonTheme = new SoundFile(dat, "music/xeonTheme.ogg");
    throughSpace = new SoundFile(dat, "music/throughSpace.ogg");
  }

  void playXeonTheme() {
    xeonTheme.play();
    xeonTheme.loop();
  }

  void stopXeonTheme() {
    xeonTheme.stop();
  }

  void playThroughSpace() {
    throughSpace.play();
    throughSpace.loop();
  }

  void stopThroughSpace() {
    throughSpace.stop();
  }
}
