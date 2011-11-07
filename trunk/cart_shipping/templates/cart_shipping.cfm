<cfset lcl.cs = getDataItem('cart_shipping')>
<cfset lcl.form = createWidget("formcreator")>

Please choose whether the following cart shipping options will be enabled for your customers during checkout. <br /><br />
<cfset lcl.form.startform()>
<cfset lcl.sel = arraynew(1)>

<cfloop query = "lcl.cs">
	<cfset lcl.cs.id[lcl.cs.currentrow] = rereplace(lcl.cs.id, "[^a-zA-Z0-9,]", "_", "all")>
	<cfif lcl.cs.enabled>
    	<cfset arrayappend(lcl.sel, lcl.cs.id)>
    </cfif>
</cfloop>

<cfset lcl.sel = arraytolist(lcl.sel)>

<cfset lcl.strctOptions = structnew()>
<cfset lcl.strctOptions.options = lcl.cs>
<cfset lcl.strctOptions.labelskey = "name">
<cfset lcl.strctOptions.valueskey = "id">
<cfset lcl.form.addformitem("shippingoptions", '', false, 'checkbox', lcl.sel, lcl.strctOptions)>
<cfset lcl.form.endform()>
<cfoutput>#lcl.form.showHTML()#</cfoutput>
