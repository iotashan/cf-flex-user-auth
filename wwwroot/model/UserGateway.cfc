<cfcomponent output="false">

	<cffunction name="tryLogin" output="false" access="remote" returntype="model.User">
		<cfargument name="obj" type="model.User" required="true" />
 		
		<cfscript>
			// hash the password
			ARGUMENTS.obj.password = encrypt(ARGUMENTS.obj.password,REQUEST.secretKey);
			
			// check the login
			qLogin = createObject("component", "UserDAO").tryLogin(ARGUMENTS.obj);
			
			if (qLogin.recordcount) {
				// return a User if there was a match
				return getByID(qLogin.userID);
			} else {
				// clear session and password, return empty user
				ARGUMENTS.obj.userID = 0;
				ARGUMENTS.obj.password = "";
				
				return ARGUMENTS.obj;
			}
		</cfscript>
	</cffunction>

	<cffunction name="isUsernameAvailable" output="false" access="remote" returntype="boolean">
		<cfargument name="username" type="string" required="true" />
 		<cfreturn createObject("component", "UserDAO").isUsernameAvailable(arguments.username)>
	</cffunction>

	<cffunction name="getById" output="false" access="remote" returntype="model.User">
		<cfargument name="id" type="numeric" required="true" />
 		<cfreturn createObject("component", "UserDAO").read(arguments.id)>
	</cffunction>

	<cffunction name="save" output="false" access="remote" returntype="model.User">
		<cfargument name="obj" type="model.User" required="true" />
 		<cfscript>
			if( obj.getUserID() eq 0 )
			{
				return createObject("component", "UserDAO").create(arguments.obj);
			} else {
				return createObject("component", "UserDAO").update(arguments.obj);
			}
		</cfscript>
	</cffunction>


	<cffunction name="deleteById" output="false" access="remote" returntype="void">
		<cfargument name="id" type="numeric" required="true" />
		<cfset var obj = getById(arguments.id)>
		<cfset createObject("component", "UserDAO").delete(obj)>
	</cffunction>



	<cffunction name="getAll" output="false" access="remote" returntype="model.User[]">
		<cfset var qRead="">
		<cfset var obj="">
		<cfset var ret=arrayNew(1)>

		<cfquery name="qRead" datasource="#REQUEST.dsn#">
			SELECT UserID
			FROM users
		</cfquery>

		<cfloop query="qRead">
		<cfscript>
			obj = createObject("component", "UserDAO").read(qRead.UserID);
			ArrayAppend(ret, obj);
		</cfscript>
		</cfloop>
		<cfreturn ret>
	</cffunction>



	<cffunction name="getAllAsQuery" output="false" access="remote" returntype="query">
		<cfargument name="fieldlist" default="*" hint="List of columns to be returned in the query.">

		<cfset var qRead="">

		<cfquery name="qRead" datasource="#REQUEST.dsn#">
			SELECT #arguments.fieldList#
			FROM users
		</cfquery>

		<cfreturn qRead>
	</cffunction>




</cfcomponent>