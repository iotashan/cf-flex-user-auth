package org.iotashan.business {
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	
	import org.iotashan.vos.User;

	public class UserManager extends EventDispatcher {
		private var _user:User = new User();
		
		[Bindable (event="userChange")]
		public function get user():User {
			return _user;
		}
		
		public function storeUser(tmpUser:User):void {
			if (tmpUser != _user) {
				_user = tmpUser;
			}
		}
		
		public function logout():void {
			// notify the user they have loged out
			Alert.show("You have logged out","Log Out");
			// reset the user data
			_user = new User();
		}
	}
}