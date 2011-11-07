<cfsilent>
	<cfset lcl.info = getDataItem('mdl')>
	<cfset lcl.priceTypes = getDataItem('productPriceTypes')>
	<cfset lcl.prices = getDataItem('productPrices')>
	<cfset lcl.form = createWidget("formcreator")>
	<cfset lcl.options = structnew()>
	<cfset lcl.form.startform()>
	<cfset lcl.form.addformitem('id', 'id', true, 'hidden', lcl.info.getId())>
	
	<cfset lcl.s = structnew()>
	
	<cfloop query="lcl.prices">	
		<cfset lcl.s[type] = structnew()>
		<cfset lcl.s[type].price = price>
		<cfset lcl.s[type].price_sale = price_sale>
		<cfset lcl.s[type].price_member = price_member>
	</cfloop>
	
</cfsilent>

<cfloop query="lcl.pricetypes">
	<cfif structkeyexists(lcl.s, type)>
		<cfset lcl.s2 = duplicate(lcl.s[type])>
	<cfelse>
		<cfset lcl.s2 = structnew()>
		<cfset lcl.s2.price = "">
		<cfset lcl.s2.price_sale = "">
		<cfset lcl.s2.price_member = "">
	</cfif>
	<cfset lcl.form.addcustomformitem("<h3>#type#</h3>")>
	<cfset lcl.form.addformitem('#type#_price', 'Price', true, 'text', decimalformat(lcl.s2.price))>
	<cfset lcl.form.addformitem('#type#_price_sale', 'Sale Price', true, 'text', decimalformat(lcl.s2.price_sale))>
	<cfset lcl.form.addformitem('#type#_price_member', 'Member Price', true, 'text', decimalformat(lcl.s2.price_member))>
</cfloop>

<cfset lcl.form.endform()>
<cfoutput>#lcl.form.showHTML()#</cfoutput>

<p>Sizes are managed via the "Product Sizes" link in the header.</p>
<p>Sale price = 0 or blank means no sale price.</p>

