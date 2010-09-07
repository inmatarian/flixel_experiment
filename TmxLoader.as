package {

  public class TmxLoader
  {
    public var width:uint;
    public var height:uint;
		public var properties:Object = {};
		public var layers:Object = {};
		public var tileSets:Object = {};

    public function TmxLoader( src:XML )
    {
			width = src.@width;
			height = src.@height;
      
			var node:XML = null;
			for each(node in src.properties.property) {
        trace(node.@name);
        trace(node.@value);
        properties[node.@name] = node.@value;
      }

			for each(node in src.layer) {
        trace(node.@name);
				layers[node.@name] = new TmxLayer(node);
      }
    }

  }

}

