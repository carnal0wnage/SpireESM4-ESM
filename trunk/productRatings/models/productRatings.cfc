<cfcomponent name="productRatings Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{	
			"FIELDS":{
				"changedby":{"VALIDATION":"maxlength,notblank","LABEL":"Modifiedby","MAXLEN":35,"TYPE":"varchar"},
				"modified":{"LABEL":"Changed","TYPE":"datetime"},
				"ratingtext":{"VALIDATION":"maxlength,notblank","LABEL":"Rating Text","MAXLEN":4000,"TYPE":"varchar"},
				"created":{"LABEL":"Created","TYPE":"date"},
				"rating":{"VALIDATION":"notblank,isinteger","LABEL":"Rating", "type":"integer"},
				"ratingtype":{"VALIDATION":"maxlength,notblank","LABEL":"Reviewtype","MAXLEN":35,"TYPE":"varchar"},
				"productid":{"VALIDATION":"maxlength,notblank","LABEL":"Productid","MAXLEN":35,"TYPE":"varchar"},
				"active":{"LABEL":"Active","TYPE":"integer"}
			},
			"TABLENAME":"productRatings"
		}')>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="validatesave">
		<cfset var lcl = structnew()>
		<cfset super.validateSave()>
		<cfset lcl.s = structnew()>
		<cfset lcl.s.ratingtype = getField('ratingtype')>
		<cfset lcl.count = this.getByProductId(getField("productid"), lcl.s)>
		<cfset lcl.vdtr = getValidator()>
		
		<cfif val(variables.itemdata.rating) GT 100 OR val(variables.itemdata.rating) LT 0>
			<cfset lcl.vdtr.addError("rating","Rating must be between 0 and 100")>
		</cfif>

		<cfif lcl.count.recordcount AND lcl.count.id NEQ variables.itemdata.id>
			<cfset lcl.vdtr.addError("ratingtype","There is already a rating for this type")>
		</cfif>
		
		<cfreturn lcl.vdtr>
	</cffunction>
	
</cfcomponent>
