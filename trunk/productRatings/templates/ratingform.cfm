<cfset lcl.info = getDataItem('ratingsmdl')>	
<cfset lcl.taxobj = getDataItem('taxobj')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = lcl.taxobj.getByTaxonomyId("rating_types")>
<cfset lcl.options.labelskey = "name">
<cfset lcl.options.valueskey = "id">

<cfset lcl.form.startform()>
<cfset lcl.form.addformitem('id', 'id', true, 'hidden', lcl.info.getId())>
<cfset lcl.form.addformitem('productid', 'productid', true, 'hidden', lcl.info.getProductId())>
<cfset lcl.form.addformitem('ratingtype', 'Rating Type', true, 'select', lcl.info.getRatingType(), lcl.options)>
<cfset lcl.form.addformitem('rating', 'Rating(0-100)', true, 'text', lcl.info.getRating())>
<cfset lcl.form.addformitem('ratingtext', 'Rating Text', true, 'tiny-mce', lcl.info.getRatingText())>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = querynew("value,label")>
<cfset queryaddrow(lcl.options.options)>
<cfset querysetcell(lcl.options.options, "value", 1)>
<cfset querysetcell(lcl.options.options, "label", "")>
<cfset lcl.form.addformitem('active', 'Active', true, 'checkbox', lcl.info.getActive(), lcl.options)>
<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>

