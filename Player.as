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

    protected var xMove: Number;
    protected var yMove: Number;

    public function Player()
    {
      super(PLAYER_START_X, PLAYER_START_Y);
      loadGraphic( PlayerImage, true, false, 16, 16 );
      
      addAnimation("face_up", [0, 1], 3, true);
      addAnimation("face_down", [2, 3], 3, true);
      addAnimation("face_left", [4, 5], 3, true);
      addAnimation("face_right", [6, 7], 3, true);
      play("face_down");

      xMove = 0;
      yMove = 0;
      moves = false;
    }

    protected function checkMoving(): void
    {
      var goDist: Number = PLAYER_SPEED * FlxG.elapsed;
      var xDist: Number = ( xMove < 0 ? -1 : ( xMove > 0 ? 1 : 0 ) ) * goDist;
      if ( Math.abs( xDist ) > Math.abs( xMove ) ) xDist = xMove;
      x += xDist;
      xMove -= xDist;
      var yDist: Number = ( yMove < 0 ? -1 : ( yMove > 0 ? 1 : 0 ) ) * goDist;
      if ( Math.abs( yDist ) > Math.abs( yMove ) ) yDist = yMove;
      y += yDist;
      yMove -= yDist;
    }

    public function walk( dir: int ): void
    {
      if ( xMove != 0 || yMove != 0 ) return;

      facing = dir;
      switch ( dir )
      {
        case LEFT:
          xMove = -16;
          play("face_left");
          break;
        case RIGHT:
          xMove = 16;
          play("face_right");
          break;
        case UP:
          yMove = -16;
          play("face_up");
          break;
        case DOWN:
          yMove = 16;
          play("face_down");
          break;
        default:
          break;
      }
    }

    public override function update(): void
    {
      checkMoving();
      super.update();
    }

  }
}
