<cfset lcl.Customer = getDataItem('Customer')>

<cfif (NOT requestObj.isFormUrlVarSet('id') AND securityObj.isallowed('customers', 'Add Customer')) OR 
		(requestObj.isFormUrlVarSet('id') AND securityObj.isallowed('customers', 'Edit Customer'))>
	<input type="submit" value="Save">
</cfif>	
<cfif securityObj.isallowed('customers', 'delete Customer')>
	<cfoutput>
    <input type="button" id="deleteBtn" #iif(NOT requestObj.isFormUrlVarSet('id'),DE('style="display:none;'),DE(''))#" value="Delete" onClick="verify('Are you sure you wish to delete this item?','/customers/deleteCustomer/?id=' + document.myForm.id.value)">
    </cfoutput>
</cfif>

