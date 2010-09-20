package {

  import mx.utils.Base64Decoder;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

  public class TmxLayer
  {
    public var width:uint;
    public var height:uint;
    public var tiles:Array = [];
    public var properties:Object = {};

    public function TmxLayer( node:XML )
    {
      width = node.@width;
      height = node.@height;
      for each(var prop:XML in node.properties.property) {
        trace( prop.@name );
        trace( prop.@value );
        properties[prop.@name] = prop.@value;
      }
      var datanode:XML = node.data[0];
      var encoding:String = datanode.@encoding;
      var compression:String = datanode.@compression;
      trace( encoding );
      trace( compression );
      if ( (encoding == "base64") && (compression == "zlib") ) {
        loadB64ZLib( datanode );
      }
    }

    protected function loadB64ZLib( datanode:XML ): void
    {
      trace("TxmLayer.loadB64ZLib");
      var chunk:String = datanode;
      var b64:Base64Decoder = new Base64Decoder();
      b64.decode(chunk);
      var tdata:ByteArray = b64.toByteArray();
      tdata.uncompress();
			tdata.endian = Endian.LITTLE_ENDIAN;
      trace( tdata.length );
      var offset: int = properties['layeroffset']
			while (tdata.position < tdata.length) {
        var d: int = tdata.readInt();
        d -= offset;
        tiles.push(d);
			}
    }

    public function at( x: int, y: int ): int
    {
      var ind: int = (width * y) + x;
      return tiles[ind];
    }

    public function blockedAt( x: int, y: int ): Boolean
    {
      return at(x,y) == 15;
    }

    public function find( tile: int ): Object
    {
      var x: int;
      var y: int = 0;
      while ( y < height ) {
        x = 0;
        while ( x < width ) {
          if ( at(x, y) == tile ) {
            var obj: Object = new Object();
            obj.x = x;
            obj.y = y;
            return obj;
          }
          x += 1;
        }
        y += 1;
      }
      return null;
    }

    public function toCSV(): String
    {
      return toAdjustedCSV(false, 0);
    }

    public function toCollisionWorthyCSV(): String
    {
      return toAdjustedCSV(true, 15);
    }

    protected function toAdjustedCSV( clamp: Boolean, clampId: int ): String
    {
      trace( tiles.length );
      var layer:String = "";
      var x:uint = 0;
      var newl:Boolean = true;
      var i:uint = 0;
      var val:uint = 0;
      while ( i < tiles.length ) {
        if ( newl ) {
          newl = false;
        }
        else {
          layer += ",";
        }
        val = tiles[i];
        if ( clamp && val != clampId ) val = 0;
        layer += val;
        i += 1;
        x += 1;
        if ( x == width ) {
          layer += "\n";
          x = 0;
          newl = true;
        }
      }
      return layer;
    }
  }
}
