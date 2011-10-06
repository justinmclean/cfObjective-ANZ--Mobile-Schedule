package au.com.cfobjective.events
{
	import au.com.cfobjective.model.Session;
	import au.com.cfobjective.model.Speaker;
	
	import flash.events.Event;

	public class SpeakerEvent extends Event
	{
		public static var CHANGE:String = "speakerChange";
		
		private var _speaker:Speaker;
		
		public function SpeakerEvent(type:String, speaker:Speaker, bubbles:Boolean = true) {
			_speaker = speaker;
			
			super(type, bubbles);
		}
		
		public function get speaker():Speaker
		{
			return _speaker;
		}

		override public function clone():Event {
			return new SpeakerEvent(type, speaker, bubbles);
		}
		
	}
}