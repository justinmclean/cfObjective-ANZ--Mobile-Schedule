package au.com.cfobjective.model
{
	import mx.core.FlexGlobals;

	[Bindable] 
	public class Session
	{
		public var title:String;
		public var speaker:Speaker;
		public var description:String;
		public var stream:String;
		
		[Embed(source="assets/icons/CF32x32.png")]
		public static var CFTinyIcon:Class;
		[Embed(source="assets/icons/FX32x32.png")]
		public static var FXTinyIcon:Class;
		[Embed(source="assets/icons/OT32x32.png")]
		public static var OTTinyIcon:Class;
		
		[Embed(source="assets/icons/CF64x64.png")]
		public static var CFIcon:Class;
		[Embed(source="assets/icons/FX64x64.png")]
		public static var FXIcon:Class;
		[Embed(source="assets/icons/OT64x64.png")]
		public static var OTIcon:Class;
		
		public function Session(title:String, speaker:Speaker, description:String, stream:String) {
			this.title = title;
			this.speaker = speaker;
			this.description = description;
			this.stream = stream;
		}
		
		public function get listIcon():Class {
			var dpi:Number = FlexGlobals.topLevelApplication.runtimeDPI;
			
			if (dpi >= 240) {
				return viewIcon;
			}
			
			switch (stream) {
				case "Flex":
					return FXTinyIcon;
				case "ColdFusion":
					return CFTinyIcon;
				default:
					return OTTinyIcon;
			}
		}
		
		public function get viewIcon():Class {
			switch (stream) {
				case "Flex":
					return FXIcon;
				case "ColdFusion":
					return CFIcon;
				default:
					return OTIcon;
			}
		}
	}
}