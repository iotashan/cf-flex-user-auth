package org.iotashan.control
{
	public class ErrorManager
	{
		import mx.rpc.events.FaultEvent;
		import mx.messaging.messages.ErrorMessage;
		import mx.managers.CursorManager;
		import mx.controls.Alert;
		import flash.net.*;
		import mx.events.CloseEvent;
		
		public static function remoteError(event:FaultEvent):void {
			var vMessage:ErrorMessage = event.message as ErrorMessage;
			var myAlert:Alert
			
			// just display the error for now, we'll sort out error codes later
			myAlert = Alert.show(event.fault.faultDetail,event.fault.faultString);
		}

        private static function alertListener(eventObj:CloseEvent):void {
            // Check to see if the OK button was pressed, then reload the application.
			var request:URLRequest = new URLRequest("javascript:reloadPage()");
			navigateToURL(request,"_self");
        }
	}
}