<cfset lcl.assetsearch = getDataItem('searchresults')>
<cfset lcl.tbl = createWidget("tablecreator")>
<cfset lcl.tbl.setRequestObj(variables.getDataItem('requestObj'))>
<cfset lcl.tbl.addColumn('Name', 'name', 'alpha', '<a href="../editProduct/?id=[id]">[name]</a>')>
<cfset lcl.tbl.addColumn('Title', 'title', 'alpha')>
<cfset lcl.tbl.addColumn('Changed Date', 'modified', 'datetime')>
<cfset lcl.tbl.setQuery(lcl.assetsearch)>
<cfoutput>#lcl.tbl.showHTML()#</cfoutput>
