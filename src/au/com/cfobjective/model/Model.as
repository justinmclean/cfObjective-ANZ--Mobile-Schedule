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
			
			for each (var scheduleXML:Object in xmlSessions.scheduled) {
				var session:Session;
				var scheduled:Scheduled = new Scheduled();
				var talkSpeakers:ArrayCollection = new ArrayCollection();

				for each (var speakerXML:Object in scheduleXML.speaker) {
					var found:Boolean = false;
					for each (var speaker:Speaker in newSpeakers) {
						if (speaker.name == speakerXML.@name) {
							found = true;
							break;
						}
					}
				
					if (!found) {
						speaker = new Speaker(speakerXML.@name, speakerXML.@twitter, speakerXML.@email, HTML.stripTags(speakerXML.toString()), new ArrayCollection());
						
						if (scheduleXML.@sessionType == "session") {
							newSpeakers.push(speaker);
						}
					}
					
					talkSpeakers.addItem(speaker);
				}
				
				session = new Session(scheduleXML.session.@title, talkSpeakers, HTML.stripTags(scheduleXML.session.toString()), scheduleXML.session.@stream);
				
				if (scheduleXML.@date == Conference.DATES[0]) {
					scheduled.day = Conference.DAYS[0];
				}
				else if (scheduleXML.@date == Conference.DATES[1]) {
					scheduled.day = Conference.DAYS[1];
				}
				
				scheduled.time = scheduleXML.@time;
				scheduled.session = session;
				scheduled.room = scheduleXML.@room;
				
				for each (speaker in talkSpeakers) {
					speaker.schedule.addItem(scheduled);
				}
				
				if (scheduleXML.@sessionType == "session") {
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