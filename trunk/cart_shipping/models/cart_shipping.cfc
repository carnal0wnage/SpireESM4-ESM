<cfcomponent name="cart_shipping Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{
			"FIELDS":{
				"id":{"VALIDATION":"notblank","LABEL":"ID","MAXLEN":35,"TYPE":"varchar"},		
				"name":{"LABEL":"Name","MAXLEN":35,"TYPE":"varchar"},
				"enabled":{"LABEL":"Enabled","TYPE":"integer"},
				"path":{"LABEL":"Path","MAXLEN":35,"TYPE":"varchar"},
				"sortkey":{"LABEL":"Sort Key","TYPE":"integer"},
				"created":{"LABEL":"Created","TYPE":"date"},
				"modified":{"LABEL":"Modified","TYPE":"date"}
			},
			"TABLENAME":"cartShippingModules"
		}')>
		<cfreturn this>
	</cffunction>
	
    <cffunction name="setShipOption">
   		<cfargument name="requestObj" required="true">
    	<cfargument name="ids" required="yes">

        <cfset arguments.ids = rereplace(arguments.ids, "[^a-zA-Z0-9,]", "-", "all")>
        
        <cfquery name="setShippingTrue" datasource="#arguments.requestObj.getvar('dsn')#">
        	Update CartShippingModules
            Set enabled = 1, modified = getDate()
            Where id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ids#" list="yes" separator=",">)
        </cfquery>
        <cfquery name="setShippingFalse" datasource="#arguments.requestObj.getvar('dsn')#">
        	Update CartShippingModules
            Set enabled = 0, modified = getDate() 
            Where id NOT IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ids#" list="yes" separator=",">)
        </cfquery>
    </cffunction>
    
</cfcomponent>
