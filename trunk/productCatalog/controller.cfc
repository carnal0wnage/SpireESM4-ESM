<cfcomponent name="products" extends="resources.abstractControllerWEditables">
	
	<cffunction name="init">
		<cfargument name="request" required="true">
		<cfset variables.request = arguments.request>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getModel">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset var mdl = createObject('component','productcatalog.models.products').init(arguments.requestObj, arguments.userObj)>
		<cfset mdl.attachObserver(createObject('component','productcatalog.models.logs').init(arguments.requestObj, arguments.userObj))>
		<cfreturn mdl/>
	</cffunction>
	
	<cffunction name="getLogObj">
		<cfargument name="requestObject">
		<cfargument name="userObj">

		<cfreturn createObject('component','productcatalog.models.logs').init(arguments.requestObject, arguments.userObj)>
	</cffunction>
	
	<!---
    `	<cffunction name="getGroupsModel">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset var mdl = createObject('component','productcatalog.models.productGroups').init(arguments.requestObj, arguments.userObj)>
		<cfset mdl.attachObserver(createObject('component','productcatalog.models.logs').init(arguments.requestObj, arguments.userObj))>
		<cfreturn mdl/>
	</cffunction>
	--->
	<!--- <cffunction name="getImageModel">
		<cfargument name="requestObject">
		<cfargument name="userObj">
		<cfset var mdl = createObject('component','utilities.imageManipulation').init(arguments.requestObject, arguments.userObj)>
		<cfreturn mdl/>
	</cffunction> --->
    
	<cffunction name="StartPage">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">

		<cfset var model = getmodel(requestObject, userObj)>
		<cfset var log = getLogObj(requestObject, userObj)>

		<cfset displayObject.setData('mdl', model	)>
		<cfset displayObject.setData('recentActivity', log.getRecentModuleHistory(requestObject.getModuleFromPath()))>
		<cfset displayObject.setData('requestObj', arguments.requestObject)>
		
		<cfif requestObject.isformurlvarset('sortkey')>
			<cfset displayObject.setWidgetOpen('mainContent','1,2')>
		</cfif>

	</cffunction>
	
	<cffunction name="Search">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">

		<cfset var model = getmodel(arguments.requestObject, arguments.userObj)>
		<cfset var lcl = structNew()>
		<cfset lcl.name = arguments.requestObject.getFormUrlVar('searchkeyword')>
		
		<cfset displayObject.setData('mdl', model)>
		<cfset displayObject.setData('searchResults', model.search(lcl.name))>
		<cfset displayObject.setData('requestObj', arguments.requestObject)>
	</cffunction>
	
	<cffunction name="addProduct">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
	
		<cfset var model = getmodel(requestObject, userObj)>
		<cfset var logs = getlogObj(requestObject, UserObj)>
		<cfset var temp = structnew()>	
		<!--- <cfset var assetsData = dispatcher.callExternalModuleMethod('assets','getAvailableAssets', requestObject, userobj)>	 --->
		<!--- <cfset temp.assetsData = queryNew("id,name","VarChar,VarChar")> --->
				
		<cfset displayObject.setData('taxobj', createObject("component", "taxonomies.models.taxonomyitems").init(requestObject, userobj))>
		<cfset displayObject.setData('requestObj', arguments.requestObject)>

		<!--- <cfloop query="assetsData">
			<cfif listlen(filename,'.')>
				<cfset queryaddrow(temp.assetsData)>
				<cfset querysetcell(temp.assetsData, 'id', assetsData.id[currentrow])>
				<cfset querysetcell(temp.assetsData, 'name', assetsdata.assetgroups_name[currentrow] & ' - ' & assetsData.name[currentrow])>
			</cfif>
		</cfloop>	 --->	
		<!--- <cfset displayObject.setData('assetsList', temp.assetsData)> --->
		
		<cfif requestObject.isformurlvarset('id')>
			<cfset model.load(requestObject.getformurlvar('id'))>
			<cfset displayObject.setData('itemhistory', logs.getRecentModuleItemHistory(requestObject.getModuleFromPath(), requestObject.getformurlvar('id')))>
			<!--- <cfset displayObject.setData('images', getImageParams())> --->
		<cfelse>
			<cfset model.Load(0)>
		</cfif>
		
		<cfset displayObject.setData('mdl', model)>
		
		<cfif requestObject.isformurlvarset('sortdir')>
        	<cfset displayObject.setWidgetOpen('mainContent','2')>
		</cfif>
	
	</cffunction>
	
	<cffunction name="editProduct">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		<cfreturn addProduct(displayObject,requestObject,userObj,dispatcher)>
	</cffunction>
	
	<cffunction name="SaveProduct">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var lcl = structnew()>
		
		<cfset var model = getmodel(requestObject, userobj)>
				
		<cfset var requestvars = requestobject.getallformurlvars()>
		<cfparam name="requestvars.active" default="0">

		<cfset model.setValues(requestVars)>
			
		<cfif model.save()>
			<cfset lcl.id = model.getId()>
			<cfset lcl.msg = structnew()>
            
			<cfif requestObject.isformurlvarset('id') AND requestObject.getformurlvar('id') NEQ "">
				<cfset lcl.msg.message = "Updated Product">
            <cfelse>
            	<cfset lcl.msg.message = "Saved Product">
                <cfset lcl.msg.switchtoedit = lcl.id>
			</cfif>
            
			<cfset lcl.msg.ajaxupdater = structnew()>
            <cfset lcl.msg.ajaxupdater.url = "/productcatalog/Browse/?id=#lcl.id#">
			<cfset lcl.msg.ajaxupdater.focusselected = 'true'>
            <cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = model.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
		
	</cffunction>
	
	<cffunction name="DeleteProduct">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		
		<cfset var lcl = structnew()>
		<cfset var model = getmodel(requestObject, userobj)>
		
		<cfif NOT requestObject.isformurlvarset('id') OR NOT isValid('UUID', requestObject.getFormUrlVar("id"))>
			<cfthrow message="valid id not provided to delete product">
		</cfif>

		<cfif model.destroy(requestObject.getformurlvar('id'))>
			<!--- <cfif DirectoryExists(requestObject.getVar('machineroot') & 'docs/productcatalog/#requestObject.getformurlvar('id')#')>
				<cfdirectory action="delete" directory="#requestObject.getVar('machineroot')#docs/productcatalog/#requestObject.getformurlvar('id')#" recurse="true">
			</cfif> --->
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.message = "The Product has been deleted">
			<cfset lcl.msg.ajaxupdater = structnew()>
			<cfset lcl.msg.ajaxupdater.url = "/productcatalog/Browse/">
			<cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			<cfset lcl.msg.ajaxupdater.focusselected = 'true'>
			<cfset lcl.msg.htmlupdater = structnew()>
			<cfset lcl.msg.htmlupdater.id = "rightContent">
			<cfset lcl.msg.htmlupdater.HTML = "<div id='msg'>Product Deleted</div>">
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = model.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>

	</cffunction>
	
	<cffunction name="Browse">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		
		<cfset var model = getmodel(requestObject, userobj)>
						
		<cfif requestObject.isformurlvarset('id')>
			<cfset displayObject.setData('id', requestObject.getformurlvar('id'))>	
		</cfif>
		
		<cfset displayObject.setData('mdl', model)>
		<cfset displayObject.showHTML( displayObject.renderTemplateItem("browse") )>
	</cffunction>
	
	<cffunction name="GetAvailableProducts">
		<cfargument name="requestObject" required="true">
		<cfargument name="userObj" required="true">
		
		<cfset var model = createObject('component', 
				'products.models.products').init(requestObject, session.user)>
		
		<cfreturn model.getAll()>
	</cffunction>
	
	<cffunction name="editClientModule">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">

		<cfset var editablemodel = getEditableModel(arguments.requestObject, arguments.userObj)>
		<cfset var taxonomyModel = createobject("component", "taxonomies.models.taxonomy").init(requestObject, userObj)>
		

		<cfset displayObject.setData('editablemodel', editablemodel)>
		<cfset displayObject.setData('categories', taxonomymodel.getRelatedTaxonomyItems("product_categories"))>
	</cffunction>
	
	
	<cffunction name="saveClientModule">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">

		<cfset var model = createObject('component', 'productcatalog.models.editable').init(requestObject, userobj)>
		<cfset var lcl = structnew()>
		<cfset var requestvars = requestobject.getallformurlvars()>

		<cfparam name="requestvars.warchives" default="0">

		<cfif find("|", requestvars.moduleaction)>
				<cfset requestvars.itemid = gettoken(requestvars.moduleaction, 2, "|")>
			<cfset requestvars.moduleaction = gettoken(requestvars.moduleaction, 1, "|")>
		<cfelse>
			<cfset requestvars.itemid = "">
		</cfif>
		
		<cfset model.setValues(requestVars)>
	
		<cfif model.save()>
			<cfset lcl.reloadBase = 1>
			<cfset displayObject.sendJson( lcl )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = model.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
	</cffunction>
	
	<!---
    <!--- GroupS --->
    	
	<cffunction name="BrowseGroups">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var model = getGroupsModel(arguments.requestObject, arguments.userObj)>
						
		<cfif requestObject.isformurlvarset('id')>
			<cfset displayObject.setData('id', requestObject.getformurlvar('id'))>	
		</cfif>
		
		<cfset displayObject.setData('list', model.getAll())>
		<cfset displayObject.showHTML( displayObject.renderTemplateItem("browseGroups") )>
	</cffunction>
	
    	<cffunction name="viewProductGroups">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">

		<cfset var model = getGroupsModel(arguments.requestObject, arguments.userObj)>
		<cfset var logs = getLogObj(requestObject, userobj)>

		<cfset displayObject.setData('list', model.getAll())>
		<cfset displayObject.setData('recentActivity', logs.getRecentModuleHistory(requestObject.getModuleFromPath()))>

	</cffunction>
	
	<cffunction name="addProductGroup">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
	
		<cfset var model = getGroupsModel(arguments.requestObject, arguments.userObj)>
		<cfset var logs = getlogObj(argumentcollection = arguments)>
		<cfset var lcl = structnew()>
		
		<cfset displayObject.setData('list', model.getAll())>
		<cfset displayObject.setData('requestObject', arguments.requestObject)>
		<cfset displayObject.setData('userobj', userobj)>

		<cfif requestObject.isformurlvarset('id')>
			<cfset model.load(requestObject.getformurlvar('id'))>
			<cfset displayObject.setData('info', model)>
			<cfset displayObject.setData('itemhistory', logs.getRecentModuleItemHistory(requestObject.getModuleFromPath(), requestObject.getformurlvar('id')))>
		<cfelse>
			<cfset model.Load(0)>
			<cfset displayObject.setData('info', model)>
		</cfif>
	
		<cfset displayObject.setWidgetOpen('mainContent','1')>
		
	</cffunction>
	
	<cffunction name="editProductGroup">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		<cfreturn addProductGroup(displayObject,requestObject,userobj, dispatcher)>
	</cffunction>
	
	<cffunction name="SaveProductGroup">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var lcl = structnew()>
		
		<cfset var model = getGroupsModel(arguments.requestObject, arguments.userObj)>
				
		<cfset var requestvars = requestobject.getallformurlvars()>

		<cfset model.setValues(requestVars)>
		
		<cfif model.save()>
			<cfset lcl.id = model.getId()>
			<cfset lcl.msg = structnew()>
			<cfif requestObject.getformurlvar('id') EQ "">
				<cfset lcl.msg.message = "Product Group Saved">
				<cfset lcl.msg.switchtoedit = lcl.id>
			<cfelse>
				<cfset lcl.msg.message = "Product Group Updated">
			</cfif>
			<cfset lcl.msg.ajaxupdater = structnew()>
			<cfset lcl.msg.ajaxupdater.url = "/productcatalog/BrowseGroups/?id=#lcl.id#">
			<cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			<cfset lcl.msg.ajaxupdater.focusselected = 'true'>
			<cfset lcl.msg.clearvalidation = 1>
			
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = model.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
		
	</cffunction>
	
	<cffunction name="DeleteProductGroup">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var lcl = structnew()>
		<cfset var model = getGroupsModel(arguments.requestObject, arguments.userObj)>
		
		<cfif NOT requestObject.isformurlvarset('id')>
			<cfthrow message="id not provided to deletecontentgroup">
		</cfif>
				
		<cfif model.delete(requestObject.getformurlvar('id'))>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.message = "The Product Group has been deleted">
			<cfset lcl.msg.ajaxupdater = structnew()>
			<cfset lcl.msg.ajaxupdater.url = "/productcatalog/BrowseGroups/">
			<cfset lcl.msg.ajaxupdater.id = 'browse_content'>
			<cfset lcl.msg.ajaxupdater.focusselected = 'true'>
			<cfset lcl.msg.htmlupdater = structnew()>
			<cfset lcl.msg.htmlupdater.id = "rightContent">
			<cfset lcl.msg.htmlupdater.HTML = "<div id='msg'>Product Group Deleted</div>">
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg = structnew()>
			<cfset lcl.msg.validation = model.getValidator().getErrors()>
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>

	</cffunction>
	--->
	<!---
	<cffunction name="uploadImage">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">

	</cffunction>
	
	<cffunction name="uploadImageAction">
		<cfargument name="displayObject" required="true">
		<cfargument name="requestObject" required="true">
		<cfargument name="userobj" required="true">
		<cfargument name="dispatcher" required="true">
		
		<cfset var lcl = structnew()>
		<cfset var info = structnew()>
		<cfset var model = getmodel(requestObject, userObj)>
		
		<cfif NOT isValid('UUID', requestObject.getFormUrlVar("id"))>
			<cfset lcl.msg.message = "Incorrect ID">
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
		
		<cfset info.id = requestObject.getFormUrlVar("id")>
		<cfset model.load(info.id)>
		<cfset lcl.msg = structnew()>
		<cfset lcl.imgparams = getImageParams()>
		<cfset lcl.fileList = ValueList(lcl.imgparams.name)>
		<cfset lcl.flagFileUploaded = false>
	
		<cfloop query="lcl.imgparams">
			<cfset info.filename = name>
			<cfset info.alloweableExtensions = alloweableExtensions>
			<cfif len(trim(requestObject.GetFormUrlVar(info.filename))) GT 0>
				<cfset lcl.uploadInfo =  model.uploadImageFileInfo(info)>
				<cfif lcl.uploadInfo.success EQ 0>
					<cfset lcl.msg.message = lcl.uploadInfo.reason>
					<cfset displayObject.sendJson( lcl.msg )>
				<cfelse>
					<cfset lcl.flagFileUploaded = true>
					<cfif resize EQ 1>
						<cfset model.resizeImage(info,maxwidth,maxheight,getImageModel(arguments.requestObject, arguments.userobj))>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>		

		<cfif lcl.flagFileUploaded>
			<cfset userobj.setFlash("Image Uploaded")>
			<cfset lcl.msg.relocate = "../editProduct/?id=#requestObject.getFormUrlVar("id")#">
			<cfset displayObject.sendJson( lcl.msg )>
		<cfelse>
			<cfset lcl.msg.message = "Please upload an image.">
			<cfset displayObject.sendJson( lcl.msg )>
		</cfif>
	</cffunction>
	
	 <cffunction name="getImageParams">
		<cfset var modulexml = "">
		<cfset var xml = structnew()>
		<cfset var rq = querynew("name,maxwidth,maxheight,extensionmod,resize,alloweableExtensions")>
		<cfinclude template="modulexml.cfm">		
		<cfset xml.imageinfo = xmlsearch(modulexml,"//images/img")>
		
		<cfloop from="1" to="#arraylen(xml.imageinfo)#" index="xml.itr">
			<cfset xml.xmlitem = xml.imageinfo[xml.itr]>
			<cfset queryaddrow(rq)>
			<cfloop list="#rq.columnlist#" index="xml.itr2">
				<cfset querysetcell(rq, xml.itr2, xml.xmlitem.xmlattributes[xml.itr2])>
			</cfloop>
		</cfloop>

		<cfreturn rq/>
	</cffunction>
--->
</cfcomponent>