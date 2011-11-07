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
	<input type="text" name="searchkeyword" id="searchkeyword" maxlength="255" value="<cfoutput>#lcl.searchkeyword#</cfoutput>" />
	<input type="submit" name="Search" value="Search" />
	</div>
	</form>
</dd>
</dl>