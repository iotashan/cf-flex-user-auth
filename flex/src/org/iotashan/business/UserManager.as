package org.iotashan.business
{
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	import org.iotashan.events.AccountEvent;
	import org.iotashan.events.LoginEvent;
	import org.iotashan.vos.User;
	
	/**
	 * The UserManager class is for holding the logged in user's properties.
	 * It also handles logging out, which does not require a trip to the server.
	 */
	public class UserManager
	{
		/**
		 * @private
		 * The _user property is for internal use only.
		 */
		private var _user:User = new User();
		private var _eventDispatcher:IEventDispatcher;
		
		/**
		 * Constructor method, takes event dispatcher
		 */
		public function UserManager(ed:IEventDispatcher):void {
			_eventDispatcher = ed;
		}
		
		/**
		 * The user property holds the current logged in user's information for the application.
		 * It is set via storeUser()
		 * 
		 * @default null
		 */
		[Bindable (event="userChange")]
		public function get user():User {
			return _user;
		}
		
		/**
		 * The storeUser method sets the user property
		 */
		public function storeUser(tmpUser:User):void {
			if (tmpUser != _user) {
				_user = tmpUser;
			}
		}
		
		/**
		 * The checkLogin() method tests the return from the server to see if the user is logged in
		 */
		public function checkLogin(resultUser:User):void {
			if (resultUser.UserID == 0) {
				// the username/password do not work
				_eventDispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_UNSUCCESSFUL));
			} else if (resultUser.verificationCode.length > 0) {
				// the username/password are correct, but the account is not active.
				var accountEvent:AccountEvent = new AccountEvent(AccountEvent.ACCOUNT_NOT_ACTIVE);
				accountEvent.user = resultUser;
				_eventDispatcher.dispatchEvent(accountEvent);
			}else {
				// login successful, so save the user
				storeUser(resultUser);
				_eventDispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_SUCCESSFUL));
			}
		}
		
		/**
		 * The logout() method clears out the user property and displays a log out Alert.
		 */
		public function logout():void {
			// notify the user they have loged out
			Alert.show("You have logged out","Log Out");
			// reset the user data
			_user = new User();
		}
	}
}