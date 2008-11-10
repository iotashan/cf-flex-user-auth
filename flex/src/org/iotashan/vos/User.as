package org.iotashan.vos
{
	[RemoteClass(alias="model.User")]
	
	/**
	 * The User class defines properties for a User
	 */
	[Bindable]
	public class User
	{
		/**
		 * The UserID property is the unique identifer for the User
		 */
		public var UserID:Number = 0;
		
		/**
		 * The email property holds the user's email address
		 */
		public var email:String = "";
		
		/**
		 * The password property is a hashed string.
		 * It is only not encrypted when a new user is being signed up.
		 */
		public var password:String = "";
		
		/**
		 * The verificationCode property is used to confirm a user account.
		 * If the string is not empty, then the account still needs to be verified.
		 */
		public var verificationCode:String = "";

		/**
		 * Constructor method.
		 */
		public function User()
		{
		}
	}
}