<cfcomponent>
	<!--- default application scope vars --->
	<cfscript>
		this.name = "TestApplication";
		this.sessionmanagement = true;
		this.sessiontimeout = createtimespan(0,0,10,0);
		this.applicationtimeout = createtimespan(5,0,0,0);
	</cfscript>
	
	<!--- method run when the application first starts up --->
	<cffunction name="onApplicationStart" returnType="boolean">
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="onApplicationEnd" output="false" returnType="void">
		<cfargument name="applicationScope" required="true">
	</cffunction>
	
	<cffunction name="onSessionStart" output="false" returnType="void">
	</cffunction>
	
	<cffunction name="onSessionEnd" output="false" returnType="void">
		<cfargument name="SessionScope" required=True/>
		<cfargument name="ApplicationScope" required=False/>
	</cffunction>
	
	<cffunction name="onRequestStart" output="false" returnType="boolean">
		<cfargument name="targetPage" type="string" required="true"/>
		
		<cfscript>
			REQUEST.dsn = "mousebreeder";
			REQUEST.secretKey = "ChangeThisKeyForPasswordEncryption";
			REQUEST.supportEmail = "shan@iotashan.com";
			// change this to your URL. Defaulted to the root of whatever the URL called is
			REQUEST.siteURL = "http://" & CGI.SERVER_NAME & "/";
		</cfscript>
		
		<cfreturn true>
	</cffunction>
	
	<!--- onRequest is left out because we're going to call templates directly --->
	
	<cffunction name="onRequestEnd" output="false" returnType="void">
		<cfargument name="targetPage" type="string" required="true"/>
	</cffunction>
	
	<!--- set output="true" if you want to output an error from here
	<cffunction name="onError" output="false" returnType="void">
		<cfargument name="exception" required="true"/>
		<cfargument name="eventName" type="string" required="true"/>
	</cffunction> --->
</cfcomponent>