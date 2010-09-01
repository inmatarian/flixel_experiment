package
{
  import org.flixel.*;
  
  public class Player extends FlxSprite
  {
    [Embed(source="data/sylvia/sylvia.png")] 
    protected var PlayerImage:Class;
    
    protected static const PLAYER_START_X:int = 100;
    protected static const PLAYER_START_Y:int = 100;

    protected var targetPos: FlxPoint; 
    protected var inMovement: Boolean;
    protected var movingDir: uint;

    public function Player()
    {
      super(PLAYER_START_X, PLAYER_START_Y);
      loadGraphic( PlayerImage, true, false, 16, 16 );
      
      addAnimation("face_up", [0, 1], 3, true);
      addAnimation("face_down", [2, 3], 3, true);
      addAnimation("face_left", [4, 5], 3, true);
      addAnimation("face_right", [6, 7], 3, true);
      play("face_down");

      targetPos = new FlxPoint(x, y)
      inMovement = false;
      moves = false
    }
    
    public override function update():void
    {
      if (!inMovement) {
        if(FlxG.keys.LEFT)
        {
          facing = LEFT;
          movingDir = LEFT;
          play("face_left");
          targetPos.x -= 16;
          inMovement = true;
        }
        else if(FlxG.keys.RIGHT)
        {
          facing = RIGHT;
          movingDir = RIGHT;
          play("face_right");
          targetPos.x += 16;
          inMovement = true;
        }
        else if(FlxG.keys.UP)
        {
          facing = UP;
          movingDir = UP;
          play("face_up");
          targetPos.y -= 16;
          inMovement = true;
        }
        else if(FlxG.keys.DOWN)
        {
          facing = DOWN;
          movingDir = DOWN;
          play("face_down");
          targetPos.y += 16;
          inMovement = true;
        }
      }

      if ( inMovement )
      {
        var dist:int = FlxG.elapsed * 100;
        switch ( movingDir )
        {
          case LEFT:
            x -= dist;
            if ( x < targetPos.x ) {
              x = targetPos.x;
              inMovement = false;
            }
            break;

          case RIGHT:
            x += dist;
            if ( x > targetPos.x ) {
              x = targetPos.x;
              inMovement = false;
            }
            break;

          case UP:
            y -= dist;
            if ( y < targetPos.y ) {
              y = targetPos.y;
              inMovement = false;
            }
            break;

          case DOWN:
            y += dist;
            if ( y > targetPos.y ) {
              y = targetPos.y;
              inMovement = false;
            }
            break;

          default: break;
        }
      }

      super.update();
    }

  }
}
