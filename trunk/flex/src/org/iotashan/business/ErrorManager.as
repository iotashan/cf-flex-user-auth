package org.iotashan.business
{
	import mx.controls.Alert;
	import mx.rpc.Fault;
	
	/**
	 * The ErrorManager class exists for handling RemoteObject errors.
	 */
	public class ErrorManager
	{
		/**
		 * The remoteError method is the global non-handled error method.
		 * It just displays the error in an Alert.
		 */
		public function remoteError(fault:Fault):void {
			var myAlert:Alert
			
			// just display the error
			myAlert = Alert.show(fault.message,fault.name);
		}
	}
}