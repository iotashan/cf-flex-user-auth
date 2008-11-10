package org.iotashan.events {
	import flash.events.Event;
	
	import org.iotashan.vos.User;

	public class AccountEvent extends Event {
		// Constants
		public static const CHECK_USERNAME:String = "checkUsernameEvent";
		public static const CREATE_ACCOUNT:String = "createAccountEvent";
		public static const SAVE_ACCOUNT:String = "saveAccountEvent";
		public static const RESEND_ACTIVATION:String = "resendActivationEvent";
		public static const ACTIVATE_ACCOUNT:String = "activateAccountEvent";
		
		// Properties
		public var user:User;
		public var email:String;
		public var verificationCode:String;
		
		public function AccountEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}