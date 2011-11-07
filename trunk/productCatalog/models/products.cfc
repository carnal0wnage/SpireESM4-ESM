<cfcomponent name="model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userObj = arguments.userObj>
			
		<cfset setTableMetaData('{	
			"tableName":"products",
			"fields":{
				"name":{"type":"varchar","maxlen":50,"validation":"notblank,maxlength","label":"Name"},
				"title":{"type":"varchar","maxlen":255,"validation":"notblank,maxlength","label":"Title"},
				"description":{"type":"varchar","maxlen":500,"validation":"notblank,maxlength","label":"Description","wysiwyg":1},
				"changedby":{"MAXLEN":35,"TYPE":"varchar","LABEL":"Changedby","VALIDATION":"maxlength,notblank"},
				"urlname":{"MAXLEN":100,"TYPE":"varchar","LABEL":"URL Name","VALIDATION":"maxlength,notblank"},
				"deleted":{"type":"bit","default":0},
				"active":{"type":"bit","default":1},
				"created":{"type":"date"},
				"modified":{"type":"date"},
				"siteid":{"MAXLEN":35,"TYPE":"varchar","LABEL":"Siteid","VALIDATION":"maxlength,notblank"},
				"sizeDescription":{"type":"varchar","maxlen":50,"label":"Size Description","wysiwyg":1},
				"unitspercase":{"type":"int","label":"Units Per Case","VALIDATION":"isinteger,notblank"},
				"unitsperpack":{"type":"int","label":"Units Per Pack","VALIDATION":"isinteger,notblank"},
				"sub_region1":{"type":"varchar","maxlen":50,"label":"Subregion 1"},
				"sub_region2":{"type":"varchar","maxlen":50,"label":"Subregion 1"},
				"mainfilename":{"type":"varchar","maxlen":100},
				"thmbfilename":{"type":"varchar","maxlen":100},
				"assetid":{"type":"varchar","maxlen":35}
			},
			"taxonomies":{
				"region":{"mode":"single", "label":"Region"},
				"country":{"mode":"single", "label":"Country"},
				"classification":{"mode":"single", "label":"Classification"},
				"color":{"mode":"single", "label":"Color"},
				"grape":{"mode":"single", "label":"Grape"},
				"product_categories":{"mode":"single", "validation":"notblank", "label":"Product Categories"}
			}
		}')>
		<!--- "taxonomies":{
				"country":{"mode":"single"},
				"product_categories":{"mode":"single", "validation":"notblank", "label":"Product Categories"},
				"regions":{"mode":"multiple"},
				"grape":{"mode":"single"},
				"price":{"mode":"single"}
			} --->
		<cfset variables.directoryname = "productcatalog">
		<cfset variables.directorypath = variables.requestObj.getVar("machineroot") &  'docs/' & directoryname & '/'>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="uploadImageFileInfo" output="false">
		<cfargument name="info" required="true">
		<cfset var lcl = structNew()>
		<cfset var mainfile = ''>
		<cfset var uploaddirectory = variables.directorypath & info.id>
		<cfset lcl.success = 0>
		<cfset lcl.reason = "File not uploaded.">
		
		<cfif requestObj.isFormUrlVarSet(info.filename) AND len(trim(requestObj.getFormUrlVar(info.filename)))>
				
			<cfif NOT directoryexists(uploaddirectory)>
				<cfdirectory action="create" directory="#uploaddirectory#" mode="664">
			</cfif>
			
			<cfset lcl.params = structNew()>
			<cfset StructInsert(lcl.params, 'target', '#variables.directoryname#/#info.id#')>
			<cfset StructInsert(lcl.params, 'sitepath', variables.requestObj.getVar('machineroot'))>
			<cfset StructInsert(lcl.params, 'file', info.filename)>
			<cfif structkeyexists(info, 'alloweableExtensions')>
				<cfset StructInsert(lcl.params, 'alloweableExtensions', info.alloweableExtensions)>
			</cfif>
			<cfif structkeyexists(variables.itemdata, info.filename)>
				<cfset StructInsert(lcl.params, 'filetodelete', variables.itemdata[info.filename])>
			</cfif>

			<cfset mainfile = createObject('component','utilities.fileuploadandsave').init(argumentCollection = lcl.params)>

			<cfif NOT mainfile.success()>
				<cfset lcl.reason = "File not uploaded. #mainfile.reason()#">
				<cfreturn lcl>
			</cfif>
			
			<cfset variables.itemdata[info.filename] = mainfile.savedName()>
	
			<cfset this.save()>
			<cfset variables.observeEvent('upload #info.filename#', this)>
			<cfset lcl.success = 1>
		</cfif>
		<cfreturn lcl>
	</cffunction>
	
	<cffunction name="resizeImage" output="false">
		<cfargument name="info" required="true">
		<cfargument name="maxwidth" required="true">
		<cfargument name="maxheight" required="true">
		<cfargument name="imgmanipulation" required="true">

		<cfset var filename = variables.directorypath & variables.itemdata.id & "/" & variables.itemdata[info.filename]>
	
		<cfif NOT fileexists(filename)>
			<cfthrow message="Image not found to resize ""#filename#""">
		</cfif>

		<cfset imgmanipulation.resizetomax(filename, maxwidth, maxheight, filename)>
			
	</cffunction>
	
	<cffunction name="search">
		<cfargument name="str" required='true'>
		<cfset var lcl = structnew()>
		<cfquery name="srch" datasource="#requestobj.getVar("dsn")#">
			SELECT * 
			FROM products 
			WHERE title like <cfqueryparam value="%#arguments.str#%" cfsqltype="cf_sql_varchar">
				OR id = <cfqueryparam value="#arguments.str#" cfsqltype="cf_sql_varchar">
			ORDER BY title
		</cfquery>
		<cfreturn srch>
	</cffunction>
</cfcomponent>
	