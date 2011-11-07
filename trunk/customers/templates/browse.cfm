<cfsilent>
	<cfset lcl.acc = createWidget('accordion')>
	<cfset lcl.browse = getDataItem('browse')>
	
	<cfif requestObj.isFormUrlVarSet('id')>
		<cfset lcl.id = requestObj.getFormUrlVar('id')>
	<cfelse>
		<cfset lcl.id = 0>
	</cfif>
	<cfset lcl.toselect = 1>
	
	<cfif lcl.browse.recordcount>
		<cfset lcl.count = 1>
	
		<cfset lcl.s = structnew()>
		<cfoutput query="lcl.browse" group="linitial">
		<cfsavecontent variable="lcl.s.html">
			<div class="nav">
			<ul>
			<cfoutput>
				<li><a <cfif lcl.id EQ lcl.browse.id[lcl.browse.currentrow]>class="selected" <cfset lcl.acc.setselected(lcl.count)></cfif> href="../editCustomer/?id=#id#">#lname# #fname#</a></li>
			</cfoutput>
			</ul>
			</div>
		</cfsavecontent>
		<cfset lcl.acc.add(linitial,lcl.s.html)>
		<cfset lcl.count = lcl.count + 1>
		</cfoutput>
	<cfelse>
		<cfif lcl.browse.recordcount EQ 0>
			<cfset lcl.acc.add("No Customers Loaded","")>
		</cfif>
	</cfif>
</cfsilent>

<cfoutput>#lcl.acc.showHTML()#</cfoutput>

