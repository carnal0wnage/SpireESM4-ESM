<cfcomponent name="cartShippingObservers" extends="resources.abstractObserver">

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
		<cfset lcl.cs.name = "Cart Shipping">
		<cfset lcl.cs.onMenu = "1">
		<cfset lcl.cs.isForm = "1">
        <cfset lcl.cs.isSecurityItem = "1">
        <cfset lcl.cs.order = "1">
        <cfset lcl.cs.formsubmit = "saveShipping">
        <cfset lcl.cs.fileupload = "false">
        <cfset lcl.cs.method = "CartShipping">
		<cfset lcl.cs.template = "onecolumnwnavigation">
		<cfset lcl.cs.templates = arraynew(1)>
		<cfset observed.actions["CartShipping"] = lcl.cs>
        
        <cfset lcl.cs = structnew()>
		<cfset lcl.cs.name = "Save Shipping">
        <cfset lcl.cs.method = "saveshipping">
		<cfset lcl.cs.onMenu = "0">
        <cfset lcl.cs.order = "1">
        <cfset lcl.cs.template = "">
        <cfset lcl.cs.formsubmit = "">
        <cfset lcl.cs.fileupload = "false">
		<!---<cfset lcl.cs.templates = arraynew(1)>--->
        
		<cfset observed.actions["SaveShipping"] = lcl.cs>
		     
		<cfset lcl.cs = structnew()>
        <cfset lcl.cs.file = "cart_shipping/templates/cart_shipping.cfm">
		<cfset lcl.cs.name = "mainContent">
		<cfset lcl.cs.title = "Cart Shipping">		
		<cfset Arrayappend(observed.actions.CartShipping.templates,lcl.cs)>
        
        <cfset lcl.cs = structnew()>
        <cfset lcl.cs.file = "cart_shipping/templates/starttitle.cfm">
		<cfset lcl.cs.name = "title">
		<cfset lcl.cs.title = "label">		
		<cfset Arrayappend(observed.actions.CartShipping.templates,lcl.cs)>
             
		<cfset lcl.cs = structnew()>
        <Cfset lcl.cs.file = "cart_shipping/templates/titlebuttons.cfm">
		<cfset lcl.cs.name = "title">
		<cfset lcl.cs.title = "buttons">			
		<cfset Arrayappend(observed.actions.CartShipping.templates,lcl.cs)>
	
		<cfreturn arguments.observed/>
	</cffunction>
    
	<cffunction name="controllermethod_cart_CartShipping">
		<cfargument name="observed" required="true">
		<cfset csObj = createobject("component","cart_shipping.models.cart_shipping").init(requestObj, session.user)>
		<cfset observed.setdata("cart_shipping",csObj.getAll())>
    	<cfreturn arguments.observed/>
	</cffunction>
      
    <cffunction name="controllermethod_cart_saveShipping">
		<cfargument name="observed" required="true">
        
        <cfset lcl.cartShipObj = createobject("component","cart_shipping.models.cart_shipping")>
		<cfset lcl.opts = requestObj.getFormUrlVar('shippingoptions',"")>
        <cfset lcl.cartShipObj.setShipOption(requestObj, lcl.opts)>
        
		<cfset lcl.msg.message = "Shipping options updated">
		<cfset observed.sendJson( lcl.msg )>
	</cffunction>
    
	 
	
</cfcomponent>