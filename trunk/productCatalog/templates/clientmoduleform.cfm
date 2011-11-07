<cfset lcl.categories = getDataItem('categories')>
<cfset lcl.widgetModel = getDataItem('editableModel')>
<cfset lcl.widgetInfo = lcl.widgetModel.getInfo()>

<cfset lcl.form = createWidget("formcreator")>
<cfset lcl.form.startform()>

<cfsilent>
	<cfset lcl.options = structnew()>
	<cfset lcl.options.options = querynew("label,value")>
	<cfloop query="lcl.categories">
		<cfset queryaddrow(lcl.options.options)>
		<cfset querysetcell(lcl.options.options, "label", "#lcl.categories.name#")>
		<cfset querysetcell(lcl.options.options, "value", "#lcl.categories.id#")>
	</cfloop>
</cfsilent>

<cfset lcl.options.labelskey = 'label'>
<cfset lcl.options.valueskey = 'value'>
<cfset lcl.options.addblank = 1>
<cfset lcl.options.blanktext = "Choose a Catalog">

<cfset lcl.form.addformitem('taxonomyitemid', 'Catalog', false, 'select', lcl.widgetModel.getTaxonomyItemId(), lcl.options)>
<cfset lcl.form.addformitem('moduleaction', 'moduleaction', false, 'hidden', "group")>
<cfset lcl.form.addformitem('id', '', false, 'hidden', lcl.widgetinfo.id)>

<!--- this is for block admin.  --->
<cfif requestObj.getFormUrlVar("view", "default") EQ "block">
	<cfset lcl.form.addformitem('view', '', false, 'hidden', "block")>
</cfif>

<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>
<input type="button" onclick="self.close()" value="Cancel">
<input type="submit" value="Save">

<script>
	window.resizeTo(900, 300);
</script>
