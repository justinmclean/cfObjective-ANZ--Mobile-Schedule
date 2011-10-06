package au.com.cfobjective.events
{
	import au.com.cfobjective.model.Session;
	
	import flash.events.Event;

	public class SessionEvent extends Event
	{
		public static var CHANGE:String = "sessionChange";
		public static var RATE:String = "sessionRate";
		
		private var _session:Session;
		
		public function SessionEvent(type:String, session:Session, bubbles:Boolean = true) {
			_session = session;
			
			super(type, bubbles);
		}
		
		public function get session():Session
		{
			return _session;
		}

		override public function clone():Event {
			return new SessionEvent(type, session, bubbles);
		}
		
	}
}