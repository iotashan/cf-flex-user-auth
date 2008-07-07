<cfcomponent output="false" alias="model.User">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="UserID" type="numeric" default="0">
	<cfproperty name="email" type="string" default="">
	<cfproperty name="password" type="string" default="">
	<cfproperty name="verificationCode" type="string" default="">

	<cfscript>
		//Initialize the CFC with the default properties values.
		this.UserID = 0;
		this.email = "";
		this.password = "";
		this.verificationCode = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="User">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getUserID" output="false" access="public" returntype="any">
		<cfreturn this.UserID>
	</cffunction>

	<cffunction name="setUserID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset this.UserID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getEmail" output="false" access="public" returntype="any">
		<cfreturn this.Email>
	</cffunction>

	<cffunction name="setEmail" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset this.Email = arguments.val>
	</cffunction>

	<cffunction name="getPassword" output="false" access="public" returntype="any">
		<cfreturn this.Password>
	</cffunction>

	<cffunction name="setPassword" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset this.Password = arguments.val>
	</cffunction>

	<cffunction name="getVerificationCode" output="false" access="public" returntype="any">
		<cfreturn this.VerificationCode>
	</cffunction>

	<cffunction name="setVerificationCode" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset this.VerificationCode = arguments.val>
	</cffunction>
</cfcomponent>