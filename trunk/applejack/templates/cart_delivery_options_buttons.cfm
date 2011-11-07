<cfset lcl.info = getDataItem('item')>
<cfset lcl.form = createWidget("formcreator")>

<cfoutput>
<cfif (NOT requestObj.isFormUrlVarSet('id') AND securityObj.isallowed("Applejack","add AJ ShippingOption")) 
	OR (requestObj.isFormUrlVarSet('id') AND securityOBj.isallowed("Applejack","edit AJ Shipping Option"))>
	<input type="submit" value="Save">
</cfif>

<cfif securityObj.isallowed("Applejack","delete Shipping Option")>
	<input type="button" value="Delete" id="deleteBtn" #iif(NOT requestObj.isFormUrlVarSet('id'),DE('style="display:none;"'),DE(''))# onClick="verify('Are you sure you wish to delete this event?','../deleteAJShippingOption/?id=' + document.myForm.id.value)">
</cfif>
</cfoutput>