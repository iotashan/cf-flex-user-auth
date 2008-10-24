package org.iotashan.events {
	import flash.events.Event;
	
	import org.iotashan.vos.User;

	public class AccountEvent extends Event {
		// Constants
		public static const CREATE_ACCOUNT:String = "createAccountEvent";
		
		// Properties
		public var user:User;
		
		public function AccountEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}