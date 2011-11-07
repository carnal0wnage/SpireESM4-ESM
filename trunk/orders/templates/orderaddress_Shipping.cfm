<cfset lcl.orderinfo = getDataItem('orderinfo')>
<cfset lcl.states = getDataItem('states')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>
<cfset lcl.form.adddisplayitem('Shipping Line 1', lcl.orderinfo.delivery_line1)>
<cfset lcl.form.adddisplayitem('Shipping Line 2', lcl.orderinfo.delivery_line2)>
<cfset lcl.form.adddisplayitem('Shipping City', lcl.orderinfo.delivery_city)>
<cfset lcl.config = structnew()>
<cfset lcl.config.options = lcl.states>
<cfset lcl.config.addblank = 1>
<cfset lcl.config.blanktext = ''>
<cfset lcl.config.labelskey = 'name'>
<cfset lcl.config.valueskey = 'abbrev'>
<cfset lcl.form.adddisplayitem('Shipping State',lcl.orderinfo.delivery_state)>
<cfset lcl.countrystuff = structnew()>
<cfset lcl.countrystuff.options = querynew('value,label')>
<cfset queryaddrow(lcl.countrystuff.options)>
<cfset querysetcell(lcl.countrystuff.options,'value','USA')>
<cfset querysetcell(lcl.countrystuff.options,'label','USA')>
<cfset lcl.form.adddisplayitem('Shipping Country', 'USA')>
<cfset lcl.form.adddisplayitem('ShippingPostal Code',lcl.orderinfo.delivery_postalcode)>

<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>