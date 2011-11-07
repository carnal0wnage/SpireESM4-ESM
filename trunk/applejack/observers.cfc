<cfcomponent name="Applejack bservers"  extends="resources.abstractObserver">

	<cffunction name="altermodulesonload_productCatalog">
		<cfargument name="observed" required="true">
		<cfset var s = structnew()>

		<!--- remvoe all the browses since they hve so many products --->
		<cfloop collection="#arguments.observed.actions#" item="s.item">
			<cfset s.action = arguments.observed.actions[s.item]>

			<cfif isdefined("s.action.templates") 
				AND arraylen(s.action.templates)
					AND s.action.templates[1].title EQ "browse">
				<cfset arraydeleteat(arguments.observed.actions[s.item].templates,1)>
			</cfif>
		</cfloop>

		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="altermodulesonload_cart">
		<cfargument name="observed" required="true">

		 <!---
		<action name="Client Shipping" onMenu="1" isForm="1" template="onecolumnwnavigation">
			<template name="browseContent" id="browse" title="Browse" file=""/>
			<template name="browseContent" title="Search" file=""/>
			<template name="title" title="label" file=""/>
			<template name="title" title="buttons" file=""/>
			<template name="mainContent" title="Properties" file=""/>
		</action>
		--->
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.name = "AJ Delivery Options">
		<cfset lcl.cs.onMenu = "1">
		<cfset lcl.cs.isForm = "1">
        <cfset lcl.cs.isSecurityItem = "1">
        <cfset lcl.cs.order = "2">
        <cfset lcl.cs.formsubmit = "">
        <cfset lcl.cs.fileupload = "false">
        <cfset lcl.cs.method = "AJDeliveryOptions">
		<cfset lcl.cs.template = "twocolumnwnavigation">
		<cfset lcl.cs.templates = arraynew(1)>
		<cfset observed.actions["AJDeliveryOptions"] = lcl.cs>
      		     
		<cfset lcl.cs = structnew()>
        <cfset lcl.cs.file = "applejack/templates/delivery_options_browse.cfm">
		<cfset lcl.cs.name = "browseContent">
		<cfset lcl.cs.title = "Cart Shipping Options">		
		<cfset Arrayappend(observed.actions.AJDeliveryOptions.templates,lcl.cs)>
		
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.file = "applejack/templates/cart_delivery_intro.cfm">
		<cfset lcl.cs.name = "mainContent">
		<cfset lcl.cs.title = "Cart Shipping">			
		<cfset Arrayappend(observed.actions.AJDeliveryOptions.templates,lcl.cs)>
        
        <cfset lcl.cs = structnew()>
        <cfset lcl.cs.file = "cart_shipping/templates/starttitle.cfm">
		<cfset lcl.cs.name = "title">
		<cfset lcl.cs.title = "label">
		<cfset Arrayappend(observed.actions.AJDeliveryOptions.templates,lcl.cs)>
       
	 	<cfset lcl.cs = structnew()>
        <cfset lcl.cs.file = "applejack/templates/cart_delivery_options_startbuttons.cfm">
		<cfset lcl.cs.name = "title">
		<cfset lcl.cs.title = "label">				
		<cfset Arrayappend(observed.actions.AJDeliveryOptions.templates,lcl.cs)>
            

		<cfset lcl.cs = structnew()>
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.name = "AJ Delivery Options Form">
		<cfset lcl.cs.onMenu = "0">
		<cfset lcl.cs.isForm = "1">
        <cfset lcl.cs.isSecurityItem = "1">
        <cfset lcl.cs.order = "2">
        <cfset lcl.cs.formsubmit = "SaveAJdeliveryOption">
        <cfset lcl.cs.fileupload = "false">
        <cfset lcl.cs.method = "AJDeliveryOptionsForm">
		<cfset lcl.cs.template = "twocolumnwnavigation">
		<cfset lcl.cs.templates = arraynew(1)>
		
		<cfset observed.actions["AJDeliveryOptionsForm"] = lcl.cs>
	     
		<cfset lcl.cs = structnew()>
		
        <cfset lcl.cs.file = "applejack/templates/delivery_options_browse.cfm">
		<cfset lcl.cs.name = "browseContent">
        <cfset lcl.cs.method = "">
        <cfset lcl.cs.formsubmit = "">
		<cfset lcl.cs.title = "Cart Shipping Options">
		<cfset lcl.cs.onMenu = "0">				
		<cfset Arrayappend(observed.actions.AJDeliveryOptionsForm.templates,lcl.cs)>
		
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.file = "applejack/templates/cart_delivery_options_form.cfm">
		<cfset lcl.cs.name = "mainContent">
		<cfset lcl.cs.title = "Cart Shipping">
		<cfset Arrayappend(observed.actions.AJDeliveryOptionsForm.templates,lcl.cs)>
        
        <cfset lcl.cs = structnew()>
        <cfset lcl.cs.file = "applejack/templates/cart_delivery_options_title.cfm">
		<cfset lcl.cs.name = "title">
		<cfset lcl.cs.title = "label">
		<cfset Arrayappend(observed.actions.AJDeliveryOptionsForm.templates,lcl.cs)>
       
	 	<cfset lcl.cs = structnew()>
        <cfset lcl.cs.file = "applejack/templates/cart_delivery_options_startbuttons.cfm">
		<cfset lcl.cs.name = "title">
		<cfset lcl.cs.title = "label">
		<cfset Arrayappend(observed.actions.AJDeliveryOptionsForm.templates,lcl.cs)>

		<cfset lcl.cs = structnew()>
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.name = "Add AJ Delivery Zip">
		<cfset lcl.cs.onMenu = "0">
		<cfset lcl.cs.isForm = "0">
        <cfset lcl.cs.isSecurityItem = "1">
        <cfset lcl.cs.order = "2">
        <cfset lcl.cs.formsubmit = "">
        <cfset lcl.cs.fileupload = "false">
        <cfset lcl.cs.method = "AddAjDeliveryZip">
		<cfset lcl.cs.template = "">
		<cfset lcl.cs.templates = arraynew(1)>
		
		<cfset observed.actions["AddAJDeliveryzip"] = lcl.cs>
		
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.name = "Remove AJ Delivery Zip">
		<cfset lcl.cs.onMenu = "0">
		<cfset lcl.cs.isForm = "0">
        <cfset lcl.cs.isSecurityItem = "1">
        <cfset lcl.cs.order = "2">
        <cfset lcl.cs.formsubmit = "">
        <cfset lcl.cs.fileupload = "false">
        <cfset lcl.cs.method = "RemoveAjDeliveryZip">
		<cfset lcl.cs.template = "">
		<cfset lcl.cs.templates = arraynew(1)>
		
		<cfset observed.actions["RemoveAJDeliveryzip"] = lcl.cs>

		<cfset lcl.cs = structnew()>
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.name = "Save AJ Delivery Option">
		<cfset lcl.cs.onMenu = "0">
		<cfset lcl.cs.isForm = "0">
        <cfset lcl.cs.isSecurityItem = "1">
        <cfset lcl.cs.order = "2">
        <cfset lcl.cs.formsubmit = "">
        <cfset lcl.cs.fileupload = "false">
        <cfset lcl.cs.method = "SaveAjDeliveryOption">
		<cfset lcl.cs.template = "">
		<cfset lcl.cs.templates = arraynew(1)>
		
		<cfset observed.actions["SaveAJDeliveryOption"] = lcl.cs>

		<cfset lcl.cs = structnew()>
		<cfset lcl.cs = structnew()>
		<cfset lcl.cs.name = "Delete AJ Delivery Option">
		<cfset lcl.cs.onMenu = "0">
		<cfset lcl.cs.isForm = "0">
        <cfset lcl.cs.isSecurityItem = "1">
        <cfset lcl.cs.order = "2">
        <cfset lcl.cs.formsubmit = "">
        <cfset lcl.cs.fileupload = "false">
        <cfset lcl.cs.method = "DeleteAjDeliveryOption">
		<cfset lcl.cs.template = "">
		<cfset lcl.cs.templates = arraynew(1)>
		
		<cfset observed.actions["DeleteAJDeliveryOption"] = lcl.cs>

		
		
		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="controllermethod_cart_ajdeliveryoptions">
		<cfargument name="observed" required="true">
		<cfset csObj = createobject("component","applejack.models.ajShippingOptions").init(requestObj, session.user)>
        <cfset observed.setdata("browse",csObj.getAll())>
    	<cfreturn arguments.observed/>
	</cffunction>

	<cffunction name="controllermethod_cart_ajdeliveryoptionsform">
		<cfargument name="observed" required="true">
		<cfset var lcl = structnew()> 
		<cfset lcl.optionsObj = createobject("component","applejack.models.ajShippingOptions").init(requestObj, session.user)>

        <cfset observed.setdata("browse",lcl.optionsObj.getAll())>
		
		<cfif requestObj.isformurlvarset('id')>
			<cfset lcl.optionsObj.load(requestObj.getformurlvar('id'))>
			<cfset lcl.zipsinoptionsObj = createobject("component","applejack.models.ajShippingZips").init(requestObj, session.user)>
			<cfset observed.setData("zips", lcl.zipsinoptionsobj.getByShippingId(requestObj.getformurlvar('id')))>
		<cfelse>
			<cfset lcl.optionsObj.Load(0)>
		</cfif>
		<cfset observed.setdata("item", lcl.optionsObj)>
		
    	<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="controllermethod_cart_addAjDeliveryZip">
		<cfargument name="observed" required="true">
		<cfset var lcl = structnew()> 
		<cfset var data = structnew()>
		
		<cfset data.zip = requestobj.getformurlvar("Zip")>
		<cfset data.shippingid = requestobj.getformurlvar("gid")>
		
		<cfset lcl.model = createobject("component","applejack.models.ajShippingZips").init(requestObj, session.user)>
				
		<cfset lcl.model.setValues(data)>
		
		<cfif lcl.model.save()>
			<cfset lcl.msg = structnew()>	
			<cfset session.user.setFlash("The Zip has been Added.")>
			<cfset lcl.msg.relocate = "../AjDeliveryOptionsForm/?id=#data.shippingid#">
			<cfset observed.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = lcl.model.getValidator().getErrors()>
			<cfset observed.sendJson( lcl.msg )>
		</cfif>

	</cffunction>
	
	<cffunction name="controllermethod_cart_removeAjDeliveryZip">
		<cfargument name="observed" required="true">
		<cfset var lcl = structnew()> 
		<cfset var data = structnew()>
		
		<cfif NOT requestObj.isformurlvarset('id')>
			<cfthrow message="id not provided to delete news">
		</cfif>
		
		<cfset data.id = requestobj.getformurlvar("id")>
		<cfset data.shippingid = requestobj.getformurlvar("gid")>
		
		<cfset lcl.model = createobject("component","applejack.models.ajShippingZips").init(requestObj, session.user)>
				
		<cfset lcl.model.setValues(data)>
		
		<cfif lcl.model.destroy(requestObj.getformurlvar('id'))>
			<cfset lcl.msg = structnew()>	
			<cfset session.user.setFlash("The Zip #requestObj.getFormUrlVar("zip")# has been Removed.")>
			<cfset lcl.msg.relocate = "../AjDeliveryOptionsForm/?id=#data.shippingid#">
			<cfset observed.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = lcl.model.getValidator().getErrors()>
			<cfset observed.sendJson( lcl.msg )>
		</cfif>
	</cffunction>

	<cffunction name="controllermethod_cart_saveAJDeliveryOption">
		<cfargument name="observed" required="true">
        
        <cfset var lcl = structnew()>
		
		<cfset var model = createObject("component", "applejack.models.ajShippingOptions").init(variables.requestObj, session.user)>
				
		<cfset var requestvars = requestobj.getallformurlvars()>
		
		<cfset model.setValues(requestVars)>
			
		<cfif model.save()>
			<cfset lcl.id = model.getId()>
			<cfset lcl.msg = structnew()>
			<cfset session.user.setFlash("Option saved")>
			<cfset lcl.msg.relocate = "../AjDeliveryOptionsForm/?id=#lcl.id#">
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = Model.getValidator().getErrors()>
		</cfif>
		
		<cfset observed.sendJson( lcl.msg )>
	</cffunction>
	
	<cffunction name="controllermethod_cart_deleteAjDeliveryOption">
		<cfargument name="observed" required="true">
		<cfset var lcl = structnew()> 
		<cfset var data = structnew()>
		
		<cfif NOT requestObj.isformurlvarset('id')>
			<cfthrow message="id not provided to delete option">
		</cfif>
		
		<cfset data.id = requestobj.getformurlvar("id")>
				
		<cfset lcl.model = createobject("component","applejack.models.ajShippingOptions").init(requestObj, session.user)>
				
		<cfset lcl.model.setValues(data)>
		
		<cfif lcl.model.destroy(data.id)>
			<cfset lcl.zipobj = createobject("component","applejack.models.ajShippingZips").init(requestObj, session.user)>
			<cfset lcl.zips = lcl.zipobj.getByShippingId(data.id)>
			
			<cfloop query="lcl.zips">
				<cfset lcl.zipobj.destroy(lcl.zips.id)>
			</cfloop>
			
			<cfset lcl.msg = structnew()>	
			<cfset session.user.setFlash("The Option has been Removed.")>
			<cfset lcl.msg.relocate = "../AjDeliveryOptions/">
			<cfset observed.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = lcl.model.getValidator().getErrors()>
			<cfset observed.sendJson( lcl.msg )>
		</cfif>
	</cffunction>
</cfcomponent>