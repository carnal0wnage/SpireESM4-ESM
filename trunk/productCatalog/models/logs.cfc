<cfcomponent name="logobserver" extends="resources.systemlogs">

	<cffunction name="init">
		<cfargument name="requestObject">
		<cfargument name="userObject">
		
		<cfset variables.requestObject = arguments.requestObject>	
		<cfset variables.userObject = arguments.userObject>
		
		<cfset setLogInfo('{
			"moduleName":"productcatalog",
			"tableName":"Products",
			"events":{
				"save products":{"message":"{savemode} product &quot;{name}&quot;."},
				"destroy products":{"message":"Deleted product &quot;{name}&quot;."},
				"save productgroups":{"message":"{savemode} product group &quot;{name}&quot;.","tablename":"productgroups"},
				"delete productgroups":{"message":"Deleted product group &quot;{name}&quot;.","tablename":"productgroups"},
				"upload thmbfilename":{"message":"Uploaded Thumbnail Image &quot;{thmbfilename}&quot;."},
				"upload mainfilename":{"message":"Uploaded Main Image &quot;{mainfilename}&quot;."}
			}
		}')>
		
		<cfreturn this>
	</cffunction>
	
</cfcomponent>