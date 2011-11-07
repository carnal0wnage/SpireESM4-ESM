<cfif requestObj.isformurlvarset('searchkeyword')>
	<cfset setselected(2)>
	<cfset lcl.searchkeyword = requestObj.getformurlvar('searchkeyword')>
<cfelse>
	<cfset lcl.searchkeyword = "">
</cfif>
<dl class="accordion">
<dt class="selected">Keyword Search</dt>
<dd>
	<form action="/orders/search/" method="post">
	<div style="text-align:center">
	<br /><BR />
    <strong>By Status:</strong><br />
    <select id="selStatus">
    	<option value="" selected="yes"></option>
        <option value="new">New</option>
        <option value="paid">Paid</option>
        <option value="pending">Pending</option>
        <option value="deleted">Deleted</option>
    </select><br /><br />
   <strong>By Keyword:</strong><br />
	
	<input type="text" name="searchkeyword" id="searchkeyword" maxlength="255" value="<cfif isdefined("form.search")><cfoutput>#lcl.searchkeyword#</cfoutput></cfif>" />
    <br /><BR />
    <strong>By Date</strong>:<br />
    <input type="text" name="searcdate" id="searchdate" maxlength="255" value="<cfif isdefined("form.search")><cfoutput>#lcl.searchkeyword#</cfoutput></cfif>" /><BR /><BR />
	</div>
	<div style="text-align: right;">
    	<input type="submit" name="Search" value="Search" />
	</div>
	</form>
</dd>
</dl>