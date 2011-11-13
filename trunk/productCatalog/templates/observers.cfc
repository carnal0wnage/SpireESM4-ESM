<cfcomponent name="OrdersObservers" extends="resources.abstractObserver">
	
	<cffunction name="altermodulesonload_customers">
		<cfargument name="observed" required="true">

		<cfset var s2 = structnew()>

		<cfset s2 = structnew()>
		<cfset s2.file = 'orders/templates/userorders.cfm'>
		<cfset s2.name = 'mainContent'>
		<cfset s2.title = "Orders">
			
		<cfset arrayappend(arguments.observed.actions.editCustomer.templates, s2)>

		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="alterdatas_customers_editCustomer">
		<cfargument name="observed" required="true">
		<cfset var lcl = structnew()>
		
		<cfset lcl.orderObj = createObject("component", "orders.models.orders").init(requestObj, session.user)>
		
		<cfset lcl.more = structnew()>
		<cfset lcl.more.sort="created">
		
		<cfset arguments.observed.userorders = lcl.orderObj.getByUserId(requestObj.getFormUrlvar("id"), lcl.more)>
		
		<cfreturn arguments.observed>
	</cffunction>
	
</cfcomponent>