<cfcomponent name="ajShippingOptions Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{
			"FIELDS":{
				"modified":{"LABEL":"Modified","TYPE":"date"},
				"label":{"VALIDATION":"maxlength,notblank","LABEL":"Label","MAXLEN":50,"TYPE":"varchar"},
				"cost":{"VALIDATION":"maxlength,notblank","LABEL":"Cost","MAXLEN":35,"TYPE":"varchar"},
				"created":{"LABEL":"Created","TYPE":"date"}},
			"TABLENAME":"ajShippingOptions"
		}')>
		<cfreturn this>
	</cffunction>
	
</cfcomponent>
