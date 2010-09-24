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
    protected var ceilingLayer:FlxTilemap = null;
    protected var objectLayer:FlxTilemap = null;
    
    public override function create(): void
    {
      var bytes:ByteArray = new WaymapTMX();
      var waymapxml:XML = new XML(bytes.readUTFBytes(bytes.length));
      var tmxloader:TmxLoader = new TmxLoader( waymapxml );

      var csv:String = tmxloader.layers['Floor'].toCSV();
      floorLayer = new FlxTilemap();
      floorLayer.loadMap( csv, WaywardTiles, 16, 16 );
      floorLayer.solid = false;
      add( floorLayer );

      csv = tmxloader.layers['Ceiling'].toCSV();
      ceilingLayer = new FlxTilemap();
      ceilingLayer.loadMap( csv, WaywardTiles, 16, 16 );
      ceilingLayer.solid = false;
      add( ceilingLayer );

      var objTmx: TmxLayer = tmxloader.layers['Collision'];
      csv = objTmx.toCollisionWorthyCSV();
      objectLayer = new FlxTilemap();
      objectLayer.loadMap( csv, WaywardTiles, 16, 16 );
      objectLayer.visible = false;
      objectLayer.follow();
      add( objectLayer );

      player = new Player();
      var landingZone: Object = objTmx.find(16);
      if (landingZone) {
        player.x = landingZone.x * 16;
        player.y = landingZone.y * 16;
      }
      add(player);

      FlxG.follow(player, 8);
    }

/*
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
*/
  
    public override function update(): void
    {
      super.update();
      collide();
    }

  }
}
