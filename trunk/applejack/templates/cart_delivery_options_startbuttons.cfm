<cfoutput>
<cfif securityObj.isallowed("applejack","AJ Save Delivery Option")>	
	<input type="submit" value="Save Shipping Option" id="saveoption">
</cfif>
<cfif securityObj.isallowed("Applejack","delete Shipping Option")>
	<input type="button" value="Delete This Option" id="deleteBtn"  onClick="verify('Are you sure you wish to delete this option?','../deleteAJDeliveryOption/?id=' + document.myForm.id.value)">
</cfif>
<cfif securityObj.isallowed("applejack","AJ Save Delivery Option")>
	<input type="button" value="New Shipping Option" id="newoption" onClick="location.href = '/cart/AJDeliveryOptionsForm/';">
</cfif>
</cfoutput>