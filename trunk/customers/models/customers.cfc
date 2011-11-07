<cfcomponent name="customers Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
		<cfset setTableMetaData('{	
			"FIELDS":{
				"company":{"VALIDATION":"maxlength","LABEL":"Company","MAXLEN":50,"TYPE":"varchar"},
				"birthday":{"LABEL":"Birthday","TYPE":"date"},
				"homephone":{"VALIDATION":"maxlength","LABEL":"Homephone","MAXLEN":50,"TYPE":"varchar"},
				"state":{"VALIDATION":"maxlength,notblank","LABEL":"State","MAXLEN":50,"TYPE":"varchar"},
				"modified":{"LABEL":"Modified","TYPE":"date"},
				"fname":{"VALIDATION":"maxlength,notblank","LABEL":"Fname","MAXLEN":50,"TYPE":"varchar"},
				"mobilephone":{"VALIDATION":"maxlength","LABEL":"Mobilephone","MAXLEN":50,"TYPE":"varchar"},
				"country":{"VALIDATION":"maxlength","LABEL":"Country","MAXLEN":50,"TYPE":"varchar"},
				"created":{"LABEL":"Created","TYPE":"date"},
				"lname":{"VALIDATION":"maxlength,notblank","LABEL":"Lname","MAXLEN":50,"TYPE":"varchar"},
				"postalcode":{"VALIDATION":"maxlength,notblank","LABEL":"Postalcode","MAXLEN":11,"TYPE":"varchar"},
				"line1":{"VALIDATION":"maxlength,notblank","LABEL":"Line1","MAXLEN":50,"TYPE":"varchar"},
				"line2":{"VALIDATION":"maxlength","LABEL":"Line2","MAXLEN":50,"TYPE":"varchar"},
				"email":{"VALIDATION":"maxlength,notblank,validemail","LABEL":"Email","MAXLEN":100,"TYPE":"varchar"},
				"username":{"VALIDATION":"maxlength,notblank","LABEL":"Username","MAXLEN":50,"TYPE":"varchar"},
				"city":{"VALIDATION":"maxlength,notblank","LABEL":"City","MAXLEN":50,"TYPE":"varchar"},
				"password":{"VALIDATION":"maxlength","LABEL":"Password","MAXLEN":100,"TYPE":"varchar"},
				"deleted":{"LABEL":"Deleted","DEFAULT":0,"TYPE":"bit"},
				"active":{"LABEL":"Active","DEFAULT":1,"TYPE":"bit"},
				"fax":{"VALIDATION":"maxlength","LABEL":"Fax","MAXLEN":50,"TYPE":"varchar"}
			},
			"ALIASES":{
				"linitial":" SUBSTRING(customers.lname, 1, 1)"
			},
			"DEFAULTSORT":"linitial",
			"TABLENAME":"customers"
		}')>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="validatesave">
		<cfset var lcl = structnew()>
		<cfset lcl.vdtr = super.validateSave()>
		<cfset lcl.other = this.getByEmail(variables.itemdata.email)>
		<cfif NOT (lcl.other.recordcount EQ 0 OR (lcl.other.recordcount EQ 1 AND lcl.other.id EQ variables.itemdata.id))>
			<cfset lcl.vdtr.addError("email","This email is already in the system for ""#lcl.other.lname#, #lcl.other.fname#"".")>
		</cfif>
		<cfreturn lcl.vdtr>
	</cffunction>
	
	<cffunction name="presave">
		<cfif variables.itemdata.password EQ "">
			<cfset structdelete(variables.itemdata, "password")>
		<cfelse>
			<cfset variables.itemdata.password = hash(variables.itemdata.password)>
		</cfif>
	</cffunction>
	
	<cffunction name="search">
		<cfargument name="crit" required="true">
		<cfset var lcl = structnew()>
		<cfquery name="lcl.q" datasource="#requestObj.getVar("dsn")#">
			SELECT * 
			FROM customers 
			WHERE 
				fname LIKE <cfqueryparam value="%#arguments.crit#%" cfsqltype="cf_sql_varchar">
				OR lname LIKE <cfqueryparam value="%#arguments.crit#%" cfsqltype="cf_sql_varchar">
				OR id LIKE <cfqueryparam value="%#arguments.crit#%" cfsqltype="cf_sql_varchar">
			ORDER BY lname
		</cfquery>

		<cfreturn lcl.q>
	</cffunction>
	
</cfcomponent>
