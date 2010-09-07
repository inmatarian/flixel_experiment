package 
{
  import org.flixel.*;

  [SWF(width="640", height="480", backgroundColor="#101010")]
  [Frame(factoryClass="Preloader")] 

  public class VideoGame extends FlxGame
  {
    public function VideoGame():void
    {
      super(320, 240, MenuState, 2);
      FlxG.debug = true;
      FlxG.framerate = 30;
      trace("Starting game...")
      // help("Jump", "Shoot", "Nothing");
      // useDefaultVolumeControls(true);
    }
  }
}

