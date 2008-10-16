package org.iotashan.events {
	import flash.events.Event;
	
	import org.iotashan.vos.User;

	public class LoginEvent extends Event {
		// Constants
		public static const LOGIN:String = "loginEvent";
		public static const LOGOUT:String = "logoutEvent";
		public static const LOGIN_SUCCESSFUL:String = "loginSuccessfulEvent";
		
		// Properties
		public var user:User;
		
		public function LoginEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}