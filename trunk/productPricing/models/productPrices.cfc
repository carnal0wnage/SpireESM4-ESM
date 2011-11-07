<cfcomponent name="productPrices Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{
			"FIELDS":{
				"id":{"autoincrement":1,"TYPE":"integer"},		
				"modified":{"LABEL":"Modified","TYPE":"date"},
				"price":{"LABEL":"Price", "TYPE":"real"},
				"price_member":{"LABEL":"Price_member", "TYPE":"real"},
				"price_sale":{"LABEL":"Price_sale", "TYPE":"real"},
				"created":{"LABEL":"Created","TYPE":"date"},
				"changedby":{"VALIDATION":"maxlength,notblank","LABEL":"Changedby","MAXLEN":35,"TYPE":"varchar"},
				"productid":{"VALIDATION":"maxlength,notblank","LABEL":"Productid","MAXLEN":35,"TYPE":"varchar"},
				"type":{"VALIDATION":"maxlength,notblank","LABEL":"Type","MAXLEN":35,"TYPE":"varchar"}
			},
			"TABLENAME":"productPrices"
		}')>
		<cfreturn this>
	</cffunction>
	
</cfcomponent>
