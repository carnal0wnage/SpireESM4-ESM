<cfif requestObj.isformurlvarset('searchkeyword')>
	<cfset setselected(2)>
	<cfset lcl.searchkeyword = requestObj.getformurlvar('searchkeyword')>
<cfelse>
	<cfset lcl.searchkeyword = "">
</cfif>
<dl class="accordion">
<dt class="selected">Keyword Search</dt>
<dd>
	<form action="../Search/" method="get">
	
	<div style="text-align: right;">
	<input type="text" name="searchkeyword" id="searchkeyword" maxlength="255" value="<cfif isdefined("form.search")><cfoutput>#lcl.searchkeyword#</cfoutput></cfif>" />
	
	<cfif isDataItemSet('reviewsmodulename')>
		<input type="hidden" name="reviewsmodulename" id="reviewsmodulename" value="<cfoutput>#getDataItem('reviewsmodulename')#</cfoutput>" />
	</cfif>
	
	<input type="submit" name="Search" value="Search" />
	</div>
	</form>
</dd>
</dl>