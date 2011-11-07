<cfset lcl.info = getDataItem('mdl')>
<cfset lcl.form = createWidget("formcreator")>

<cfoutput>
<cfif (NOT requestObj.isFormUrlVarSet('id') AND securityObj.isallowed("productcatalog","add product")) 
	OR (requestObj.isFormUrlVarSet('id') AND securityOBj.isallowed("productcatalog","edit product"))>
	<input type="submit" value="Save">
	<!--- <input type="button" id="uploadBtn" #iif(NOT requestObj.isFormUrlVarSet('id'),DE('style="display:none;"'),DE(''))# value="Upload Images" onClick="location.href = '../uploadImage/?id=' + document.myForm.id.value"> --->
</cfif>
    
<cfif securityObj.isallowed("productcatalog","delete product")>
	<input type="button" value="Delete" id="deleteBtn" #iif(NOT requestObj.isFormUrlVarSet('id'),DE('style="display:none;"'),DE(''))# onClick="verify('Are you sure you wish to delete this item?','../DeleteProduct/?id=' + document.myForm.id.value)">
</cfif>
</cfoutput>