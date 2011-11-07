<cfcomponent name="Customers" extends="resources.abstractController">
	
	<cffunction name="getcustomersModel">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset var m = createObject("component", "customers.models.customers").init(arguments.requestObj, arguments.userObj)>
		<cfset m.attachObserver(getLogObj(arguments.requestObj, arguments.userObj))>
		<cfreturn m>
	</cffunction>
	
	<cffunction name="getLogObj">
		<cfargument name="requestObject">
		<cfargument name="userObj">

		<cfreturn createObject('component','customers.models.logs').init(arguments.requestObject, arguments.userObj)>
	</cffunction>
	
	<cffunction name="startPage">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var mdl = getcustomersmodel(requestObject, userObj)>
				
		<cfset displayObject.setData('browse', mdl.getAll())>
	</cffunction>
	
	<cffunction name="addCustomer">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
	
		<cfset var mdl = getcustomersmodel(requestObject, userObj)>
		<cfset var temp = structnew()>	
		<cfset var logs = getlogObj(argumentcollection = arguments)>
		
		<cfset displayObject.setData('browse', mdl.getAll())>
			
		<cfif requestObject.isformurlvarset('id')>
			<cfset mdl.load(requestObject.getformurlvar('id'))>
			<cfset displayObject.setData('history', logs.getRecentModuleItemHistory(requestObject.getModuleFromPath(), requestObject.getformurlvar('id')))>
			<cfset displayObject.setData('Customer', mdl)>
		<cfelse>
			<cfset mdl.Load(0)>
			<cfset displayObject.setData('Customer', mdl)>
		</cfif>

		<cfif requestObject.isformurlvarset('sortdir')>
			<cfset displayObject.setWidgetOpen('mainContent','2')>
		</cfif>
			
		<cfif requestObject.isformurlvarset('search')>
			<cfset displayObject.setData('search', 
				model.search(
					requestObject.getformurlvar('search')))>
		</cfif>
	
	</cffunction>
	
	<cffunction name="editCustomer">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">
		<cfargument name="dispatcher" required="true">
		<cfreturn addCustomer(displayObject,requestObject,userObj,dispatcher)>
	</cffunction>
	
	<cffunction name="DeleteCustomer">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">
		
		<cfset var lcl = structnew()>
		<cfset var mdl = getCustomermodel(requestObject, userObj)>
		
		<!---<cfset mdl.load(requestObject.getformurlvar('id'))>--->
				
		<cfif NOT requestObject.isformurlvarset('id')>
			<cfthrow message="id not provided to delete news">
		</cfif>

		<cfif mdl.delete(requestObject.getformurlvar('id'))>
			<!---<cfset lcl.fs = createObject('component','utilities.filesystem').init()>
			<cfif lcl.filename NEQ "">
				<cfset lcl.fs = createObject('component','utilities.filesystem').init()>
				<cfset lcl.siteinfo = application.sites.getSite(arguments.userObj.getCurrentSiteId())>
				<cfset fs.delete(lcl.siteinfo.machineRoot & 'docs/news/' & lcl.filename)>
			</cfif>--->
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.message = "The Customer Item has been deleted">
			<cfset lcl.msg.ajaxupdater = structnew()>
			<cfset lcl.msg.ajaxupdater.url = "/customers/Browse/">
			<cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			<cfset lcl.msg.htmlupdater = structnew()>
			<cfset lcl.msg.htmlupdater.id = "rightContent">
			<cfset lcl.msg.htmlupdater.HTML = "<div id='msg'>Customer Item Deleted</div>">
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = mdl.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
	</cffunction>
	
	<cffunction name="SaveCustomer">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var lcl = structnew()>
		<cfset var mdl = getCustomersModel(requestObject, userobj)>
		<cfset var requestvars = requestobject.getallformurlvars()>

		<cfset mdl.setValues(requestVars)>
			
		<cfif mdl.save()>
			<cfset lcl.id = mdl.getId()>
			<cfset lcl.msg = structnew()>
            
			<cfif requestObject.isformurlvarset('id') AND requestObject.getformurlvar('id') NEQ "">
				<cfset lcl.msg.message = "Updated Customer">
            <cfelse>
            	<cfset lcl.msg.message = "Saved Customer">
                <cfset lcl.msg.switchtoedit = lcl.id>
			</cfif>
            
			<cfset lcl.msg.ajaxupdater = structnew()>
            <cfset lcl.msg.ajaxupdater.url = "/customers/Browse/?id=#lcl.id#">
            <cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = mdl.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
	</cffunction>
	
	<cffunction name="Search">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">

		<cfset var mdl = getCustomersmodel(requestObject, userObj)>

		<cfset displayObject.setData('browse', mdl.getAll())>
		
		<cfset displayObject.setData('searchResults', mdl.search(arguments.requestObject.getFormUrlVar('searchkeyword')))>
	</cffunction>

	<cffunction name="Browse">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">
		
		<cfset var mdl = getCustomersmodel(requestObject, userObj)>
		
		<cfset displayObject.setData('browse', mdl.getAll())>
		<cfset displayObject.showHTML( displayObject.renderTemplateItem("browse") )>
	</cffunction>
	
</cfcomponent>
