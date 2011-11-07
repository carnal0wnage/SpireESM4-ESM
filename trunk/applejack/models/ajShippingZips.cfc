<cfcomponent name="ajShippingZips Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{
			"FIELDS":{
				"zip":{"VALIDATION":"notblank,iszip","LABEL":"Zip","MAXLEN":5,"TYPE":"varchar"},
				"shippingid":{"VALIDATION":"maxlength,notblank","LABEL":"Shippingid","MAXLEN":35,"TYPE":"varchar"}
			},
			"TABLENAME":"ajShippingZips",
			"DEFAULTSORT":"zip"
		}')>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="validateSave">		
		<cfset var lcl = structnew()>
		<cfset var requestvars = variables.itemData>
		<cfset var mylocal = structnew()>

		<cfset super.validateSave()>
		
		<cfset lcl.existing = this.getByZip(requestvars.zip)>
		
		<cfloop query="lcl.existing">
			<cfif lcl.existing.id NEQ requestvars.id>
				<cfset lcl.shpopt = createObject('component',"applejack.models.ajShippingOptions").init(requestObj, userObj).getById(lcl.existing.shippingid)>
				<cfset vdtr.addError("zip", "This zip already exists in #lcl.shpopt.label#")>
			</cfif>
		</cfloop>
		
		<cfreturn vdtr/>
	</cffunction>
	
</cfcomponent>
