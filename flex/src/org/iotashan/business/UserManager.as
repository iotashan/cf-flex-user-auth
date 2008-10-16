package org.iotashan.business {
	import flash.events.EventDispatcher;
	
	import org.iotashan.vos.User;

	public class UserManager extends EventDispatcher {
		private var _user:User;
		
		[Bindable (event="userChange")]
		public function get user():User {
			return _user;
		}
		
		public function storeUser(val:Object):void {
			var tmpUser:User = val as User;
			
			if (tmpUser != _user) {
				_user = tmpUser;
			}
		}
	}
}