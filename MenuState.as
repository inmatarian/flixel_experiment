package
{
  import flash.events.*;
  import org.flixel.*;
  
  public class MenuState extends FlxState
  {
    [Embed(source="data/title_vignette.png")]
    protected var TitleVignette:Class;

    [Embed(source="data/title_the_land_of.png")]
    protected var TitleSmallLogo:Class;

    [Embed(source="data/title_wayward.png")]
    protected var TitleLargeLogo:Class;

    [Embed(source="data/song1.mp3")]
    protected var TitleSongMP3:Class;

    protected var cursorSprite:FlxSprite;
    
    public override function create(): void
    {
      trace("Entering MenuState");
      cursorSprite = new FlxSprite( 160, 120 );
      cursorSprite.createGraphic(16, 16, 0xffefdf);
      this.add(new FlxSprite(  0,  0, TitleVignette));
      this.add(new FlxSprite(118, 26, TitleSmallLogo));
      this.add(new FlxSprite( 88, 42, TitleLargeLogo));
      this.add(cursorSprite);
      FlxG.playMusic( TitleSongMP3 );
      trace("Done constructor MenuState");
    }
    
    public override function update():void
    {
      super.update();
      if (FlxG.keys.justPressed("X"))
        FlxG.state = new GameState;

      if (FlxG.keys.justPressed("Z"))
        cursorSprite.y = 110;

      if (FlxG.keys.justPressed("C"))
        cursorSprite.y = 120;

      // if (FlxG.keys.justPressed("T"))
        // FlxG._game._console.toggle();
    }
  }
}
