<cfcomponent displayname="productTest" extends="mxunit.framework.TestCase">
	
	<cffunction name="setup">
		<cfset variables.httpObj = createObject('component','login.logintest').getLoggedInSAUser()>

		<cfset variables.productgroupid = createuuid()>
		<cfset variables.siteid = application.sites.getsites().id[1]>
		
		<cfquery datasource="#request.requestObject.getVar('dsn')#">
			INSERT INTO productGroups (id,name,title,changedby,siteid)
			VALUES (
				<cfqueryparam value="#variables.productgroupid#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="unittesting" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="unittesting" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="8C8DD7E6-EA08-57D6-6556D3BB74048D54" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#variables.siteid#" cfsqltype="cf_sql_varchar">
			)
		</cfquery>
	</cffunction>
	
	<cffunction name="teardown">
		<cfquery name="me" datasource="#request.requestObject.getVar('dsn')#">
			DELETE FROM products WHERE name = 'unittesting'
		</cfquery>
		<cfquery name="me" datasource="#request.requestObject.getVar('dsn')#">
			DELETE FROM productGroups WHERE name = 'unittesting'
		</cfquery>
		<cfquery name="me" datasource="#request.requestObject.getVar('dsn')#">
			DELETE FROM productsToProductGroups WHERE productgroupid = <cfqueryparam value="#variables.productgroupid#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfquery datasource="#request.requestObject.getVar("dsn")#">
			DELETE
			FROM activitylogs
			WHERE description LIKE '%unittesting%'
		</cfquery>
	</cffunction>
	
    <cffunction name="InterfaceTest">
		<cfset var l = structnew()>
		<cfset var response = "">
				
		<cfset variables.httpObj.setPath('/productcatalog/startPage/')>
		<cfset response = variables.httpObj.load()>
		
		<cfset assertfalse(condition=(response.is302relocate()),message="sa logged in but can't see product catalog")>
		
		<!--- testing add product --->
		<cfset variables.httpObj.setPath('/productcatalog/AddProduct/')>
		<cfset response = variables.httpObj.load()>
		
		<cfset l.formFields = response.getESMFormFields()>

		<cfset assertfalse(condition=(len(l.formFields) EQ 0),message="no form fields in add product page")>
		
		<!--- testing save new product --->
		
		<cfset l.submitsto = response.getESMSubmitsTo()>
		
		<cfset variables.httpObj.setPath(l.submitsto)>
		
		<cfset variables.httpObj.clear('formfield,urlfields')>
		
		<cfset l.fields = structnew()>
		
		<cfloop list="#l.formfields#" index="l.idx">
			<cfset l.fields[l.idx] = createuuid()>
		</cfloop>
		
		<cfset l.fields['id'] = "">
		<cfset l.fields['name'] = "">
		<cfset l.fields['title'] = "">
		<cfset l.fields['description'] = "">
		<cfset l.fields['price'] = "3.14159">
		<cfset l.fields['productgroupids'] = "">
		
		<cfloop collection="#l.fields#" item="l.idx">
			<cfset variables.httpObj.addFormField(l.idx, l.fields[l.idx])>
		</cfloop>
		
		<cfset response = variables.httpObj.load()>
		<cfset asserttrue(condition=(response.getStatus() EQ '200'),message="error while saving new product")>
		<cfset asserttrue(condition=(response.existsByPattern("""FIELD"":""name""")),message="validation did not find name error")>
		<cfset asserttrue(condition=(response.existsByPattern("""FIELD"":""title""")),message="validation did not find title error")>
		<cfset asserttrue(condition=(response.existsByPattern("""FIELD"":""price""")),message="validation did not find price error")>

		<cfset l.fields['name'] = "unittesting">
		<cfset l.fields['title'] = "unittesting">
		<cfset l.fields['description'] = "unittestingdesc">
		<cfset l.fields['htmlText'] = "unittestinghtmltext">
		<cfset l.fields['productgroupids'] = variables.productgroupid>
		<cfset l.fields['price'] = "3.14">
		
		<cfloop collection="#l.fields#" item="l.idx">
			<cfset variables.httpObj.addFormField(l.idx, l.fields[l.idx])>
		</cfloop>
		
		<cfset response = variables.httpObj.load()>

		<cfset asserttrue(condition=(response.getStatus() EQ '200'),message="error while saving new product")>
		<cfset assertfalse(condition=(response.existsByPattern("""validation")),message="validation did not find validation error")>
		
		<!--- check database to see if its there --->
		<cfquery name="l.q" datasource="#request.requestObject.getVar("dsn")#">
			SELECT *
			FROM products_view
			WHERE name = <cfqueryparam value="#l.fields['name']#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfset asserttrue(condition=l.q.recordcount EQ 1, message="No records found after insert")>
		
		<cfloop collection="#l.fields#" item="l.idx">
			<cfif l.idx NEQ "id" AND l.idx NEQ "productgroupids" >
				<cfset asserttrue(condition=(l.q[l.idx][1] NEQ ""), message="query did not enter all data ""#l.idx#"" is blank.")>
			</cfif>
		</cfloop>
		
		<!--- check database to see if its there --->
		<cfquery name="l.q" datasource="#request.requestObject.getVar("dsn")#">
			SELECT *
			FROM productsToProductGroups
			WHERE productgroupid = <cfqueryparam value="#variables.productgroupid#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfset asserttrue(condition=l.q.recordcount EQ 1, message="No records found after insert")>
		
		<cfquery name="l.q" datasource="#request.requestObject.getVar("dsn")#">
			SELECT count(*) cnt
			FROM activitylogs
			WHERE description LIKE <cfqueryparam value="%#l.fields['name']#%" cfsqltype="cf_sql_varchar">
		</cfquery>
		
		<cfset asserttrue(condition=l.q.cnt EQ 1, message="query did not trigger observer to log. log is blank.")>
		
		<!--- test edit product form--->
		<cfset l.id = response.getByPattern('[a-zA-Z0-9\-]{35}')>
		<cfset l.fields['id'] = l.id>
		
		<cfset variables.httpObj.setPath("/productcatalog/editProduct/")>

		<cfset variables.httpObj.clear('formfields,urlfields')>
		
		<cfset variables.httpObj.addUrlField('id', l.fields['id'])>
		
		<cfset l.fieldsBackup = duplicate(l.fields)>
		
		<cfset response = variables.httpObj.load()>

		<cfset asserttrue(condition=(response.getStatus() EQ '200'),message="error while getting edit product form")>

		<!--- test save existing product --->
		<!--- compare fieldsback query to input query, remove uncomparable elements --->
		<cfset l.fieldsOut = response.getESMFormStruct()>
		
		<cfloop list="itemdate,id,name,assetid" index="l.ldelidx">
			<cfset structdelete(l.fields, l.ldelidx)>
			<cfset structdelete(l.fieldsOut, l.ldelidx)>
		</cfloop>

		<cfset assertEquals(expected = l.fieldsOut, actual = l.fields, message="When saving product, query in is not query out")>
		
		<cfset variables.httpObj.clear('formfields,urlfields')>
		<cfset l.fieldsBackup['description'] = "unittestingdescupdated">
				
		<cfloop collection="#l.fieldsBackup#" item="l.idx">
			<cfset variables.httpObj.addFormField(l.idx, l.fieldsBackup[l.idx])>
		</cfloop>
		
		<cfset variables.httpObj.setPath("/productcatalog/saveProduct/")>
		
		<cfset response = variables.httpObj.load()>

		<cfset asserttrue(condition=(response.getStatus() EQ '200'),message="error while updating product")>
		<cfset assertfalse(condition=(response.existsByPattern("""validation")),message="validation did not find validation error")>
		
		<!--- check database to see if its there --->
		<cfquery name="l.q" datasource="#request.requestObject.getVar("dsn")#">
			SELECT *
			FROM products_view
			WHERE description = <cfqueryparam value="#l.fieldsBackup['description']#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfset asserttrue(condition=l.q.recordcount EQ 1, message="No records found after update")>
		
		<cfquery name="l.q" datasource="#request.requestObject.getVar("dsn")#">
			SELECT count(*) cnt
			FROM activitylogs
			WHERE description LIKE <cfqueryparam value="%unittesting%" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfset asserttrue(condition=l.q.cnt EQ 2, message="query did not trigger observer to log on update.")>
				
		<!--- test product image upload --->
		<cfset variables.httpObj.setPath('/productcatalog/uploadImage/?id=#l.id#')>
		<cfset response = variables.httpObj.load()>
		
		<cfset assertfalse(condition=(response.is302relocate()),message="sa logged in but can't see product image upload form")>		
		
		<!--- test deleting product --->
		<!--- clear form leave url which already contains id --->
		<cfset variables.httpObj.clear('formfields')>
		
		<cfset variables.httpObj.setPath("/productcatalog/deleteProduct/")>
		<cfset variables.httpObj.addUrlField('id', l.id)>
		
		<cfset response = variables.httpObj.load()>

		<cfset asserttrue(condition=(response.getStatus() EQ '200'),message="error while deleting product")>

		<!--- reload users start page and confirm id not there --->
		<cfset variables.httpObj.clear('formfields,urlfields')>
		
		<cfset variables.httpObj.setPath("/productcatalog/startPage/")>
		
		<cfset response = variables.httpObj.load()>
		
		<cfset l.findid = response.getByPattern(replace(l.id, "-", "\-","all"))>
		
		<cfset asserttrue(condition=(l.findid EQ ""),message="product was not deleted")>
		
		<cfquery name="l.q" datasource="#request.requestObject.getVar("dsn")#">
			SELECT count(*) cnt
			FROM products_view
			WHERE name = <cfqueryparam value="unittesting" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfset asserttrue(condition=l.q.cnt EQ 0, message="delete action did not remove record.")>

		<cfquery name="l.q" datasource="#request.requestObject.getVar("dsn")#">
			SELECT count(*) cnt
			FROM activitylogs
			WHERE description LIKE <cfqueryparam value="%unittesting%" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfset asserttrue(condition=l.q.cnt EQ 3, message="delete action did not trigger observer to log log is blank on delete.")>
		
	</cffunction>
	
</cfcomponent>