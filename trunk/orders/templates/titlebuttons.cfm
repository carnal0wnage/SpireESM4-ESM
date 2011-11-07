<cfset lcl.orderinfo = getDataItem('orderinfo')>

<cfif (NOT requestObj.isFormUrlVarSet('id') AND securityObj.isallowed('orders', 'Add Order')) OR 
		(requestObj.isFormUrlVarSet('id') AND securityObj.isallowed('orders', 'Edit Order'))>
	<input type="submit" value="Save">
</cfif>	
<!---<cfif securityObj.isallowed('orders', 'delete order')>
	<cfoutput>
    <input type="button" id="deleteBtn" #iif(NOT requestObj.isFormUrlVarSet('id'),DE('style="display:none;"'),DE(''))# value="Mark Deleted" onClick="verify('Are you sure you wish to delete this order?','/orders/deleteorder/?id=' + document.myForm.id.value)">
    </cfoutput>
</cfif>--->
