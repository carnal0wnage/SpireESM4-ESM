<cfset lcl.info = getDataItem('editablemodel')>
<cfoutput>
<cfif requestObj.getFormUrlVar("view","default") EQ "default">
<input type="button" value="Save" 
		onClick="verify('Are you sure you wish to save this item?','../functiontosavegoeshere/?id=#lcl.info.getid()#');">
</cfif>
</cfoutput>