<cfsilent>

	<cfset lcl.acc = createWidget('accordion')>
	<cfset lcl.acc.setID('Orderlist')>
	<cfset lcl.Orderlist = getDataItem('Orderlist')>
	
	<cfif isdataItemSet('id')>
		<cfset lcl.Orderid = getDataItem('id')>
	<cfelse>
		<cfset lcl.Orderid = 0>
	</cfif>

	<cfset lcl.count = 0>
	
	<cfset lcl.s = structnew()>

	<cfoutput query="lcl.Orderlist" group="orderStatus">
		<cfset lcl.s.title = billing_name>
		<cfset lcl.count = lcl.count + 1>
		<cfsavecontent variable="lcl.s.html">
			<div class="nav">
			<ul>
			<cfoutput>
				<cfif lcl.Orderid EQ id>
					<cfset lcl.acc.setSelected(lcl.count)>
				</cfif>
				<li><a <cfif lcl.Orderid EQ id>class="selected"</cfif> href="../editOrder/?id=#id#">#billing_name# (#dateformat(created,"mm/dd")#)</a></li>
			</cfoutput>
			</ul>
			</div>
		</cfsavecontent>
		<cfset lcl.acc.add("#lcl.orderlist.orderStatus# Orders",lcl.s.html)>
	</cfoutput>
	
</cfsilent>

<cfoutput>#lcl.acc.showHTML()#</cfoutput>
