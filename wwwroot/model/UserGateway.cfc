<cfcomponent output="false">

	<cffunction name="tryLogin" output="false" access="remote" returntype="model.User">
		<cfargument name="obj" type="model.User" required="true" />
 		
        <cfreturn createObject("component", "UserDAO").tryLogin(ARGUMENTS.obj)>
    </cffunction>

	<cffunction name="isUsernameAvailable" output="false" access="remote" returntype="boolean">
		<cfargument name="username" type="string" required="true" />
 		<cfreturn createObject("component", "UserDAO").isUsernameAvailable(arguments.username)>
	</cffunction>

	<cffunction name="getById" output="false" access="remote" returntype="model.User">
		<cfargument name="id" type="numeric" required="true" />
 		<cfreturn createObject("component", "UserDAO").read(arguments.id)>
	</cffunction>

	<cffunction name="sendRegistrationEmail" output="false" access="remote" returntype="boolean">
		<cfargument name="user" type="model.User" required="true" />
        
        <cfset tmp = createObject("component", "UserDAO").sendRegistrationEmail(arguments.user) />
        
 		<cfreturn true/>
	</cffunction>
    
    <cffunction name="activateAccount" output="false" access="remote" returntype="boolean">
    	<cfargument name="verificationCode" type="string" required="true" />
        
        <cfreturn createObject("component", "UserDAO").activateAccount(arguments.verificationCode)/>
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