<cfif variables.isDataItemSet('searchResults')>
	<cfset lcl.results = getDataItem('searchResults')>
	<cfset lcl.tbl = createWidget("tablecreator")>
	<cfset lcl.tbl.setRequestObj(requestObj)>
	<cfset lcl.tbl.addColumn('Name','name', 'alpha','<a href="/customers/editCustomer/?id=[id]">[lname], [fname]</a>')>
	<cfset lcl.tbl.addColumn('Created','created', 'date')>
	<cfset lcl.tbl.addColumn('Modified','modified', 'date')>
	<cfset lcl.tbl.setQuery(lcl.results)>
	<cfoutput>#lcl.tbl.showHTML()#</cfoutput>
</cfif>
