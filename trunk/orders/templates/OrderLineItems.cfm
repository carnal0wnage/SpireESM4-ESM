<cfset lcl.orderinfo = getDataItem('orderinfo')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>

<cfset lcl.tbl = createWidget("tablecreator")>
<cfset lcl.tbl.setRequestObj(variables.getDataItem('requestObject'))>
<cfset lcl.tbl.addColumn('Product','name', 'alpha')>
<cfset lcl.tbl.addColumn('Quantity','quantity', 'alpha')>
<cfset lcl.tbl.addColumn('Price Each','individualprice', 'alpha')>
<cfset lcl.tbl.addColumn('Price','price', 'alpha')>
<cfset lcl.tbl.setQuery(variables.getDataItem('orderitems'))> 
<cfoutput>#lcl.tbl.showHTML()#</cfoutput>

<cfset lcl.tbl = createWidget("tablecreator")>
<cfset lcl.tbl.setRequestObj(variables.getDataItem('requestObject'))>
<cfset lcl.tbl.addColumn('Type','label', 'alpha')>
<cfset lcl.tbl.addColumn('Total','total', 'currency')>
<cfset lcl.tbl.setQuery(variables.getDataItem('lineitems'))> 
<cfoutput>#lcl.tbl.showHTML()#</cfoutput>

<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>
	
