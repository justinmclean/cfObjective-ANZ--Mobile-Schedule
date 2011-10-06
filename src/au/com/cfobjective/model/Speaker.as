package au.com.cfobjective.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Speaker
	{
		public var name:String;
		public var twitter:String;
		public var email:String;
		public var bio:String;
		public var schedule:ArrayCollection;
		
		public function Speaker(name:String, twitter:String, email:String, bio:String, schedule:ArrayCollection) {
			this.name = name;
			this.twitter = twitter;
			this.email = email;
			this.bio = bio;
			this.schedule = schedule;
		}
	}
}