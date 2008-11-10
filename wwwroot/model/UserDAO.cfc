<cfcomponent output="false">

	<cffunction name="read" output="false" access="public" returntype="model.User">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#REQUEST.dsn#">
			select 	UserID, email, password, verificationCode
			from users
			where UserID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "model.User").init();
			obj.setUserID(qRead.UserID);
			obj.setemail(qRead.email);
			obj.setpassword(qRead.password);
			obj.setverificationCode(qRead.verificationCode);
			return obj;
		</cfscript>
	</cffunction>

	<cffunction name="tryLogin" output="false" access="public" returntype="model.User">
		<cfargument name="bean" required="true" type="model.User">

		<!--- try logging in --->
		<cfquery name="qLogin" datasource="#REQUEST.dsn#">
			SELECT userID
			FROM users
			WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bean.getEmail()#">
				AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hashPassword(ARGUMENTS.bean.getPassword())#">
		</cfquery>
		
		<cfscript>
			if (qLogin.recordcount) {
				// return a User if there was a match
				return read(qLogin.userID);
			} else {
				// clear userID and password, return empty user
				ARGUMENTS.bean.setuserID(0);
				ARGUMENTS.bean.setPassword("");
				
				return ARGUMENTS.bean;
			}
		</cfscript>
	</cffunction>

	<cffunction name="isUsernameAvailable" output="false" access="public" returntype="boolean">
		<cfargument name="username" required="true" type="string">

		<!--- test unique email address --->
		<cfquery name="qTestEmail" datasource="#REQUEST.dsn#">
			SELECT userID
			FROM users
			WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#">
		</cfquery>
		
		<cfreturn NOT qTestEmail.recordcount />
	</cffunction>

	<cffunction name="activateAccount" output="false" access="public" returntype="boolean">
		<cfargument name="verificationCode" required="true" type="string">

		<!--- test unique email address --->
		<cfquery name="qTestCode" datasource="#REQUEST.dsn#">
			SELECT userID
			FROM users
			WHERE verificationCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.verificationCode#">
		</cfquery>
        
        <cfscript>
			if (!qTestCode.recordcount) {
				return false;
			} else {
				thisUser = read(qTestCode.userID);
				// clear the verification code
				thisUser.setVerificationCode("");
				// clear the password, so it's not updated
				thisUser.setPassword("");
				
				update(thisUser);
				
				return true;
			}
		</cfscript>
	</cffunction>

	<cffunction name="create" output="false" access="public">
		<cfargument name="bean" required="true" type="model.User">
		<cfset var qCreate="">

		<cfset var qGetId="">

		<cfset var local1=arguments.bean.getemail()>
		<cfset var local2=arguments.bean.getpassword()>
        <cfset var local3=createUUID()>

		<cftransaction isolation="read_committed">
			<cfquery name="qCreate" datasource="#REQUEST.dsn#">
				insert into users(email, password, verificationCode)
				values (
					<cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#hashPassword(local2)#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local3#" cfsqltype="CF_SQL_VARCHAR" />
				)
			</cfquery>

			<!--- If your server has a better way to get the ID that is more reliable, use that instead --->
			<cfquery name="qGetID" datasource="#REQUEST.dsn#">
				select UserID
				from users
				where email = <cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />
				  and password = <cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />
				  and verificationCode = <cfqueryparam value="#local3#" cfsqltype="CF_SQL_VARCHAR" />
			</cfquery>
		</cftransaction>

		<cfscript>
			arguments.bean.setUserID(qGetID.UserID);
			arguments.bean.setPassword(hashPassword(local2));
			arguments.bean.setVerificationCode(local3);
			sendRegistrationEmail(arguments.bean);
		</cfscript>
		<cfreturn arguments.bean />
	</cffunction>



	<cffunction name="update" output="false" access="public">
		<cfargument name="bean" required="true" type="model.User">
		<cfset var qUpdate="">

		<cfquery name="qUpdate" datasource="#REQUEST.dsn#" result="status">
			update users
			set email = <cfqueryparam value="#arguments.bean.getemail()#" cfsqltype="CF_SQL_VARCHAR" />,
            	<cfif len(arguments.bean.getpassword())>
				password = <cfqueryparam value="#hashPassword(arguments.bean.getpassword())#" cfsqltype="CF_SQL_VARCHAR" />,
                </cfif>
				verificationCode = <cfqueryparam value="#arguments.bean.getverificationCode()#" cfsqltype="CF_SQL_VARCHAR" />
			where UserID = <cfqueryparam value="#arguments.bean.getUserID()#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		<cfreturn arguments.bean />
	</cffunction>



	<cffunction name="delete" output="false" access="public" returntype="void">
		<cfargument name="bean" required="true" type="model.User">
		<cfset var qDelete="">

		<cfquery name="qDelete" datasource="#REQUEST.dsn#" result="status">
			delete
			from users
			where UserID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.bean.getUserID()#" />
		</cfquery>

	</cffunction>


	<cffunction name="hashPassword" output="false" access="public" returntype="string">
    	<cfargument name="password" type="string" required="yes">
        
        <cfreturn Encrypt(ARGUMENTS.password,REQUEST.secretKey)>
    </cffunction>


	<cffunction name="sendRegistrationEmail" output="false" access="public" returntype="void">
    	<cfargument name="bean" type="model.User" required="yes">
        
<cfmail from="#REQUEST.supportEmail#" to="#ARGUMENTS.bean.getemail()#" subject="Confirm your registration">
Please confirm your registration by clicking the link below:

#REQUEST.siteURL#?v=#ARGUMENTS.bean.getVerificationCode()#
</cfmail>
    </cffunction>
</cfcomponent>