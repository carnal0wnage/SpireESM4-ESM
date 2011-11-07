<cfcomponent name="productPricingObservers" extends="resources.abstractObserver">
	
	<!--- <cffunction name="alterpagemap_productcatalog_editProduct">
		<cfargument name="observed" required="true">
		<cfset var s = structnew()>
		<cfset s.file = 'productPricing/templates/pricingform.cfm'>
		<cfset s.name = 'maincontent'>
		<cfset s.title = "Pricing Info">
		<cfset arrayappend(arguments.observed.templates, s)>
		<cfreturn arguments.observed>
	</cffunction>
	
	<cffunction name="alterdatas_productcatalog_editProduct">
		<cfargument name="observed" required="true">
		<cfset arguments.observed.what = structkeylist(observed)>
		<cfreturn arguments.observed>
	</cffunction>
	 --->
	<cffunction name="altertemplatehtml_ProductCatalog_editProduct_title_productCatalog_templates_titlebuttons">
		<cfargument name="observed" required="true">
		<cfset arguments.observed = arguments.observed & "<input type=""button"" value=""Prices"" onclick=""location.href='../editPrices/?id=#requestObj.getFormUrlvar("id")#';"">">
		<cfreturn arguments.observed/>
	</cffunction>
	
	
	<cffunction name="altermodulesonload_productCatalog">
		<cfargument name="observed" required="true">
		<cfset var s = structnew()>
		<cfset var s2 = structnew()>
		<cfset var t = arraynew(1)>

		<cfset s.fileupload = false>
		<cfset s.formsubmit = 'saveprices'>
		<cfset s.method = 'editprices'>
		<cfset s.name = "Edit Prices">
		<cfset s.onmenu = 0>
		<cfset s.order = 10>
		<cfset s.template = "twocolumnwnavigation">
		
		<cfset s.templates = arraynew(1)>
		<!---
		<cfset s2.file = 'productCatalog/templates/browse.cfm'>
		<cfset s2.name = 'browseContent'>
		<cfset s2.id = 'browse'>
		<cfset s2.title = "Browse">
		<cfset arrayappend(s.templates, s2) >
		--->
		
		<cfset s2 = structnew()>
		<cfset s2.file = 'productCatalog/templates/search.cfm'>
		<cfset s2.name = 'browseContent'>
		<cfset s2.title = "Search">
		<cfset arrayappend(s.templates, s2) >
		
		<cfset s2 = structnew()>
		<cfset s2.file = 'productPricing/templates/titleLabel.cfm'>
		<cfset s2.name = 'title'>
		<cfset s2.title = "title">
		<cfset arrayappend(s.templates, s2) >
		
		<cfset s2 = structnew()>
		<cfset s2.file = 'productPricing/templates/titlebuttons.cfm'>
		<cfset s2.name = 'title'>
		<cfset s2.title = "buttons">
		<cfset arrayappend(s.templates, s2) >
		
		<cfset s2 = structnew()>
		<cfset s2.file = 'productPricing/templates/priceForm.cfm'>
		<cfset s2.name = 'mainContent'>
		<cfset s2.title = "Product Prices">
		<cfset arrayappend(s.templates, s2) >
	
		<cfset arguments.observed.actions["editPrices"] = s>
		
		<cfset s = structnew()>
		<cfset s.fileupload = false>
		<cfset s.formsubmit = "">
		<cfset s.method="saveprices">
		<cfset s.name = "Save Prices">
		<cfset s.onmenu = 0>
		<cfset s.template = "not used">
		<cfset s.order = 11>
		<cfset s.template = "">
		<cfset arguments.observed.actions['saveprices'] = s>
		
		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="controllermethod_productCatalog_editPrices">
		<cfargument name="observed" required="true">
		
		<cfset var productmodel = createObject("component", "productCatalog.models.products").init(requestObj, session.user)>
		<cfset var productPricesModel = createObject("component", "productPricing.models.productprices").init(requestObj, session.user)>
		<cfset var productPricesTypesModel = createObject("component", "productPricing.models.productpricetypes").init(requestObj, session.user)>
		<cfset var lcl = structnew()>
		
		<cfset productmodel.load(requestObj.getFormUrlVar("id"))>
		<cfset lcl.productPrices = productPricesModel.getByProductId(requestObj.getFormUrlVar("id"))>
		
		<cfset arguments.observed.setData('mdl', productmodel)>
		<cfset arguments.observed.setData('productprices', productPricesModel.getByProductId(requestObj.getFormUrlVar("id")))>
		
		<cfset lcl.s = structnew()>
		<cfset lcl.s.sort = "sortkey">
		
		<cfset arguments.observed.setData('productpricetypes', productPricesTypesModel.getAll(lcl.s))>

		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="controllermethod_productCatalog_savePrices">
		<cfargument name="observed" required="true">
		
		<cfset var productPricesModel = createObject("component", "productPricing.models.productprices").init(requestObj, session.user)>
		<cfset var productPricesTypesModel = createObject("component", "productPricing.models.productpricetypes").init(requestObj, session.user)>
		<cfset var lcl = structnew()>
		
		<cfset lcl.msg = structnew()>
		<cfset lcl.productPrices = productPricesModel.getByProductId(requestObj.getFormUrlVar("id"))>
		<cfset lcl.sorts = structnew()>
		<cfset lcl.sorts.sort = 'sortkey'>
		<cfset lcl.priceTypes = productPricesTypesModel.getAll(lcl.sorts)>
		
		<!--- validate first --->
		<cfset lcl.vdtr = getUtility("datavalidator").init()>
		
		<cfloop query="lcl.priceTypes">
			<cfloop list="price,price_sale,price_member" index="lcl.pricetype">
				<cfset lcl.thisprice = requestObj.getFormUrlVar("#type#_#lcl.pricetype#")>
				<cfif lcl.thisprice NEQ "">
					<cfset lcl.vdtr.isnumber("#type#_#lcl.pricetype#", lcl.thisprice, "#type# : #lcl.pricetype# must be a number.")>
				</cfif>
			</cfloop>
		</cfloop>
		
		<cfif NOT lcl.vdtr.passvalidation()>
			<cfset lcl.msg.validation = lcl.vdtr.getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
		
		<!--- make map of input data for easy saving --->
		<cfset lcl.s = structnew()>
		<cfloop query="lcl.productprices">	
			<cfset lcl.s[type] = structnew()>
			<cfset lcl.s[type].id = id>
			<cfset lcl.s[type].price = price>
			<cfset lcl.s[type].price_sale = price_sale>
			<cfset lcl.s[type].price_member = price_member>
		</cfloop>

		<cfloop query="lcl.priceTypes">
			<cfset productPricesModel.clear()>
			<cfset lcl.thistypepricesform = structnew()>
			
			<cfloop list="price,price_sale,price_member" index="lcl.pricetype">
				<cfset lcl.thistypepricesform[lcl.pricetype] = requestObj.getFormUrlVar("#type#_#lcl.pricetype#")>
				<cfif lcl.thistypepricesform[lcl.pricetype] EQ "">
					<cfset lcl.thistypepricesform[lcl.pricetype] = 0>
				</cfif>
			</cfloop>
			
			<cfif structkeyexists(lcl.s, type)>
				<cfset productPricesModel.load(lcl.s[type].id)>
				<cfset productPricesModel.setPrice( lcl.thistypepricesform['price'])>
				<cfset productPricesModel.setPrice_sale( lcl.thistypepricesform["price_sale"])>
				<cfset productPricesModel.setPrice_member( lcl.thistypepricesform['price_member'])>
				<cfset productPricesModel.save()>
			<cfelse>
				<cfset productPricesModel.setPrice( lcl.thistypepricesform['price'])>
				<cfset productPricesModel.setPrice_sale( lcl.thistypepricesform['price_sale'])>
				<cfset productPricesModel.setPrice_member( lcl.thistypepricesform["price_member"])>
				<cfset productPricesModel.setProductId(requestObj.getFormUrlVar("id"))>
				<cfset productPricesModel.setType(type)>
				<cfset productPricesModel.save()>
			</cfif>
		</cfloop>
		
		<cfset session.user.setFlash("Prices updated")>
		<cfset lcl.msg.relocate="/productCatalog/editProduct/?id=#requestObj.getFormUrlVar("id")#">
		<cfset arguments.observed.sendJson( lcl.msg )>

	</cffunction>
	
</cfcomponent>