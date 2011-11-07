<cfcomponent name="cart_shipping" extends="resources.abstractController">
	
	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfreturn this>
	</cffunction>
	
</cfcomponent>