<cfcomponent name="giftmessageObservers" extends="resources.abstractObserver">
	
    <cffunction name="alterpagemap_Orders_editOrder">
		<cfargument name="observed" required="yes">
       <!---<cfdump var="#arguments#"><cfabort>--->
		<cfset lcl 			= structnew()>
        <cfset mdl 			= createObject('component','orders.models.orders').init(requestObj, session.user)>
        <cfset var gmModel 	= createObject('component', 'giftmessage.models.giftmessage').init(requestObj, session.user)>
  
        <cfreturn arguments.observed/>
    </cffunction>
    
    <cffunction name="alterdatas_orders_editOrder">
		<cfargument name="observed" required="true">
        
        <cfset gmObj = createobject("component","giftmessage.models.giftmessage").init(requestObj, session.user)>
        
		<cfset observed.giftmessage = gmObj.getbyOrderId(requestObj.getFormUrlVar("id"))>
		<cfreturn arguments.observed>
	</cffunction>
    
	<cffunction name="altermodulesonload_orders">
		<cfargument name="observed" required="true">

        <cfset lcl.gm = structnew()>
        <cfset lcl.gm.file = "giftmessage/templates/giftmessage.cfm">
		<cfset lcl.gm.name = "mainContent">
		<cfset lcl.gm.title = "Gift Message">
        
		<cfset Arrayappend(observed.actions.addorder.templates,lcl.gm)>
        <cfset ArrayInsertAt(observed.actions.editorder.templates,9,lcl.gm)>
        
        <!--- <Cfdump var="#variables.requestobj.dump()#"><cfabort>--->
		
		<cfreturn arguments.observed/>
	</cffunction>
    
    <cffunction name="controllermethod_orders_editOrder_getGiftMessage">
		<cfargument name="observed" required="true">
        <cfset var gm="">
        <cfquery name="gm" datasource="#variables.requestObj.getvar('dsn')#">
			SELECT  messagetext
            FROM 	giftmessages
            WHERE 	orderid = <cfqueryparam value="#requestObj.getFormUrlVar('id')#" cfsqltype="cf_sql_varchar">
         </cfquery>
         
		<cfreturn gm/>
	</cffunction>
    
    <cffunction name="controllermethod_orders_addOrder">
		<cfargument name="observed" required="true">
			
    	<cfreturn arguments.observed/>
	</cffunction>	
</cfcomponent>