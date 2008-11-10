package org.iotashan.business
{
	public class ErrorManager
	{
		import mx.controls.Alert;
		import mx.rpc.Fault;
		
		public function remoteError(fault:Fault):void {
			var myAlert:Alert
			
			// just display the error
			myAlert = Alert.show(fault.message,fault.name);
		}
	}
}