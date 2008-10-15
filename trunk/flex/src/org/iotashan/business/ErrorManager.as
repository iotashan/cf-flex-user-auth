package org.iotashan.business
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
			
			// just display the error
			myAlert = Alert.show(event.fault.faultDetail,event.fault.faultString);
		}
	}
}