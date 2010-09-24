package
{
  import org.flixel.*;
  
  public class Player extends FlxSprite
  {
    [Embed(source="data/sylvia/sylvia.png")] 
    protected var PlayerImage:Class;
    
    protected static const PLAYER_START_X: int = 64;
    protected static const PLAYER_START_Y: int = 64;
    protected static const PLAYER_SPEED: Number = 80; // Experimentally Determined

    public function Player()
    {
      super(PLAYER_START_X, PLAYER_START_Y);
      loadGraphic( PlayerImage, true, false, 16, 16 );
      
      addAnimation("face_up", [0, 1], 3, true);
      addAnimation("face_down", [2, 3], 3, true);
      addAnimation("face_left", [4, 5], 3, true);
      addAnimation("face_right", [6, 7], 3, true);
      play("face_down");

      width = 14
      height = 14
      offset.x = 1
      offset.y = 1

      drag.x = PLAYER_SPEED * 10;
      drag.y = PLAYER_SPEED * 10;
      maxVelocity.x = PLAYER_SPEED;
      maxVelocity.y = PLAYER_SPEED;
      moves = true;
    }

    protected function checkControls(): void
    {
      if (FlxG.keys.LEFT) {
        walk( FlxSprite.LEFT );
      }
      else if (FlxG.keys.RIGHT) {
        walk( FlxSprite.RIGHT );
      }
      else if (FlxG.keys.UP) {
        walk( FlxSprite.UP );
      }
      else if (FlxG.keys.DOWN) {
        walk( FlxSprite.DOWN );
      }
      else {
        acceleration.x = 0;
        acceleration.y = 0;
      }
    }

    public function walk( dir: int ): void
    {
      facing = dir;
      switch ( dir )
      {
        case LEFT:
          acceleration.x = -drag.x;
          acceleration.y = 0;
          play("face_left");
          break;
        case RIGHT:
          acceleration.x = drag.x;
          acceleration.y = 0;
          play("face_right");
          break;
        case UP:
          acceleration.x = 0;
          acceleration.y = -drag.y;
          play("face_up");
          break;
        case DOWN:
          acceleration.x = 0;
          acceleration.y = drag.y;
          play("face_down");
          break;
        default:
          break;
      }
    }

    public override function update(): void
    {
      checkControls();
      super.update();
    }

  }
}
