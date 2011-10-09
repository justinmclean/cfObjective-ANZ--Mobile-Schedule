package au.com.cfobjective.model
{
	[Bindable]
	public class Scheduled
	{
		public var day:String; // Thurs or Fri
		public var room:String;
		public var time:String;
		public var session:Session;
		public var linked:Boolean;
		
		public function Scheduled(day:String = null, room:String = null, time:String = null, session:Session = null, linked:Boolean = true) {
			this.day = day;
			this.room = room;
			this.time = time;
			this.session = session;
			this.linked = linked
		}
		
		public function get timeAndLocation():String {
			if (room) {
				return time + " in " + room;
			}
			else {
				return time;
			}
		}
		
		public function get details():String {
			var details:String = "";
			details = session.title;
			
			for each (var speaker:Speaker in session.speakers) {
				details += "\n" + speaker.name;
			}
			
			return details;
		}
		
		public function get listIcon():Class {
			if (linked) {
				return session.listIcon;
			}

			return null;
		}
		
		public function get viewIcon():Class {
			return session.viewIcon;
		}
	}
}