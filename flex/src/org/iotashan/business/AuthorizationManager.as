package org.iotashan.business {
	import flash.events.EventDispatcher;
	
	import org.iotashan.events.LoginEvent;
	import org.iotashan.vos.User;
	
	public class AuthorizationManager extends EventDispatcher {
		public function login(val:Object):void {
			var resultUser:User = val as User;
			var myEvent:LoginEvent;
			
			if (resultUser.UserID == 0) {
				// login failed
				myEvent = new LoginEvent(LoginEvent.LOGIN_UNSUCCESSFUL);
				myEvent.user = resultUser;
				dispatchEvent(myEvent);
			} else {
				// login succeded
				myEvent = new LoginEvent(LoginEvent.LOGIN_SUCCESSFUL);
				myEvent.user = resultUser;
				dispatchEvent(myEvent);
			}
		}
	}
}