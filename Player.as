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
    protected static const GRID_SIZE: int = 16;

    protected var walkDir: int;
    protected var walkHeld: Boolean;
    protected var xTarget: int;
    protected var yTarget: int;

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

      moves = true;
      walkDir = -1;
    }

    protected function checkControls(): void
    {
      if ( walkDir == -1 ) {
        if (FlxG.keys.LEFT) {
          walk( FlxSprite.LEFT );
          walkHeld = true;
        }
        else if (FlxG.keys.RIGHT) {
          walk( FlxSprite.RIGHT );
          walkHeld = true;
        }
        else if (FlxG.keys.UP) {
          walk( FlxSprite.UP );
          walkHeld = true;
        }
        else if (FlxG.keys.DOWN) {
          walk( FlxSprite.DOWN );
          walkHeld = true;
        }
      }
      else {
        switch (walkDir) {
          case LEFT:  if ( !FlxG.keys.LEFT )  walkHeld = false; break;
          case RIGHT: if ( !FlxG.keys.RIGHT ) walkHeld = false; break;
          case UP:    if ( !FlxG.keys.UP )    walkHeld = false; break;
          case DOWN:  if ( !FlxG.keys.DOWN )  walkHeld = false; break;
        }
      }
    }

    public function walk( dir: int ): void
    {
      walkDir = dir;
      facing = dir;
      switch ( dir )
      {
        case LEFT:
          xTarget = x -GRID_SIZE;
          yTarget = y;
          velocity.x = -PLAYER_SPEED;
          play("face_left");
          break;
        case RIGHT:
          xTarget = x + GRID_SIZE;
          yTarget = y;
          velocity.x = PLAYER_SPEED;
          play("face_right");
          break;
        case UP:
          xTarget = x;
          yTarget = y - GRID_SIZE;
          velocity.y = -PLAYER_SPEED;
          play("face_up");
          break;
        case DOWN:
          xTarget = x;
          yTarget = y + GRID_SIZE;
          velocity.y = PLAYER_SPEED;
          play("face_down");
          break;
        default:
          break;
      }
    }

    public function clamp( xT: int, yT: int ): void
    {
      x = FlxU.floor( xT / GRID_SIZE ) * GRID_SIZE;
      y = FlxU.floor( yT / GRID_SIZE ) * GRID_SIZE;
      walkDir = -1;
      velocity.x = 0;
      velocity.y = 0;
    }

    public function correctMovement(): void
    {
      switch ( walkDir )
      {
        case LEFT:
          if ( velocity.x == 0 ) {
            clamp(x, y);
          }
          else if ( x < xTarget ) {
            if ( walkHeld ) xTarget -= GRID_SIZE;
            else clamp( xTarget, y );
          }
          break;

        case RIGHT:
          if ( velocity.x == 0 ) {
            clamp(x, y);
          }
          else if ( x > xTarget ) {
            if ( walkHeld ) xTarget += GRID_SIZE;
            else clamp( xTarget, y );
          }
          break;

        case UP:
          if ( velocity.y == 0 ) {
            clamp(x, y);
          }
          else if ( y < yTarget ) {
            if ( walkHeld ) yTarget -= GRID_SIZE;
            else clamp( x, yTarget );
          }
          break;

        case DOWN:
          if ( velocity.y == 0 ) {
            clamp(x, y);
          }
          else if ( y > yTarget ) {
            if ( walkHeld ) yTarget += GRID_SIZE;
            else clamp( x, yTarget );
          }
          break;

        default:
          break;
      }
    }

    public override function update(): void
    {
      checkControls();
      super.update();
      correctMovement();
    }

  }
}
