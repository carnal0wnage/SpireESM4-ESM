<cfoutput>
<cfif securityObj.isallowed("productPrices","save Pricing")>
	<input type="submit" value="Save Prices">
</cfif>
    
<input type="button" value="Back to Product" id="cancelBtn" onClick="location.href = '/productCatalog/editProduct/?id=#requestObj.getFormUrlVar("id")#';">
</cfoutput>