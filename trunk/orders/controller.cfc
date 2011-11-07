<cfcomponent name="Orders" extends="resources.abstractController">
	
	<cffunction name="getOrdersModel">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">
		
		<cfset mdl = createObject('component','orders.models.orders').init(arguments.requestObject, arguments.userObj)>
		<cfset mdl.attachObserver(getLogObj(arguments.requestObject, arguments.userObj))>
		<cfreturn mdl/>
	</cffunction>
	
	<cffunction name="getLogObj">
		<cfargument name="requestObject">
		<cfargument name="userObj">

		<cfreturn createObject('component','orders.models.logs2').init(arguments.requestObject, arguments.userObj)>
	</cffunction>
	
	<cffunction name="StartPage">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">
		<cfargument name="dispatcher" required="true">

		<cfset var ordermodel = getOrdersModel(arguments.requestObject, arguments.userObj)>
		<cfset var logs = getLogObj(arguments.requestObject, arguments.userObj)>
		<cfset var struct = structnew()>
		<cfset struct.sort = "created desc">
		
		<cfset displayObject.setData('orderlist', ordermodel.getOrders("new,pending"))>
		<cfset displayObject.setData('recentActivity', logs.getRecentModuleHistory(requestObject.getModuleFromPath()))>

	</cffunction>
	
	<cffunction name="addorder">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
	
		<cfset var ordermodel = getOrdersModel(arguments.requestObject, arguments.userObj)>
		<cfset var logs = getlogObj(argumentcollection = arguments)>
		<cfset var worldinfo = createObject('component','utilities.worldinfo').init(arguments.requestObject)>			
		<cfset displayObject.setData('orderlist', ordermodel.getOrders("new,pending"))>
		<cfset displayObject.setData('requestObject', arguments.requestObject)>
		<cfset displayObject.setData('states', worldinfo.getStates())>
		
		<cfif requestObject.isformurlvarset('id')>
        	<cfset displayObject.setData('lineitems', ordermodel.getOrderLineItems(requestObject.getFormUrlVar('id')))>
            <cfset displayObject.setData('orderitems', ordermodel.getOrderItems(requestObject.getFormUrlVar('id')))>
            <cfset displayObject.setData('shipmethod', ordermodel.getShippingMethod(requestObject.getFormUrlVar('id')))>
            <cfset displayObject.setData('paymethod', ordermodel.getPaymentMethod(requestObject.getFormUrlVar('id')))>
            <cfset displayObject.setData('itemhistory', logs.getRecentModuleItemHistory(requestObject.getModuleFromPath(), requestObject.getformurlvar('id')))>
			<cfset displayObject.setData('orderinfo', ordermodel.getById(	requestObject.getformurlvar('id')))>
			<cfset displayObject.setData('orderid', requestObject.getformurlvar('id'))>
		<cfelse>
			<cfset displayObject.setData('orderinfo', ordermodel.getById(0))>
			<cfset displayObject.setData('orderid', 0)>
		</cfif>
		
		<cfset displayObject.setWidgetOpen('mainContent','1,2')>
			
		<cfif requestObject.isformurlvarset('search')>
			<cfset displayObject.setData('ordersearch', 
				ordermodel.searchUser(
					requestObject.getformurlvar('search')))>
		</cfif>

	</cffunction>
	
	<cffunction name="Search">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
	
		<cfset var ordermodel = getOrdersModel(arguments.requestObject, arguments.userObj)>
		<cfset var searchstruct = structnew()>
		
		<cfset searchstruct.sort = "created desc">
		<cfset displayObject.setData('orderlist', ordermodel.getOrders("new,pending"))>
		<cfset displayObject.setData('requestObj', arguments.requestObject)>

		<cfset displayObject.setData('searchinfo', 
			ordermodel.search(	requestObject.getformurlvar('searchkeyword')))>
		
	</cffunction>

	<cffunction name="editorder">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		<cfreturn addOrder(displayObject,requestObject,userobj,dispatcher)>
	</cffunction>
	
	<cffunction name="SaveOrder">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var lcl = structnew()>
		
		<cfset var ordermodel = getOrdersModel(arguments.requestObject, arguments.userObj)>
				
		<cfset var requestvars = requestobject.getallformurlvars()>
		
		<cfset ordermodel.setValues(requestVars)>
			
		<cfif ordermodel.save()>
			<cfset lcl.id =ordermodel.getId()>
			<cfset lcl.msg = structnew()>
			<cfif requestObject.getformurlvar('id') EQ ''>
				<cfset lcl.msg.message = "Order Added">
				<cfset lcl.msg.switchtoedit = lcl.id>
			<cfelse>
				<cfset lcl.msg.message = "Order Saved">
			</cfif>
			<cfset lcl.msg.ajaxupdater = structnew()>
			<cfset lcl.msg.ajaxupdater.url = "/Orders/Browse/?id=#lcl.id#">
			<cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			<cfset lcl.msg.ajaxupdater.focusselected = 'true'>
			<cfset lcl.msg.clearvalidation = 1>
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = ordermodel.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
	
	</cffunction>

	<cffunction name="DeleteOrder">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		
		<cfset var lcl = structnew()>
		
		<cfset var orderm = getOrdersModel(arguments.requestObject, arguments.userObj)>

		<cfif orderm.delete(requestObject.getformurlvar('id')) >
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.message = "The Order has been marked as deleted">
			<cfset lcl.msg.ajaxupdater = structnew()>
			<cfset lcl.msg.ajaxupdater.url = "/Orders/Browse/">
			<cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			<cfset lcl.msg.ajaxupdater.focusselected = 'true'>
			<cfset lcl.msg.htmlupdater = structnew()>
			<cfset lcl.msg.htmlupdater.id = "rightContent">
			<cfset lcl.msg.htmlupdater.HTML = "<div id='msg'>The Order has been marked as Deleted </div>">
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = orderm.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
		
	</cffunction>
	
	<cffunction name="Browse">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var ordermodel = getOrdersModel(arguments.requestObject, arguments.userObj)>
		<cfset var searchstruct = structnew()>			
		
		<cfif requestObject.isformurlvarset('id')>
			<cfset displayObject.setData('id', requestObject.getformurlvar('id'))>	
		</cfif>

		<cfset searchstruct.sort = "orderstatus, created desc">
		<cfset displayObject.setData('orderlist', ordermodel.getbyOrderStatus('new',searchstruct))>
		
		<cfset displayObject.showHTML( displayObject.renderTemplateItem("browse") )>
	</cffunction>
	
	<cffunction name="getAvailableOrders">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
	
		<cfset var ordermodel = getOrdersModel(arguments.requestObject, arguments.userObj)>
								
		<cfreturn orderModel.getbyOrderStatus('new')>
	</cffunction>
    
    <cffunction name="getShippingInfo">
    	<cfargument name="shipID" required="yes">
        <cfquery name="getShipID"  datasource="#variables.requestObj.getvar('dsn')#">
        	SELECT * 
            FROM cartShippingQuotes 
            WHERE id	= 	<cfqueryparam value="#shipID#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn getShipID>
    </cffunction>
	
	<cffunction name="checkLoginCredentials">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		
		<cfset var ordermodel = getOrdersModel(arguments.requestObject, arguments.userObj)>
		<cfset var conditions = structnew()>		
		
		<cfset conditions.username = requestObject.getFormUrlVar('username')>
		<cfset conditions.password = hash(requestObject.getFormUrlVar('password'))>
		<cfset conditions.active = 1>

		<cfreturn orderModel.getAll(conditions)>
	</cffunction>
</cfcomponent>