<cfset lcl.Customer = getDataItem('Customer')>
<cfif lcl.Customer.GetId() EQ "">
	New Customer
<cfelse>
	<cfoutput>#lcl.Customer.getLName()#, #lcl.Customer.getFname()#</cfoutput>
</cfif>