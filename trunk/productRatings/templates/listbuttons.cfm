<cfoutput>
<form action="/productCatalog/editrating/" method="get">
	<input type="hidden" name="productid" value="#requestObj.getFormUrlvar("id")#">
	<input type="submit" value="Add a Rating">
	<input type="button" value="Back to Product" onclick="location.href='../editproduct/?id=#requestObj.getFormUrlvar("id")#';">
</form>
</cfoutput>