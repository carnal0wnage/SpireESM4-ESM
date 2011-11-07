<cfoutput>
<cfif securityObj.isallowed("productPrices","save Pricing")>
	<input type="submit" value="Save">
</cfif>
    
<input type="button" value="Cancel" id="cancelBtn" onClick="location.href = '/productCatalog/listratings/?id=#requestObj.getFormUrlVar("productid")#';">
<cfif requestObj.isFormUrlVarSet("id")>
	<input type="button" value="Delete" id="deleteBtn" #iif(NOT requestObj.isFormUrlVarSet('id'),DE('style="display:none;"'),DE(''))# onClick="verify('Are you sure you wish to delete this rating?','../deleteRating/?productid=#requestObj.getFormUrlVar("productid")#&id=#requestObj.getFormUrlvar("id")#')">
</cfif>
</cfoutput>