package org.iotashan.events
{
	import flash.events.Event;
	import org.iotashan.vos.User;
	
	/**
	 * The LoginEvent class handles logging in and out.
	 */
	public class LoginEvent extends Event
	{
		// Constants
		public static const LOGIN:String = "loginEvent";
		public static const LOGOUT:String = "logoutEvent";
		public static const LOGIN_SUCCESSFUL:String = "loginSuccessfulEvent";
		public static const LOGIN_UNSUCCESSFUL:String = "loginUnsuccessfulEvent";
		
		// Properties
		/**
		 * The user property is used for logging in.
		 * @default null
		 */
		public var user:User;
		
		public function LoginEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}