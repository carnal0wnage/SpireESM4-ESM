<cfset lcl.tbl = createWidget("tablecreator")>
<cfset lcl.tbl.setRequestObj(requestObj)>
<cfset lcl.tbl.addColumn('Status','orderstatus', 'alpha','<a href="/orders/editorder/?id=[id]">[orderstatus]</a>')>
<cfset lcl.tbl.addColumn('Items','itemstotal', 'currency')>
<cfset lcl.tbl.addColumn('Total','ordertotal', 'currency')>
<cfset lcl.tbl.addColumn('Created','created', 'datetime')>
<cfset lcl.tbl.setQuery(variables.getDataItem('userorders'))> 
<cfoutput>#lcl.tbl.showHTML()#</cfoutput>
