<cfcomponent name="logobserver" extends="resources.systemlogs">

	<cffunction name="init">
		<cfargument name="requestObject">
		<cfargument name="userObject">
		
		<cfset variables.requestObject = arguments.requestObject>	
		<cfset variables.userObject = arguments.userObject>
		
		<cfset setLogInfo('{
			"moduleName":"Orders",
			"tableName":"Orders",
			"nositeid":true,
			"events":{
				"save orders":{"message":"{savemode} order. New status &quot;{orderstatus}&quot;."}
			}
		}')>
		
		<cfreturn this>
	</cffunction>
	
</cfcomponent>