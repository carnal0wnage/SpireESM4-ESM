<cfcomponent name="productPriceTypes Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{
			"FIELDS":{
				"sortkey":{"LABEL":"Sort"},
				"type":{"VALIDATION":"maxlength,notblank","LABEL":"Type","MAXLEN":50,"TYPE":"varchar"}
			},
			"TABLENAME":"productPriceTypes"
		}')>
		<cfreturn this>
	</cffunction>
	
</cfcomponent>
