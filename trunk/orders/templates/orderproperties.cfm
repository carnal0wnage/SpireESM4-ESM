<cfset lcl.orderinfo = getDataItem('orderinfo')>
<cfset lcl.shipinfo = getDataItem('shipmethod')>
<cfset lcl.payinfo = getDataItem('paymethod')>

<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>
<cfset lcl.form.addformitem('id', 'id', false, 'hidden', lcl.orderinfo.id)>
<cfset lcl.form.addformitem('userid', 'User ID', false, 'hidden', lcl.orderinfo.userid)>
<cfset lcl.statuschoices = "new,pending,paid,deleted">
<cfset lcl.status = structnew()>
<cfset lcl.status.options = querynew('value,label')>
<cfloop list="#lcl.statuschoices#" index="i">
	<cfset queryaddrow(lcl.status.options)>
	<cfset querysetcell(lcl.status.options,'value','#i#')>
    <cfset querysetcell(lcl.status.options,'label','#i#')>
</cfloop>
<cfset lcl.status.style = "margin-left:23px;">
<cfset lcl.form.addformitem('orderStatus', 'Order Status', false, 'select', lcl.orderinfo.orderStatus, lcl.status)>
<cfset lcl.form.adddisplayitem('Order Total',dollarformat(lcl.orderinfo.orderTotal))>
<cfset lcl.form.adddisplayitem('Items Total',lcl.orderinfo.itemsTotal)>
<cfset lcl.form.adddisplayitem('Original Order Date',dateformat(lcl.orderinfo.created,"mm/dd/yy"))>
<cfset lcl.form.adddisplayitem('Last Modified Date',dateformat(lcl.orderinfo.modified,'mm/dd/yy'))>
<cfset lcl.form.adddisplayitem('Delivery Method',lcl.shipinfo.optionlabel)>
<cfif lcl.payinfo.created neq ""><cfset lcl.form.adddisplayitem('Payment Date',dateformat(lcl.payinfo.created,"mm/dd/yy"))></cfif>
<cfif lcl.payinfo.paymentamount neq ""><cfset lcl.form.adddisplayitem('Payment Amount','$'&lcl.payinfo.paymentamount)></cfif>
<Cfset payitems = structnew()>
<cfif isJSON(lcl.payinfo.paymentdetails)>
	<cfset payitems = DeserializeJSON(lcl.payinfo.paymentdetails)>
    <cfset lcl.form.adddisplayitem('Payment Method',payitems.PMTINFO_CARD_TYPE)>
</cfif>

<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>
