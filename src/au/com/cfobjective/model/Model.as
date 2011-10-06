package au.com.cfobjective.model
{
	import com.classsoftware.com.HTML;
	
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;
	import spark.collections.SortField;

	public class Model
	{
		public function Model() {
		}
		
		public static function convertData(xmlSessions:XML, sessions:ArrayCollection, schedule:ArrayCollection, speakers:ArrayCollection):void {
			var newSpeakers:Array = [];
			var newSessions:Array = [];
			var newSchedule:Array = [];
			
			for each (var item:Object in xmlSessions.scheduled) {
				var session:Session;
				var scheduled:Scheduled = new Scheduled();

				var found:Boolean = false;
				for each (var speaker:Speaker in newSpeakers) {
					if (speaker.name == item.speaker.@name) {
						found = true;
						break;
					}
				}
				
				if (!found) {
					speaker = new Speaker(item.speaker.@name, item.speaker.@twitter, item.speaker.@email, HTML.stripTags(item.speaker.toString()), new ArrayCollection());
				}
				
				session = new Session(item.session.@title, speaker, HTML.stripTags(item.session.toString()), item.session.@stream);
				
				if (item.@date == "17/11/2011") {
					scheduled.day = "Thurs";
				}
				else if (item.@date == "18/11/2011") {
					scheduled.day = "Fri";
				}
				
				scheduled.time = item.@time;
				scheduled.session = session;
				scheduled.room = item.@room;
				
				speaker.schedule.addItem(scheduled);
				
				if (item.@sessionType == "session") {
					if (!found) {
						newSpeakers.push(speaker);
					}
					newSessions.push(session);
				}
				else {
					scheduled.linked = false;
				}
				
				newSchedule.push(scheduled);
			}
			
			speakers.source = newSpeakers;
			sessions.source = newSessions;
			schedule.source = newSchedule;
			
			var sort:Sort = new Sort();
			sort.fields = [new SortField("name")];
			speakers.sort = sort;
			speakers.refresh();
			
			sort = new Sort();
			sort.fields = [new SortField("title")];
			sessions.sort = sort;
			sessions.refresh();	
			
			sort = new Sort();
			sort.compareFunction = timeSort;
			schedule.sort = sort;
			schedule.refresh();
		}
		
		private static function timeSort(itemA:Object, itemB:Object, field:Array = null):int {
			var numA:int = 0;
			var numB:int = 0;
			
			if (itemA.day == "Fri") {
				numA += 24*60;
			}
			if (itemB.day == "Fri") {
				numB += 24*60;
			}
			
			if (itemA.time.indexOf("12") != 0 && (itemA.time.indexOf("PM") == 6 || itemA.time.indexOf("PM") == 7)) {
				numA += 12*60;
			}
			
			numA += int(itemA.time.charAt(0))*10*60;
			numA += int(itemA.time.charAt(1))*60;
			numA += int(itemA.time.charAt(3))*10;
			numA += int(itemA.time.charAt(4));
			
			if (itemB.time.indexOf("12") != 0 && (itemB.time.indexOf("PM") == 6 || itemB.time.indexOf("PM") == 7)) {
				numB += 12*60;
			}
			
			numB += int(itemB.time.charAt(0))*10*60;
			numB += int(itemB.time.charAt(1))*60;
			numB += int(itemB.time.charAt(3))*10;
			numB += int(itemB.time.charAt(4));
			
			if (numA == numB) {
				return 0;
			}
			else if (numA < numB) {
				return -1;
			}
			else {
				return 1;
			}
		}
	}
}