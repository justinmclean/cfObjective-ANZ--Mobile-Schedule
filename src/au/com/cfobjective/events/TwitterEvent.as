package au.com.cfobjective.events
{
	import au.com.cfobjective.model.Session;
	
	import flash.events.Event;

	public class TwitterEvent extends Event
	{
		public static var CHANGE:String = "twitterChange";
		
		private var _tweetName:String;
		
		public function TwitterEvent(type:String, tweetName:String, bubbles:Boolean = true) {
			_tweetName = tweetName;
			
			super(type, bubbles);
		}
		
		public function get tweetName():String
		{
			return _tweetName;
		}

		override public function clone():Event {
			return new TwitterEvent(type, tweetName, bubbles);
		}
		
	}
}