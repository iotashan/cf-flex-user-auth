package org.iotashan.business
{
	import flash.events.EventDispatcher;
	import mx.controls.Alert;
	import org.iotashan.vos.User;
	
	/**
	 * The UserManager class is for holding the logged in user's properties.
	 * It also handles logging out, which does not require a trip to the server.
	 */
	public class UserManager extends EventDispatcher
	{
		/**
		 * @private
		 * The _user property is for internal use only.
		 */
		private var _user:User = new User();
		
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