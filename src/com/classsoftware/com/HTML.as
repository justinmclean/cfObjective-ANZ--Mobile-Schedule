package com.classsoftware.com
{
	public class HTML
	{
		public function HTML() {
		}
		
		
		public static function stripTags(html:String):String {	
			var toBeRemoved:Array = html.match(new RegExp("<([^>]+)>", "g"));
			
			for each (var tag:String in toBeRemoved) {
				switch (tag) {
					case "</p>":
					case "<br />":
						html = html.replace(tag, "\n");
						break;
					default:
						html = html.replace(tag, "");
				}
			} 
			
			toBeRemoved = html.match(new RegExp("&([^;]+);", "g"));
			
			for each (tag in toBeRemoved) {
				switch (tag) {
					case "&nbsp;":
						html = html.replace(tag, " ");
						break;
					case "&amp;":
						html = html.replace(tag, "&");
						break;
					default:
						html = html.replace(tag, "");
				}
			} 
			
			return html;
		}
	}
}