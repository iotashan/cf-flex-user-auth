package org.iotashan.business {
	import flash.events.EventDispatcher;
	
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
			_user = new User();
		}
	}
}