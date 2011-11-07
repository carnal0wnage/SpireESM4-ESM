<cfif variables.isDataItemSet('searchinfo')>
	<cfset lcl.ordersearch = getDataItem('searchinfo')>
	<cfset lcl.tbl = createWidget("tablecreator")>
	<cfset lcl.tbl.setRequestObj(variables.getDataItem('requestObj'))>
	<cfset lcl.tbl.addColumn('Billing Name','billing_name', 'alpha','<a href="/orders/editorder/?id=[id]">[billing_name]</a>')>
	<cfset lcl.tbl.addColumn('Modified','modified', 'date')>
	<cfset lcl.tbl.setQuery(lcl.ordersearch)>
	<cfoutput>#lcl.tbl.showHTML()#</cfoutput>
</cfif>