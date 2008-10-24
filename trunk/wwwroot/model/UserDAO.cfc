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

	<cffunction name="tryLogin" output="false" access="public" returntype="query">
		<cfargument name="bean" required="true" type="model.User">

		<!--- try logging in --->
		<cfquery name="qLogin" datasource="#REQUEST.dsn#">
			SELECT userID
			FROM users
			WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bean.email#">
				AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bean.password#">
		</cfquery>
		
		<cfreturn qLogin/>
	</cffunction>

	<cffunction name="isUsernameAvailable" output="false" access="public" returntype="boolean">
		<cfargument name="username" required="true" type="string">

		<!--- try logging in --->
		<cfquery name="qLogin" datasource="#REQUEST.dsn#">
			SELECT userID
			FROM users
			WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#">
		</cfquery>
		
		<cfreturn NOT qLogin.recordcount />
	</cffunction>

	<cffunction name="create" output="false" access="public">
		<cfargument name="bean" required="true" type="model.User">
		<cfset var qCreate="">

		<cfset var qGetId="">

		<cfset var local1=arguments.bean.getemail()>
		<cfset var local2=arguments.bean.getpassword()>
		<cfset var local3=arguments.bean.getverificationCode()>

		<cftransaction isolation="read_committed">
			<cfquery name="qCreate" datasource="#REQUEST.dsn#">
				insert into users(email, password, verificationCode)
				values (
					<cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />,
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
				order by UserID desc
			</cfquery>
		</cftransaction>

		<cfscript>
			arguments.bean.setUserID(qGetID.UserID);
		</cfscript>
		<cfreturn arguments.bean />
	</cffunction>



	<cffunction name="update" output="false" access="public">
		<cfargument name="bean" required="true" type="model.User">
		<cfset var qUpdate="">

		<cfquery name="qUpdate" datasource="#REQUEST.dsn#" result="status">
			update users
			set email = <cfqueryparam value="#arguments.bean.getemail()#" cfsqltype="CF_SQL_VARCHAR" />,
				password = <cfqueryparam value="#arguments.bean.getpassword()#" cfsqltype="CF_SQL_VARCHAR" />,
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


</cfcomponent>