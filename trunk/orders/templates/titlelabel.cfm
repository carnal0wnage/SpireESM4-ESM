<cfset lcl.orderinfo = getDataItem('orderinfo')>
<cfset lcl.form = createWidget("formcreator").init()>
<cfset lcl.form.startForm()>
<!---<cfset lcl.unextra = structnew()>
<cfset lcl.unextra.style = "width:200px">
<cfset lcl.form.addformitem('billing_name', 'Your Name', true, 'text', lcl.userinfo.billing_name, lcl.unextra)>--->
<cfset lcl.form.adddisplayitem('Billing Name',lcl.orderinfo.billing_name)>
<cfset lcl.form.endForm()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>