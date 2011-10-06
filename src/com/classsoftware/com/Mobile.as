package com.classsoftware.com
{
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	import flash.system.Capabilities;

	public class Mobile
	{	
		private static function activeInterface(name:String):Boolean {
			var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
			var interfaces:Vector.<NetworkInterface>;
			
			// Not supported on all mobiel devices so need to check
			if(!NetworkInfo.isSupported) {
				// assume it is and give it a try
				return true;
			}
			
			interfaces = networkInfo.findInterfaces();
			for (var i:int = 0; i < interfaces.length; i++) {
				if (interfaces[i].name.toLowerCase() == name && interfaces[i].active) {
					return true;
				}
			}
			
			return false;		
		}
		
		public static function wifiConnected():Boolean {
			return activeInterface("wifi") || activeInterface("en0") || activeInterface("en1"); // en0/en1 for desktop testing
		}
		
		public static function mobileConnected():Boolean {
			return activeInterface("mobile");
		}
		
		public static function hasConnection():Boolean {
			return wifiConnected() || mobileConnected();
		}
		
		public static function isTablet():Boolean {
			return Capabilities.screenResolutionX/Capabilities.screenDPI >= 7 || Capabilities.screenResolutionY/Capabilities.screenDPI >= 7;
		}
		
		public static function isPhone():Boolean {
			return !isTablet();
		}
	}
}