<cfcomponent name="giftMessages Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{
			"FIELDS":{
				"id":{"VALIDATION":"notblank","LABEL":"ID","MAXLEN":35,"TYPE":"varchar"},		
				"orderid":{"VALIDATION":"notblank","LABEL":"OrderID","MAXLEN":35,"TYPE":"varchar"},
				"messagetext":{"VALIDATION":"notblank","LABEL":"Message Text","MAXLEN":500,"TYPE":"varchar"},
				"created":{"LABEL":"Created","TYPE":"date"},
				"modified":{"LABEL":"Modified","TYPE":"date"}
			},
			"TABLENAME":"giftmessages"
		}')>
		<cfreturn this>
	</cffunction>
	
</cfcomponent>
