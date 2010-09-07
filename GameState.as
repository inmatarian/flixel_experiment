package
{
  import org.flixel.*;
	import flash.utils.ByteArray;
  
  public class GameState extends FlxState
  {
    [Embed(source="data/test_waymap.tmx", mimeType="application/octet-stream")]
    protected var WaymapTMX:Class;
    
    [Embed(source="data/wayward0.png")]
    protected var WaywardTiles:Class;

    protected var player:Player = null;
    protected var floorLayer:FlxTilemap = null;
    protected var objectLayer:TmxLayer = null;
    
    public override function create(): void
    {
      // levelBlocks.add(this.add(new FlxBlock(0,640-24,640,8,TechTilesImage)));
      
      var bytes:ByteArray = new WaymapTMX();
      var waymapxml:XML = new XML(bytes.readUTFBytes(bytes.length));
      var tmxloader:TmxLoader = new TmxLoader( waymapxml );
      var csv:String = tmxloader.layers['Floor'].toCSV();
      trace( csv );

      objectLayer = tmxloader.layers['Collision'];

      floorLayer = new FlxTilemap();
      floorLayer.loadMap( csv, WaywardTiles, 16, 16 );
      add( floorLayer );

      player = new Player();
      var landingZone: Object = objectLayer.find(16);
      if (landingZone) {
        player.x = landingZone.x * 16;
        player.y = landingZone.y * 16;
      }
      add(player);

      FlxG.follow(player, 8);
    }

    public function blocked( spr: FlxSprite, dir: int ): Boolean
    {
      var xTest: int = Math.floor( spr.x / 16 );
      var yTest: int = Math.floor( spr.y / 16 );
      switch (dir) {
        case FlxSprite.LEFT: xTest-=1; break;
        case FlxSprite.RIGHT: xTest+=1; break;
        case FlxSprite.UP: yTest-=1; break;
        case FlxSprite.DOWN: yTest+=1; break;
        default: break;
      }
      var block: Boolean = objectLayer.blockedAt( xTest, yTest );
      trace( block );
      return block;
    }
    
    protected function checkControls(): void
    {
      if (FlxG.keys.LEFT && !blocked(player, FlxSprite.LEFT) )
      {
        player.walk( FlxSprite.LEFT );
      }
      else if (FlxG.keys.RIGHT && !blocked(player, FlxSprite.RIGHT) )
      {
        player.walk( FlxSprite.RIGHT );
      }
      else if (FlxG.keys.UP && !blocked(player, FlxSprite.UP) )
      {
        player.walk( FlxSprite.UP );
      }
      else if (FlxG.keys.DOWN && !blocked(player, FlxSprite.DOWN) )
      {
        player.walk( FlxSprite.DOWN );
      }
    }

    public override function update(): void
    {
      checkControls();
      super.update();
      // FlxG.collideArray(levelBlocks, player);
    }

  }
}
