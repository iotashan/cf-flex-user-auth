package org.iotashan.events
{
	import flash.events.Event;
	import org.iotashan.vos.User;
	
	/**
	 * The AccountEvent class handles creating and activating new accounts.
	 */
	public class AccountEvent extends Event
	{
		// Constants
		public static const CHECK_USERNAME:String = "checkUsernameEvent";
		public static const CREATE_ACCOUNT:String = "createAccountEvent";
		public static const CREATION_FINISHED:String = "creationFinishedEvent";
		public static const SAVE_ACCOUNT:String = "saveAccountEvent";
		public static const ACCOUNT_NOT_ACTIVE:String = "accountNotActiveEvent";
		public static const RESEND_ACTIVATION:String = "resendActivationEvent";
		public static const ACTIVATE_ACCOUNT:String = "activateAccountEvent";
		
		// Properties
		/**
		 * The user property is used for creating new accounts.
		 * @default null
		 */
		public var user:User;
		
		/**
		 * The email property is used during signup, 
		 * to see if the email address is already in use.
		 * @default null
		 */
		public var email:String;
		
		/**
		 * The verificationCode property is used to activate the account.
		 * @default null
		 */
		public var verificationCode:String;
		
		/**
		 * Constructor method.
		 */
		public function AccountEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}