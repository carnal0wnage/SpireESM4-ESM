<cfcomponent name="productPricingObservers" extends="resources.abstractObserver">
	
	<!--- <cffunction name="alterpagemap_productcatalog_editProduct">
		<cfargument name="observed" required="true">
		<cfset var s = structnew()>
		<cfset s.file = 'productPricing/templates/priceform.cfm'>
		<cfset s.name = 'maincontent'>
		<cfset s.title = "Pricing Info">
		<cfset arrayappend(arguments.observed.templates, s)>
		<cfreturn arguments.observed>
	</cffunction> --->
	
	
	<cffunction name="altertemplatehtml_ProductCatalog_editProduct_title_productCatalog_templates_titlebuttons">
		<cfargument name="observed" required="true">
		<cfset arguments.observed = arguments.observed & "<input type=""button"" value=""Ratings"" onclick=""location.href='../listRatings/?id=#requestObj.getFormUrlvar("id")#';"">">
		<cfreturn arguments.observed/>
	</cffunction>
	
	
	<cffunction name="altermodulesonload_productCatalog">
		<cfargument name="observed" required="true">
		<cfset var s = structnew()>
		<cfset var s2 = structnew()>
		<cfset var t = arraynew(1)>
		
		<!--- list of reviews screen --->
		<cfset s = structnew()>
		<cfset s.fileupload = false>
		<cfset s.formsubmit = "">
		<cfset s.method = 'listratings'>
		<cfset s.name = "Edit Ratings">
		<cfset s.onmenu = 0>
		<cfset s.order = 10>
		<cfset s.template = "twocolumnwnavigation">
		
		<cfset s.templates = arraynew(1)>
				
		<cfset s2 = structnew()>
		<cfset s2.file = 'productCatalog/templates/search.cfm'>
		<cfset s2.name = 'browseContent'>
		<cfset s2.title = "Search">
		<cfset arrayappend(s.templates, s2) >
		
		<cfset s2 = structnew()>
		<cfset s2.file = 'productRatings/templates/listLabel.cfm'>
		<cfset s2.name = 'title'>
		<cfset s2.title = "title">
		<cfset arrayappend(s.templates, s2) >
		
		<cfset s2 = structnew()>
		<cfset s2.file = 'productRatings/templates/listbuttons.cfm'>
		<cfset s2.name = 'title'>
		<cfset s2.title = "title">
		<cfset arrayappend(s.templates, s2) >
			
		<cfset s2 = structnew()>
		<cfset s2.file = 'productRatings/templates/reviewlist.cfm'>
		<cfset s2.name = 'mainContent'>
		<cfset s2.title = "Product Ratings">
		<cfset arrayappend(s.templates, s2) >
	
		<cfset arguments.observed.actions["listRatings"] = s>
		
		<!--- edit screen --->

		<cfset s = structnew()>
		<cfset s.fileupload = false>
		<cfset s.formsubmit = 'saveRating'>
		<cfset s.method = 'editratings'>
		<cfset s.name = "Edit Ratings">
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
		<cfset s2.file = 'productRatings/templates/formLabel.cfm'>
		<cfset s2.name = 'title'>
		<cfset s2.title = "title">
		<cfset arrayappend(s.templates, s2) >
		
		<cfset s2 = structnew()>
		<cfset s2.file = 'productRatings/templates/formButtons.cfm'>
		<cfset s2.name = 'title'>
		<cfset s2.title = "title">
		<cfset arrayappend(s.templates, s2) >
			
		<cfset s2 = structnew()>
		<cfset s2.file = 'productRatings/templates/ratingForm.cfm'>
		<cfset s2.name = 'mainContent'>
		<cfset s2.title = "Product Prices">
		<cfset arrayappend(s.templates, s2) >
	
		<cfset arguments.observed.actions["editRating"] = s>
		
		<cfset s = structnew()>
		<cfset s.fileupload = false>
		<cfset s.formsubmit = "">
		<cfset s.method="saverating">
		<cfset s.name = "Save Ratings">
		<cfset s.onmenu = 0>
		<cfset s.order = 11>
		<cfset s.template = "">
		<cfset arguments.observed.actions['saverating'] = s>
		
		<cfset s = structnew()>
		<cfset s.fileupload = false>
		<cfset s.formsubmit = "">
		<cfset s.method="deleterating">
		<cfset s.name = "Delete Ratings">
		<cfset s.onmenu = 0>
		<cfset s.order = 11>
		<cfset s.template = "">
		<cfset arguments.observed.actions['deleterating'] = s>

		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="controllermethod_productCatalog_listRatings">
		<cfargument name="observed" required="true">
		
		<cfset var ratingsmodel = createObject("component", "productRatings.models.productRatings").init(requestObj, session.user)>
		<cfset var productmodel = createObject("component", "productCatalog.models.products").init(requestObj, session.user)>
		
		<cfset var lcl = structnew()>
		
		<cfset productmodel.load(requestObj.getFormUrlVar("id"))>
		<cfset lcl.s = structnew()>
		<cfset lcl.s.sort = "rating">
		<cfset arguments.observed.setData('ratingslist', ratingsmodel.getByProductId(requestObj.getFormUrlVar("id"), lcl.s))>
		<cfset arguments.observed.setData('productmdl', productmodel)>
		<cfset arguments.observed.setData('taxobj', createObject("component", "taxonomies.models.taxonomyitems").init(requestObj, session.user))>
		
		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="controllermethod_productCatalog_editRating">
		<cfargument name="observed" required="true">
		
		<cfset var ratingsmodel = createObject("component", "productRatings.models.productRatings").init(requestObj, session.user)>
		<cfset var productmodel = createObject("component", "productCatalog.models.products").init(requestObj, session.user)>
		<cfset var lcl = structnew()>
		
		<cfif requestObj.isformurlvarset('id')>
			<cfset ratingsmodel.load(requestObj.getformurlvar('id'))>
		<cfelse>
			<cfset ratingsmodel.setProductId(requestObj.getformurlvar('productid'))>
			<cfset ratingsmodel.setActive(1)>
		</cfif>
		
		<cfset productmodel.load(requestObj.getFormUrlVar("productid"))>
		
		<cfset arguments.observed.setData('productmdl', productmodel)>
		<cfset arguments.observed.setData('ratingsmdl', ratingsmodel)>
		<cfset arguments.observed.setData('taxobj', createObject("component", "taxonomies.models.taxonomyitems").init(requestObj, session.user))>
		
		<cfreturn arguments.observed/>
	</cffunction>
	
	<cffunction name="controllermethod_productCatalog_saveRating">
		<cfargument name="observed" required="true">
		
		<cfset var ratingsmodel = createObject("component", "productRatings.models.productRatings").init(requestObj, session.user)>
		<cfset var lcl = structnew()>
		<cfset var requestvars = requestobj.getallformurlvars()>
		
		<cfset lcl.msg = structnew()>
		
		<cfparam name="requestvars.active" default="0">

		<cfset ratingsmodel.setValues(requestVars)>

		<cfif ratingsmodel.save()>
			<cfset lcl.id = ratingsmodel.getId()>
			<cfset lcl.msg = structnew()>
            
			<cfif requestObj.isformurlvarset('id') AND requestObj.getformurlvar('id') NEQ "">
				<cfset session.user.setFlash("Rating Updated")>
            <cfelse>
            	<cfset session.user.setFlash("Rating Added")>
			</cfif>
			
			<cfset lcl.msg.relocate = '/productCatalog/listratings/?id=#requestObj.getFormUrlVar("productid")#'>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = ratingsmodel.getValidator().getErrors()>
		</cfif>
		
		<cfset arguments.observed.sendJson( lcl.msg )>
	</cffunction>
	
	<cffunction name="controllermethod_productCatalog_deleteRating">
		<cfargument name="observed" required="true">
		
		<cfset var ratingsmodel = createObject("component", "productRatings.models.productRatings").init(requestObj, session.user)>
		
		<cfif ratingsmodel.delete(requestobj.getFormUrlVar("id"))>
			<cfset session.user.setFlash("Rating Deleted")>
           	<cfset lcl.msg.relocate = '/productCatalog/listratings/?id=#requestObj.getFormUrlVar("productid")#'>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = ratingsmodel.getValidator().getErrors()>
		</cfif>
		
		<cfset arguments.observed.sendJson( lcl.msg )>
	</cffunction>
	
</cfcomponent>