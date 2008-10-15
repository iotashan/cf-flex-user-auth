package org.iotashan.model
{
	[RemoteClass(alias="model.User")]

	[Bindable]
	public class User
	{

		public var UserID:Number = 0;
		public var email:String = "";
		public var password:String = "";
		public var verificationCode:String = "";


		public function User()
		{
		}

	}
}