<cfset lcl.orderinfo = getDataItem('orderinfo')>
<cfset lcl.states = getDataItem('states')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>
<!--- billing addr --->
<cfset lcl.form.adddisplayitem('Billing Line 1', lcl.orderinfo.billing_line1)>
<cfset lcl.form.adddisplayitem('Billing Line 2', lcl.orderinfo.billing_line2)>
<cfset lcl.form.adddisplayitem('Billing City', lcl.orderinfo.billing_city)>
<cfset lcl.config = structnew()>
<cfset lcl.config.options = lcl.states>
<cfset lcl.config.addblank = 1>
<cfset lcl.config.blanktext = ''>
<cfset lcl.config.labelskey = 'name'>
<cfset lcl.config.valueskey = 'abbrev'>
<cfset lcl.form.adddisplayitem('Billing State',lcl.orderinfo.billing_state)>
<cfset lcl.countrystuff = structnew()>
<cfset lcl.countrystuff.options = querynew('value,label')>
<cfset queryaddrow(lcl.countrystuff.options)>
<cfset querysetcell(lcl.countrystuff.options,'value','USA')>
<cfset querysetcell(lcl.countrystuff.options,'label','USA')>
<cfset lcl.form.adddisplayitem('Billing Country', 'USA')>
<cfset lcl.form.adddisplayitem('BillingPostal Code',lcl.orderinfo.billing_postalcode)>
<cfset lcl.form.adddisplayitem('Billing Email',lcl.orderinfo.billing_postalcode)>
<!---shipping addr --->
<cfset lcl.form.adddisplayitem('<hr>','<hr>')>
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