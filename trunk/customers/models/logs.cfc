<cfcomponent name="logobserver" extends="resources.systemlogs">

	<cffunction name="init">
		<cfargument name="requestObject">
		<cfargument name="userObject">
		
		<cfset variables.requestObject = arguments.requestObject>	
		<cfset variables.userObject = arguments.userObject>
		
		<cfset setLogInfo('{
			"moduleName":"Customers",
			"tableName":"customers",
			"events":{
				"save customers":{"message":"{savemode} Customer &quot;{fname} {lname}&quot;."},
				"delete customers":{"message":"Deleted Customer &quot;{fname} {lname}&quot;."}
			}
		}')>
		
		<cfreturn this>
	</cffunction>
	
</cfcomponent>